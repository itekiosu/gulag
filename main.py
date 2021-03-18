#!/usr/bin/python3.9
# -*- coding: utf-8 -*-

import lzma
import os
import sys
import sys
sys._excepthook = sys.excepthook # backup
def _excepthook(type, value, traceback):
    if type is KeyboardInterrupt:
        print('\33[2K\r', end='Aborted startup.')
        return
    print('\x1b[0;31mgulag ran into an issue '
          'before starting up :(\x1b[0m')
    sys._excepthook(type, value, traceback)
sys.excepthook = _excepthook
import time
from pathlib import Path
from typing import TYPE_CHECKING

import aiohttp
import cmyui
import datadog
import threading
import subprocess
import orjson # go zoom
from cmyui import Ansi
from cmyui import log
from cmyui.discord import Embed
from cmyui.discord import Webhook
from cmyui.osu import ReplayFrame

import packets
from constants.gamemodes import GameMode
from constants.privileges import Privileges
from objects import glob
from objects.achievement import Achievement
from objects.channel import Channel
from objects.clan import Clan
from objects.match import MapPool
from objects.player import Player
from objects.collections import *
from utils.misc import get_press_times
from utils.updater import Updater

if TYPE_CHECKING:
    from objects.score import Score

__all__ = ()

# current version of gulag
glob.version = cmyui.Version(3, 3, 3)

async def setup_collections() -> None:
    """Setup & cache many global collections (mostly from sql)."""
    # create our bot & append it to the global player list.
    res = await glob.db.fetch('SELECT name FROM users WHERE id = 1')

    # global players list
    glob.players = PlayerList()

    glob.bot = Player(
        id = 1, name = res['name'], priv = Privileges.Normal,
        last_recv_time = float(0x7fffffff) # never auto-dc
    )
    glob.players.append(glob.bot)

    # global channels list
    glob.channels = ChannelList()
    async for res in glob.db.iterall('SELECT * FROM channels'):
        chan = Channel(
            name = res['name'],
            topic = res['topic'],
            read_priv = Privileges(res['read_priv']),
            write_priv = Privileges(res['write_priv']),
            auto_join = res['auto_join'] == 1
        )

        glob.channels.append(chan)

    # global matches list
    glob.matches = MatchList()

    # global clans list
    glob.clans = ClanList()
    async for res in glob.db.iterall('SELECT * FROM clans'):
        clan = Clan(**res)

        await clan.members_from_sql()
        glob.clans.append(clan)

    # global mappools list
    glob.pools = MapPoolList()
    async for res in glob.db.iterall('SELECT * FROM tourney_pools'):
        pool = MapPool(
            id = res['id'],
            name = res['name'],
            created_at = res['created_at'],
            created_by = await glob.players.get_ensure(id=res['created_by'])
        )

        await pool.maps_from_sql()
        glob.pools.append(pool)

    # global achievements (sorted by vn gamemodes)
    glob.achievements = {0: [], 1: [], 2: [], 3: []}
    async for res in glob.db.iterall('SELECT `id`, `file`, `name`, `desc`, `cond`, `mode` FROM achievements'):
        # NOTE: achievement conditions are stored as
        # stringified python expressions in the database
        # to allow for easy custom achievements.
        condition = eval(f'lambda score: {res.pop("cond")}')
        achievement = Achievement(**res, cond=condition)

        # NOTE: achievements are grouped by modes internally.
        glob.achievements[res['mode']].append(achievement)

    """ XXX: Unfinished code for beatmap submission.
    # get the latest set & map id offsets for custom maps.
    maps_res = await glob.db.fetch(
        'SELECT id, set_id FROM maps '
        'WHERE server = "gulag" '
        'ORDER BY id ASC LIMIT 1'
    )
    if maps_res:
        glob.gulag_maps = maps_res
    """

async def after_serving() -> None:
    """Called after the server stops serving connections."""
    await glob.http.close()
    await glob.db.close()

    if glob.datadog:
        glob.datadog.stop()

nc = []

