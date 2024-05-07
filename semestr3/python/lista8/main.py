import asyncio
import aiohttp
from prywatne import api_key


async def fetch_data(url, headers=None):
    async with aiohttp.ClientSession() as session:
        async with session.get(url, headers=headers) as response:
            if response.status != 200:
                raise FetchDataError(url, response.status)
            return await response.text()


class FetchDataError(Exception):
    def __init__(self, url, status_code):
        self.url = url
        self.status_code = status_code
        super().__init__(f"Problem przy pobieraniu danych z {url}. Kod statusu: {status_code}")


def increment_base_id(base_id_str):  # dodawanie 1 do id. Funkcja zrobiona po to, zeby nie bylo problemu z 0 na poczatku
    numeric_part = str(int(base_id_str) + 1)
    return numeric_part.zfill(len(base_id_str))


async def main():
    tasks = []
    base_id = "0903747"  # numer breaking bad na imdb (jeszcze tt w url'u nizej)
    base_url_auth = "https://moviesdatabase.p.rapidapi.com/titles/series/tt"
    url_no_auth = "https://jsonplaceholder.typicode.com/posts/1"

    headers_for_url_with_auth = {
        'X-RapidAPI-Key': api_key
    }

    for x in range(100):  # większość z tych id nie istnieje :( Ale przynajmniej widac, ze pobieranie pustych danych jest szybkie.
        url_with_auth = base_url_auth + base_id
        base_id = increment_base_id(base_id)

        task1 = asyncio.create_task(fetch_data(url_with_auth, headers=headers_for_url_with_auth))
        tasks.append(task1)
        task2 = asyncio.create_task(fetch_data(url_no_auth))  # stad dane sa pobierane o wiele szybciej
        tasks.append(task2)

    for completed in asyncio.as_completed(tasks): # uzywajac as_completed widac, ze w wyniku nie dostajemy par task1 task2, tak jak dodawalismy do tasks[]. Kolejnosc zalezy od szybkosci wykonania.
        try:
            result = await completed
            print("Dane: ", result)
        except FetchDataError as e:
            print(f"Error: {e}")

# z jakiegos powodu bez tego czegos program nie chce dzialac na Windowsie u mnie :(
# asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy())

asyncio.run(main())
