import asyncio
import cmyui
import config

async def main():
    db = cmyui.AsyncSQLPool()
    await db.connect(config.mysql)
    for table in ('scores_vn', 'scores_rx', 'scores_ap'):
        async for uid in db.iterall(f'SELECT id, score, score_ver, mods_readable FROM {table}'):
            score = uid['score']
            scoreid = uid['id']
            score_ver = uid['score_ver']
            mods = uid['mods_readable']
            if int(score_ver) != 2:
                #do stuff here
                if "RX" in mods:
                    ns = score * 5.41284210526
                if "HD" in mods:
                    ns = score // 1.02912621359
                if "HD" not in mods and "RX" not in mods:
                    ns = score
                await db.execute(f'UPDATE {table} SET score = {ns} WHERE id = {scoreid}')

asyncio.run(main())