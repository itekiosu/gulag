# -*- coding: utf-8 -*-

import re
from pathlib import Path

from cmyui import Connection
from cmyui import Domain

""" ava: avatar server (for both ingame & external) """

domain = Domain('a.ppy.sh')

AVATARS_PATH = Path.cwd() / '.data/avatars'
DEFAULT_AVATAR = AVATARS_PATH / 'default.png'
@domain.route(re.compile(r'^/\d{1,10}(?:\.png)?$'))
async def get_avatar(conn: Connection) -> None:
    path = AVATARS_PATH / f'{conn.path[1:]}.png'

    if not path.exists():
        path = DEFAULT_AVATAR

    await conn.send(200, path.read_bytes())
