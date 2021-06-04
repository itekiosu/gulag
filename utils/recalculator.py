# -*- coding: utf-8 -*-

import asyncio
from pathlib import Path

import aiohttp
import orjson
import re
from cmyui import Ansi
from cmyui import log

from constants.gamemodes import GameMode
from constants.mods import Mods

__all__ = ('PPCalculator',)

BEATMAPS_PATH = Path.cwd() / '.data/osu'

class PPCalculator:
    """Asynchronously wraps the process of calculating difficulty in osu!."""
    def __init__(self, map_id: int, **pp_attrs) -> None:
        # NOTE: this constructor should not be called
        # unless you are CERTAIN the map is on disk
        # for normal usage, use the classmethods
        self.file = f'.data/osu/{map_id}.osu'
        self.pp_attrs = pp_attrs

        if 'mode_vn' in pp_attrs:
            self.mode_vn = pp_attrs['mode_vn']
        else:
            self.mode_vn = 0

    @staticmethod
    async def get_from_osuapi(map_id: int, dest_path: Path) -> bool:
        url = f'https://old.ppy.sh/osu/{map_id}'

        async with aiohttp.ClientSession() as session:
            async with session.get(url) as r:
                if not r or r.status != 200:
                    log(f'Could not find map by id {map_id}!', Ansi.LRED)
                    return False

                content = await r.read()

        dest_path.write_bytes(content)
        return True

    @classmethod
    async def get_file(cls, map_id: int) -> None:
        path = BEATMAPS_PATH / f'{map_id}.osu'

        # check if file exists on disk already
        if not path.exists():
            # not found on disk, try osu!api
            if not await cls.get_from_osuapi(map_id, path):
                # failed to find the map
                return

        # map is now on disk, return filepath.
        return path

    @classmethod
    async def from_id(cls, map_id: int, **pp_attrs):
        # ensure we have the file on disk for recalc
        if not await cls.get_file(map_id):
            return

        return cls(map_id, **pp_attrs)

    async def perform(self) -> tuple[float, float]:
        """Perform the calculations with the current state, returning (pp, sr)."""
        if self.pp_attrs["mode"] > 3:
            # python implementation for oppai (std only), a bit slower but maybe less cursed...
            from utils import pyttanko
            p = pyttanko.parser()
            bmap = pyttanko.beatmap()
            stars = pyttanko.diff_calc()

            with open(self.file, "r") as f:
                p.map(f, bmap=bmap)

            stars.calc(bmap, self.pp_attrs["mods"])

            # thank you pyttanko for maybe the most annoying requirements, please just let me pass accuracy instead of 300/100/50...
            pp, _, _, _, _ = pyttanko.ppv2(stars.aim, stars.speed, bmap=bmap, mods=self.pp_attrs["mods"], n300=self.pp_attrs["n300"], n100=self.pp_attrs["n100"], n50=self.pp_attrs["n50"], nmiss=self.pp_attrs["nmiss"], combo=self.pp_attrs["combo"])
            
            return pp, stars.total
        else:
            cmd = [f'sudo ./osu-tools/compiled/PerformanceCalculator simulate {self.pp_attrs["mode"].calc_mode} {self.file}']

            if self.mode_vn == 0 and "n50" in self.pp_attrs:
                cmd.append(f'-M {self.pp_attrs["n50"]}')

            if self.mode_vn == 3:
                if 'score' in self.pp_attrs:
                    cmd.append(f'-s {self.pp_attrs["score"]}')
            else:
                if 'combo' in self.pp_attrs:
                    cmd.append(f'-c {self.pp_attrs["combo"]}')
                if 'nmiss' in self.pp_attrs:
                    cmd.append(f'-X {self.pp_attrs["nmiss"]}')

            if self.mode_vn not in [2, 3]:
                if 'n100' in self.pp_attrs:
                    cmd.append(f'-G {self.pp_attrs["n100"]}')

            if 'acc' in self.pp_attrs:
                cmd.append(f'-a {self.pp_attrs["acc"]}')

            if 'mr' in self.pp_attrs:
                for mod in re.findall('.{1,2}', self.pp_attrs["mr"]):
                    if mod != 'NM' and mod != 'V2':
                        cmd.append(f'-m {mod}')

            cmd.append('-j')

            # join & run the command
            pipe_calc = asyncio.subprocess.PIPE
            proc_calc = await asyncio.create_subprocess_shell(
                ' '.join(cmd), stdout=pipe_calc, stderr=pipe_calc
            )

            cout, _ = await proc_calc.communicate() # stderr not needed
            calc = orjson.loads(cout.decode())

            await proc_calc.wait() # wait for exit

            # diff calc lawl
            d = [f'sudo ./osu-tools/compiled/PerformanceCalculator difficulty {self.file}']

            d.append(f'--ruleset:{self.mode_vn}') # ruleset in case of converts xd

            if 'mr' in self.pp_attrs:
                for mod in re.findall('.{1,2}', self.pp_attrs["mr"]):
                    if mod != 'NM' and mod != 'V2':
                        d.append(f'-m {mod}')

            pipe_diff = asyncio.subprocess.PIPE
            proc_diff = await asyncio.create_subprocess_shell(' '.join(d), stdout=pipe_diff, stderr=pipe_diff)

            dout, _ = await proc_diff.communicate()

            if not (sr := float((re.findall('\d+(?:\.\d+)?', dout.decode()))[-1])):
                sr = 0.0

            if not (pp := calc.get('pp')):
                pp = 0.0

            await proc_diff.wait()
            return pp, sr
