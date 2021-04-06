# -*- coding: utf-8 -*-

import asyncio
from pathlib import Path

import aiohttp
import orjson
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
            self.mode_vn = ppattrs['mode_vn']
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
        if self.mode_vn == 0:
            # python implementation for oppai (std only), a bit slower but maybe less cursed...
            import pyttanko
            p = pyttanko.parser()
            bmap = pyytanko.beatmap()
            stars = pyttanko.diff_calc()

            stars.calc(self.file, self.pp_attrs["mods"])

            # thank you pyttanko for maybe the most annoying requirements, please just let me pass accuracy instead of 300/100/50...
            pp, _, _, _, _ = pyttanko.ppv2(stars.aim, stars.speed, bmap=self.file, mods=self.pp_attrs["mode"], n300=self.pp_attrs["n300"], n100=self.pp_attrs["n100"], n50=self.pp_attrs["n50"], nmiss=self.pp_attrs["nmiss"], combo=self.pp_attrs["combo"])
            
            return pp, stars.total
        elif self.mode_vn == 1:
            # normal oppai for taiko bc pyttanko gay
            cmd = [f'sudo ./oppai-ng/oppai {self.file}']

            if 'mods' in self.pp_attrs:
                cmd.append(f'+{self.pp_attrs["mods"]!r}')
            if 'combo' in self.pp_attrs:
                cmd.append(f'{self.pp_attrs["combo"]}x')
            if 'nmiss' in self.pp_attrs:
                cmd.append(f'{self.pp_attrs["nmiss"]}xM')
            if 'acc' in self.pp_attrs:
                cmd.append(f'{self.pp_attrs["acc"]:.4f}%')

            cmd.append('-m1')

            # XXX: could probably use binary to save a bit
            # of time.. but in reality i should just write
            # some bindings lmao this is so cursed overall
            cmd.append('-ojson')

            # join & run the command
            pipe = asyncio.subprocess.PIPE

            proc = await asyncio.create_subprocess_shell(
                ' '.join(cmd), stdout=pipe, stderr=pipe
            )

            stdout, _ = await proc.communicate() # stderr not needed
            output = orjson.loads(stdout.decode())

            if 'code' not in output or output['code'] != 200:
                log(f"oppai-ng: {output['errstr']}", Ansi.LRED)

            await proc.wait() # wait for exit
            try:
                return output['pp'], output['stars']
            except:
                return (0.0, 0.0)
        if self.mode_vn == 3:
            #mania.
            from maniera.calculator import Maniera
            if 'score' not in self.pp_attrs:
                log('Err: pp calculator needs score for mania.', Ansi.LRED)
                return (0.0, 0.0)

            if 'mods' in self.pp_attrs:
                mods = int(self.pp_attrs['mods'])
            else:
                mods = 0

            calc = Maniera(self.file, mods, self.pp_attrs['score'])
            calc.calculate()
            return (calc.pp, calc.sr)

        if self.mode_vn == 2:
            return (0.0, 0.0)
