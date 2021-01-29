import cmyui
import asyncio
import config
from enum import IntEnum

class Mods(IntEnum):
    NOMOD = 0
    NOFAIL = 1 << 0
    EASY = 1 << 1
    TOUCHSCREEN = 1 << 2
    HIDDEN = 1 << 3
    HARDROCK = 1 << 4
    SUDDENDEATH = 1 << 5
    DOUBLETIME = 1 << 6
    RELAX = 1 << 7
    HALFTIME = 1 << 8
    NIGHTCORE = 1 << 9
    FLASHLIGHT = 1 << 10
    AUTOPLAY = 1 << 11
    SPUNOUT = 1 << 12
    RELAX2 = 1 << 13
    PERFECT = 1 << 14
    KEY4 = 1 << 15
    KEY5 = 1 << 16
    KEY6 = 1 << 17
    KEY7 = 1 << 18
    KEY8 = 1 << 19
    KEYMOD = 1 << 20
    FADEIN = 1 << 21
    RANDOM = 1 << 22
    LASTMOD = 1 << 23
    KEY9 = 1 << 24
    KEY10 = 1 << 25
    KEY1 = 1 << 26
    KEY3 = 1 << 27
    KEY2 = 1 << 28
    SCOREV2 = 1 << 29

def mods_readable(m: int) -> str:
    if not m: return 'NM'

    r: List[str] = []
    if m & Mods.NOFAIL:      r.append('NF')
    if m & Mods.EASY:        r.append('EZ')
    if m & Mods.HIDDEN:      r.append('HD')
    if m & Mods.NIGHTCORE:   r.append('NC')
    elif m & Mods.DOUBLETIME:  r.append('DT')
    if m & Mods.HARDROCK:    r.append('HR')
    if m & Mods.HALFTIME:    r.append('HT')
    if m & Mods.FLASHLIGHT:  r.append('FL')
    if m & Mods.SPUNOUT:     r.append('SO')
    if m & Mods.RELAX:       r.append('RX')
    if m & Mods.RELAX2:       r.append('AP')
    if m & Mods.TOUCHSCREEN: r.append('TD')
    if m & Mods.SCOREV2:     r.append('V2')
    return ''.join(r)

async def convert_mods():
    db = cmyui.AsyncSQLPool()
    await db.connect(config.mysql)
    async for e in db.iterall("SELECT id, mods FROM scores_vn"):
        mods = mods_readable(int(e['mods']))
        if config.debug:
            print(f"Score {e['id']}: +{mods}")
        await db.execute("UPDATE scores_vn SET mods_readable = %s WHERE id = %s", [mods, e['id']])
    async for e in db.iterall("SELECT id, mods FROM scores_rx"):
        mods = mods_readable(int(e['mods']))
        if config.debug:
            print(f"Score {e['id']}: +{mods}")
        await db.execute("UPDATE scores_rx SET mods_readable = %s WHERE id = %s", [mods, e['id']])
    async for e in db.iterall("SELECT id, mods FROM scores_ap"):
        mods = mods_readable(int(e['mods']))
        if config.debug:
            print(f"Score {e['id']}: +{mods}")
        await db.execute("UPDATE scores_ap SET mods_readable = %s WHERE id = %s", [mods, e['id']])

asyncio.run(convert_mods())
