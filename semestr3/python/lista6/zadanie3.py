from collections import defaultdict
from bs4 import BeautifulSoup
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
        raise ValueError("Niepoprawna nazwa strony lub strona nie odpowiada")


# tworzymy index- pod kluczami w slowniku (slowami) znajduja sie nazwy stron zawierajacych to slowo, byc moze powtorzone wielokrotnie
def create_index(list_of_url):
    index = defaultdict(list)
    for url in list_of_url:
        word_list = get_parsed_text_from_url(url)
        if word_list:
            for word in word_list:
                index[word].append(url)
    return dict(index)


def get_most_popular_website(index, word):
    return max(index[word], key=index[word].count) if word in index else None


# test
i = create_index(["https://www.york.ac.uk/teaching/cws/wws/webpage1.html", "https://www.speedtest.net/pl"])
i2 = create_index([])

print(i)
print(get_most_popular_website(i, "start"))
print(get_most_popular_website(i, "speedtest"))
print(get_most_popular_website(i, "12345"))
print(get_most_popular_website(i2, "12345"))
# wszystko wydaje sie byc ok

lst = ["a", "b", "b", "c"]
print(max(lst, key=lst.count))