async def before_serving() -> None:
    """Called before the server begins serving connections."""
    # retrieve a client session to use for http connections.
    glob.http = aiohttp.ClientSession(json_serialize=orjson.dumps)

    # retrieve a pool of connections to use for mysql interaction.
    glob.db = cmyui.AsyncSQLPool()
    await glob.db.connect(glob.config.mysql)

    # run the sql & submodule updater (uses http & db).
    updater = Updater(glob.version)
    await updater.run()
    await updater.log_startup()

    # cache many global collections/objects from sql,
    # such as channels, mappools, clans, bot, etc.
    await setup_collections()

    # add new donation ranks & enqueue tasks to remove current ones.
    # TODO: this system can get quite a bit better; rather than just
    # removing, it should rather update with the new perks (potentially
    # a different tier, enqueued after their current perks).

    async def rm_donor(userid: int, when: int):
        if (delta := when - time.time()) >= 0:
            await asyncio.sleep(delta)

        p = await glob.players.get(id=userid, sql=True)

        # TODO: perhaps make a `revoke_donor` method?
        await p.remove_privs(Privileges.Donator)
        await glob.db.execute(
            'UPDATE users '
            'SET donor_end = 0 '
            'WHERE id = %s',
            [p.id]
        )

        if p.online:
            p.enqueue(packets.notification('Your supporter status has expired.'))

        log(f"{p}'s supporter status has expired.", Ansi.MAGENTA)

    async def freeze_user(userid: int, when: int):
        if (delta := when - time.time()) >= 0:
            await asyncio.sleep(delta)

        p = await glob.players.get(id=userid, sql=True)

        await p.ban(glob.bot, 'expired freeze timer')
        await glob.db.execute(
            'UPDATE users '
            'SET frozen = 0 '
            'WHERE id = %s',
            [p.id]
        )

        if p.online:
            p.enqueue(packets.notification('Your freeze timer expired and you did not present a liveplay. You are now banned!'))

        log(f"{p}'s freeze timer has ran out and has been banned as a result", Ansi.MAGENTA)

    # enqueue rm_donor for any supporter
    # expiring in the next 30 days.
    query = (
        'SELECT id, donor_end FROM users '
        'WHERE donor_end < DATE_ADD(NOW(), INTERVAL 30 DAY) '
        'AND priv & 48' # 48 = Supporter | Premium
    )
    query2 = (
        'SELECT id, freezetime FROM users '
        'WHERE freezetime < DATE_ADD(NOW(), INTERVAL 1 DAY) '
        'AND frozen = 1'
    )

    async for donation in glob.db.iterall(query, _dict=False):
        nc.append(rm_donor(*donation))

    async for cheater in glob.db.iterall(query2, _dict=False):
        nc.append(freeze_user(*cheater))

