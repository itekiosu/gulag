import asyncio
import cmyui
import config
import os.path
from pathlib import Path
from utils.recalculator import PPCalculator
from constants.mods import Mods
from circleparse import parse_replay_file

async def recalc():
        db = cmyui.AsyncSQLPool()
        await db.connect(config.mysql)
        for table in ('scores_vn', 'scores_rx', 'scores_ap'):
            async for e in db.iterall(f'SELECT id, score FROM {table} WHERE mode = 0'):
                sid = e['id']
                score = e['score']
                REPLAYS_PATH = Path.cwd() / '.data/osr'
                REPLAYS_PATH_RX = Path.cwd() / '.data/osr_rx'
                REPLAYS_PATH_AP = Path.cwd() / '.data/osr_ap'
                replay_file = REPLAYS_PATH / f'{sid}.osr'
                if replay_file.exists():
                    filee = replay_file
                else:
                    replay_file = REPLAYS_PATH_RX / f'{sid}.osr'

                if replay_file.exists():
                    filee = replay_file
                else:
                    replay_file = REPLAYS_PATH_AP / f'{sid}.osr'

                if replay_file.exists():
                    filee = replay_file

                #try:
                print(filee)
                e = parse_replay_file(filee)
                ns = e.score
                print(f'Score changed by replay to {ns}')
                #except:
                    #ns = score
                    #print(f'Score unchanged, exception occured.')
                await db.execute(f'UPDATE {table} SET score = {ns} WHERE id = {sid}')

loop = asyncio.get_event_loop()
loop.run_until_complete(recalc())