# -*- coding: utf-8 -*-

from re import compile as rcomp
from re import IGNORECASE

from objects import glob

__all__ = ('mapfile', 'osu_ver', 'username', 'email', 'now_playing')
_domain_escaped = glob.config.domain.replace('.', r'\.')

mapfile = rcomp(r'^(?P<artist>.+) - (?P<title>.+) \((?P<creator>.+)\) \[(?P<version>.+)\]\.osu$')
osu_ver = rcomp(r'^b(?P<ver>\d{8})(?:\.(?P<subver>\d))?(?:beta|cuttingedge|dev|iteki)?$')
username = rcomp(r'^[\w \[\]-]{2,15}$')
email = rcomp(r'^[^@\s]{1,200}@[^@\s\.]{1,30}\.[^@\.\s]{2,24}$')
now_playing = rcomp(
    r'^\x01ACTION is (?:playing|editing|watching|listening to) '
    rf'\[https://osu\.(?:{_domain_escaped}|ppy\.sh)/beatmapsets/(?P<sid>\d{{1,10}})#/?(?:osu|taiko|fruits|mania)?/(?P<bid>\d{{1,10}})/? .+\]'
    r'(?: <(?P<mode_vn>Taiko|CatchTheBeat|osu!mania)>)?'
    r'(?P<mods>(?: (?:-|\+|~|\|)\w+(?:~|\|)?)+)?\x01$'
)

silence_duration = rcomp(
    r'^(?P<duration>\d{1,6})'
    r'(?P<scale>s|m|h|d|w)$'
)
tourney_matchname = rcomp(
    r'^(?P<name>[a-zA-Z0-9_ ]+): '
    r'\((?P<T1>[a-zA-Z0-9_ ]+)\) vs\.? '
    r'\((?P<T2>[a-zA-Z0-9_ ]+)\)$',
    flags = IGNORECASE
)
mappool_pick = rcomp(r'^([a-zA-Z]+)([0-9]+)$')
