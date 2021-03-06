# -*- coding: utf-8 -*-

from datetime import datetime
from enum import IntEnum
from enum import unique

from objects import glob

__all__ = ('Clan', 'ClanRank')

@unique
class ClanRank(IntEnum):
    """A class to represent a clan members rank."""
    Member = 1
    Officer = 2
    Owner = 3

class Clan:
    """A class to represent a single gulag clan."""
    __slots__ = ('id', 'name', 'tag', 'created_at',
                 'owner', 'members', 'description')

    def __init__(self, id: int, name: str, tag: str,
                 created_at: datetime, owner: int,
                 members: set[int] = set(), description: str = '') -> None:
        """A class representing one of gulag's clans."""
        self.id = id
        self.name = name
        self.tag = tag
        self.created_at = created_at
        self.description = description

        self.owner = owner # userid
        self.members = members # userids

    async def members_from_sql(self) -> None:
        """Fetch all members from sql."""
        # TODO: in the future, we'll want to add
        # clan 'mods', so fetching rank here may
        # be a good idea to sort people into
        # different roles.
        res = await glob.db.fetchall(
            'SELECT id FROM users '
            'WHERE clan_id = %s',
            [self.id], _dict=False
        )

        if res:
            self.members.update(*res)

    def __repr__(self) -> str:
        return f'[{self.tag}] {self.name}'
