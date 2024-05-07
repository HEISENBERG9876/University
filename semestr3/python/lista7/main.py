from collections import defaultdict, Counter
from bs4 import BeautifulSoup
import threading
import requests
import re


# zwraca liste zawierajaca wszystkie slowa znajdujace sie na stronie albo error, gdy nie otrzymalismy odpowiedzi
def get_parsed_text_from_url(url):
    response = requests.get(url)
    if response.status_code == 200:
        unparsed_text = response.text
        soup = BeautifulSoup(unparsed_text, 'html.parser')
        return re.findall(r'\w+', soup.get_text().lower())
    else:
        raise ValueError(f"Niepoprawna nazwa strony {url} lub strona nie odpowiada")


# tworzymy index- pod kluczami w slowniku (slowami) znajduje sie licznik z nazwami stron i iloscia wystapien danego slowa na tej stronie.
def create_index(list_of_url):
    index_lock = threading.Lock()  # slownik nie jest "bezpieczna" struktura z watkami, wiec dla pewnosci robimy lock.
    index = defaultdict(Counter) # zmienione z defaultdict(list), zeby miec tani dostep do ilosci wystapien danych slow.
    threads = []

    def manage_url(url):  # te czynnosci bedziemy robic w wielu watkach. To i kod ponizej to praktycznie jedynie zmiany.
        word_list = get_parsed_text_from_url(url)
        with index_lock:
            for word in word_list:
                index[word].update([url])  # podajemy liste, inaczej Counter traktuje stringa jako iterable i dodaje pojedyncze litery jako klucze

    for url in list_of_url:
        thread = threading.Thread(target=manage_url, args=(url,))
        threads.append(thread)
        thread.start()

    for thread in threads:  # wynik zwracamy dopiero, gdy wszystkie watki zakoncza swoja prace
        thread.join()

    return dict(index)


# index[word].most_common(1) zwraca liste z tupla. [0] bierze pierwszy element tej listy, czyli tuple (najpopularniejsza
# strona dla danego slowa, ilosc wystapien tego slowa). Kolejne [0] bierze nazwe strony z tupli.
def get_most_popular_website(index, word):
    return index[word].most_common(1)[0][0] if word in index else None


# test
i = create_index(["https://www.york.ac.uk/teaching/cws/wws/webpage1.html", "https://www.speedtest.net/pl"])
i2 = create_index([])

print(i)
print(get_most_popular_website(i, "start"))
print(get_most_popular_website(i, "speedtest"))
print(get_most_popular_website(i, "12345"))
print(get_most_popular_website(i2, "12345"))
print(threading.enumerate())
# wydaje sie dzialac, threading.enumerate() w create_index tez pokazuje wiecej watkow, a na samym koncu programu
# pokazuje tylko 1, czyli watki zamykaja sie poprawnie.
