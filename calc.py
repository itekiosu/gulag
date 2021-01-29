import asyncio
import cmyui
import config
from utils.recalculator import PPCalculator
from constants.mods import Mods

async def recalc():
        db = cmyui.AsyncSQLPool()
        await db.connect(config.mysql)
        score_counts = []
        async for bmap in db.iterall('SELECT id, md5 FROM maps WHERE status = 2 AND passes > 0'):
            ppcalc = await PPCalculator.from_id(bmap['id'])
            if not ppcalc:
                return 'Could not retrieve map file.'

            print(f"Performing full recalc on map {bmap['id']}.")

            for table in ('scores_vn', 'scores_rx', 'scores_ap'):
                # fetch all scores from the table on this map
                scores = await db.fetchall(
                    'SELECT id, acc, mods, max_combo, '
                    'n300, n100, n50, nmiss, ngeki, nkatu '
                    f'FROM {table} WHERE map_md5 = %s '
                    'AND status = 2 AND mode = 0',
                    [bmap['md5']]
                )

                score_counts.append(len(scores))

                if not scores:
                    continue

                for score in scores:
                    ppcalc.mods = Mods(score['mods'])
                    ppcalc.combo = score['max_combo']
                    ppcalc.nmiss = score['nmiss']
                    ppcalc.acc = score['acc']

                    pp, _ = await ppcalc.perform() # sr not needed

                    await db.execute(
                        f'UPDATE {table} '
                        'SET pp = %s '
                        'WHERE id = %s',
                        [pp, score['id']]
                    )

asyncio.run(recalc())