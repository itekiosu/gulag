# -*- coding: utf-8 -*-

import asyncio
from pathlib import Path

import aiohttp
import orjson
from cmyui import Ansi
from cmyui import log

from maniera.calculator import Maniera

from constants.gamemodes import GameMode
from constants.mods import Mods

__all__ = ('PPCalculator',)

BEATMAPS_PATH = Path.cwd() / '.data/osu'

class PPCalculator:
    """Asynchronously wraps the process of calculating difficulty in osu!."""
    def __init__(self, map_id: int, **kwargs) -> None:
        # NOTE: this constructor should not be called
        # unless you are CERTAIN the map is on disk
        # for normal usage, use the classmethods
        self.file = f'.data/osu/{map_id}.osu'

        self.mods = kwargs.get('mods', Mods.NOMOD)
        self.score = kwargs.get('score', 0)
        self.combo = kwargs.get('combo', 0)
        self.nmiss = kwargs.get('nmiss', 0)
        self.mode = kwargs.get('mode', GameMode.vn_std)
        self.acc = kwargs.get('acc', 100.00)

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
    async def from_id(cls, map_id: int, **kwargs):
        # ensure we have the file on disk for recalc
        if not await cls.get_file(map_id):
            return

        return cls(map_id, **kwargs)

    async def perform(self) -> tuple[float, float]:
        """Perform the calculations with the current state, returning (pp, sr)."""

        # std and taiko.
        if self.mode.as_vanilla in (0, 1):
            # TODO: PLEASE rewrite this with c bindings,
            # add ways to get specific stuff like aim pp

            # for now, we'll generate a bash command and
            # use subprocess to do the calculations (yikes).
            cmd = [f'sudo ./oppai-ng/oppai {self.file}']

            # ?????????
            plus = '+'
            if self.mods:  cmd.append(f'{plus}{repr(self.mods)}')

            if self.combo: cmd.append(f'{self.combo}x')
            if self.nmiss: cmd.append(f'{self.nmiss}xM')
            if self.acc:   cmd.append(f'{self.acc:.4f}%')

            if self.mode:
                mode_vn = self.mode.as_vanilla

                if self.mode == GameMode.vn_taiko or self.mode == GameMode.rx_taiko:
                    cmd.append('-m1')
                else:
                    cmd.append(f'-m{mode_vn}')
                if self.mode == GameMode.vn_taiko or self.mode == GameMode.rx_taiko:
                    cmd.append('-taiko')

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
            return output['pp'], output['stars']
        
        # mania.
        elif self.mode.as_vanilla == 3:
            # You can see what calculations are done here:
            # https://github.com/NiceAesth/maniera/blob/master/maniera/calculator.py
            calc = Maniera(self.file, self.mods, self.score)
            await asyncio.get_event_loop().run_in_executor(None, calc.calculate)
            return calc.pp, calc.sr

        # TODO: osu!catch support
        else:
            return