PING_TIMEOUT = 300000 // 1000
async def disconnect_inactive() -> None:
    """Actively disconnect users above the
       disconnection time threshold on the osu! server."""
    players_lock = asyncio.Lock()

    while True:
        ctime = time.time()

        async with players_lock:
            for p in glob.players:
                if ctime - p.last_recv_time > PING_TIMEOUT:
                    await p.logout()

        # run this indefinitely
        await asyncio.sleep(PING_TIMEOUT // 3)

# This function is currently pretty tiny and useless, but
# will just continue to expand as more ideas come to mind.
async def analyze_score(score: 'Score') -> None:
    """Analyze a single score."""
    player = score.player

    # open & parse replay files frames
    replay_file = REPLAYS_PATH / f'{score.id}.osr'
    data = lzma.decompress(replay_file.read_bytes())

    frames: list[ReplayFrame] = []

    # ignore seed & blank line at end
    for action in data.decode().split(',')[:-2]:
        if frame := ReplayFrame.from_str(action):
            frames.append(frame)

    if score.mode.as_vanilla == GameMode.vn_taiko:
        # calculate their average press times.
        # NOTE: this does not currently take hit object
        # type into account, making it completely unviable
        # for any gamemode with holds. it's still relatively
        # reliable for taiko though :D.

        press_times = get_press_times(frames)
        config = glob.config.surveillance['hitobj_low_presstimes']

        cond = lambda pt: (sum(pt) / len(pt) < config['value']
                           and len(pt) > config['min_presses'])

        if any(map(cond, press_times.values())):
            # at least one of the keys is under the
            # minimum, log this occurence to Discord.
            webhook_url = glob.config.webhooks['surveillance']
            webhook = Webhook(url=webhook_url)

            embed = Embed(
                title = f'[{score.mode!r}] Abnormally low presstimes detected'
            )

            embed.set_author(
                url = player.url,
                name = player.name,
                icon_url = player.avatar_url
            )

            # TODO: think of a way to organize a thumbnail into config?
            thumb_url = 'https://akatsuki.pw/static/logos/logo.png'
            embed.set_thumbnail(url=thumb_url)

            for key, pt in press_times.items():
                embed.add_field(
                    name = f'Key: {key.name}',
                    value = f'{sum(pt) / len(pt):.2f}ms' if pt else 'N/A',
                    inline = True
                )

            webhook.add_embed(embed)
            await webhook.post()

REPLAYS_PATH = Path.cwd() / '.data/osr'
async def run_detections() -> None:
    """Actively run a background thread throughout gulag's
       lifespan; it will pull replays determined as sketch
       from a queue indefinitely."""
    glob.sketchy_queue = asyncio.Queue() # cursed type hint fix
    queue: asyncio.Queue['Score'] = glob.sketchy_queue

    loop = asyncio.get_running_loop()

    while score := await queue.get():
        loop.create_task(analyze_score(score))

async def update_stats():
    try:
        res = await glob.db.fetch('SELECT COUNT(id) AS users FROM users')
        total_users = int(res['users'])
        await glob.db.execute(f'UPDATE server_stats SET online = {len(glob.players)}')
        await glob.db.execute(f'UPDATE server_stats SET total = {total_users}')
        await asyncio.sleep(30)
    except AttributeError:
        await asyncio.sleep(10)
        res = await glob.db.fetch('SELECT COUNT(id) AS users FROM users')
        total_users = int(res['users'])
        await glob.db.execute(f'UPDATE server_stats SET online = {len(glob.players)}')
        await glob.db.execute(f'UPDATE server_stats SET total = {total_users}')

if __name__ == '__main__':
    # make sure nginx & mysqld are running.
    if not os.path.exists('/var/run/mysqld/mysqld.pid'):
        sys.exit('Please start your mysqld server.')
    if not os.path.exists('/var/run/nginx.pid'):
        sys.exit('Please start your nginx server.')
                         
    asyncio.set_debug(True)         

    # set cwd to /gulag.
    os.chdir(os.path.dirname(os.path.realpath(__file__)))

    # create /.data and its subdirectories.
    data_path = Path.cwd() / '.data'
    data_path.mkdir(exist_ok=True)

    for sub_dir in ('avatars', 'logs', 'osu', 'osr', 'ss', 'osr_rx', 'osr_ap'):
        subdir = data_path / sub_dir
        subdir.mkdir(exist_ok=True)

    app = cmyui.Server(name=f'gulag v{glob.version}',
                       gzip=4, verbose=glob.config.debug)

    # add our domains & tasks
    from domains.cho import domain as cho_domain # c[e4-6]?.ppy.sh
    from domains.osu import domain as osu_domain # osu.ppy.sh
    from domains.ava import domain as ava_domain # a.ppy.sh
    app.add_domains({cho_domain, osu_domain, ava_domain})
    nc.append(disconnect_inactive())
    nc.append(run_detections())
    for c in nc:
        app.add_pending_task(c)

    app.before_serving = before_serving
    app.after_serving = after_serving

    # support for https://datadoghq.com
    if all(glob.config.datadog.values()):
        datadog.initialize(**glob.config.datadog)

        # NOTE: this will start datadog's
        #       client in another thread.
        glob.datadog = datadog.ThreadStats()
        glob.datadog.start(flush_interval=15)

        # set some base values
        glob.datadog.gauge('gulag.online_players', 0)
    else:
        glob.datadog = None

    app.add_pending_task(update_stats())
    app.run(glob.config.server_addr, handle_signals=True, sigusr1_restart=True) # blocking call
