import asyncio
import cmyui
import config
import datetime
from datetime import timezone

async def main():
    db = cmyui.AsyncSQLPool()
    await db.connect(config.mysql)
    for table in ('scores_vn', 'scores_rx', 'scores_ap'):
        async for uid in db.iterall(f'SELECT id, play_time FROM {table}'):
            playtime = str(uid['play_time'])
            scoreid = uid['id']
            year = int(playtime[:4])
            month = int(playtime[5:-12])
            day = int(playtime[8:-9])
            hour = int(playtime[-8:-6])
            minutes  = int(playtime[-5:-3])
            seconds = int(playtime[-2:])
            dt = datetime.datetime(year, month, day, hour, minutes, seconds)
            timestamp = dt.replace(tzinfo=timezone.utc).timestamp()
            print(round(timestamp))
            await db.execute(f'UPDATE {table} SET play_time = {round(timestamp)} WHERE id = {scoreid}')

asyncio.run(main())