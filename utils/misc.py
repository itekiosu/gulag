# -*- coding: utf-8 -*-

import inspect
from pathlib import Path
from typing import Sequence

import cmyui
import objects.glob as glob
from cmyui.logging import Ansi
from cmyui.logging import log
from cmyui.logging import printc
from cmyui.osu.replay import Keys
from cmyui.osu.replay import ReplayFrame

from objects import glob

__all__ = (
    'geoloc_fetch',
    'point_of_interest',
    'get_average_press_times',
    'make_safe_name'
)

async def geoloc_fetch(ip_addr: str):
    """Make http (slow) request to get geolocalization.
    
    Params:
        - ip_addr: str = IP address of user that geoloc has been requested.
    Returns:
        Tuple of (country, lat, long)
    """

    url = f'http://ip-api.com/line/{ip_addr}'

    async with glob.http.get(url) as resp:
        if not resp or resp.status != 200:
            log('Failed to get geoloc data: request failed.', Ansi.LRED)
            return ("XX", 0.0, 0.0)

        status, *lines = (await resp.text()).split('\n')

        if status != 'success':
            log(f'Failed to get geoloc data: {lines[0]}.', Ansi.LRED)
            return ("XX", 0.0, 0.0)

        return (lines[1], float(lines[6]), float(lines[7])) # Country, lat, long

def point_of_interest():
    """Leave a pseudo-breakpoint somewhere to ask the user if
       they could pls submit their stacktrace to tsunyoku <3."""

    ver_str = f'Running gulag v{glob.version!r} | cmyui_pkg v{cmyui.__version__}'
    printc(ver_str, Ansi.LBLUE)

    for fi in inspect.stack()[1:]:
        if fi.function == '_run':
            # go all the way up to server start func
            break

        file = Path(fi.filename)

        # print line num, index, func name & locals for each frame.
        log('[{function}() @ {fname} L{lineno}:{index}] {frame.f_locals}'.format(
            **fi._asdict(), fname=file.name
        ))

    msg_str = '\n'.join((
        "Hey! If you're seeing this, osu! just did something pretty strange,",
        "and the gulag devs have left a breakpoint here. We'd really appreciate ",
        "if you could screenshot the data above, and send it to tsunyoku via ",
        "Discord (tsunyoku#8551). Thanks! 😳😳😳"
    ))

    printc(msg_str, Ansi.LRED)
    input('To close this menu & unfreeze, simply hit the enter key.')

useful_keys = (Keys.M1, Keys.M2,
               Keys.K1, Keys.K2)

def get_press_times(frames: Sequence[ReplayFrame]) -> dict[Keys, float]:
    """A very basic function to press times of an osu! replay.
       This is mostly only useful for taiko maps, since it
       doesn't take holds into account (taiko has none).

       In the future, we will make a version that can take
       account for the type of note that is being hit, for
       much more accurate and useful detection ability.
    """
    # TODO: remove negatives?
    press_times = {key: [] for key in useful_keys}
    cumulative = {key: 0 for key in useful_keys}

    prev_frame = frames[0]

    for frame in frames[1:]:
        for key in useful_keys:
            if frame.keys & key:
                # key pressed, add to cumulative
                cumulative[key] += frame.delta
            elif prev_frame.keys & key:
                # key unpressed, add to press times
                press_times[key].append(cumulative[key])
                cumulative[key] = 0

        prev_frame = frame

    # return all keys with presses
    return {k: v for k, v in press_times.items() if v}

def make_safe_name(name: str) -> str:
    """Return a name safe for usage in sql."""
    return name.lower().replace(' ', '_')
