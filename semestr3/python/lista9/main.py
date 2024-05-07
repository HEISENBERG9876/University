import requests
import json
from datetime import datetime
import matplotlib.pyplot as plt


# w kodzie porównuję kursy PLN->EUR/USD z 2021 i 2022 roku
def fetch_data(url):
    response = requests.get(url)
    if response.status_code != 200:
        raise FetchDataError(url, response.status_code)
    return response.text


class FetchDataError(Exception):
    def __init__(self, url, status_code):
        self.url = url
        self.status_code = status_code
        super().__init__(f"Problem przy pobieraniu danych z {url}. Kod statusu: {status_code}")


# Rates zawiera dane odnosnie kursu, np date i mid czyli kurs sredni, czyli to co nas interesuje
def parse_json_text_to_list_of_date_and_rate_pairs(text):
    data_dict = json.loads(text)
    rates = data_dict["rates"]
    list_of_date_rate_pairs = [[rate["effectiveDate"], rate["mid"]] for rate in rates]
    return list_of_date_rate_pairs


def convert_daily_data_to_monthly(dates_and_rates_pairs):
    monthly_data_result = []
    current_month = 1
    rate_counter = 0
    rate_sum = 0

    for date_str, rate in dates_and_rates_pairs:
        date = datetime.strptime(date_str, "%Y-%m-%d")
        month_number = date.month

        if month_number == current_month:
            rate_counter += 1
            rate_sum += rate

        else:
            average_rate = rate_sum / rate_counter
            data_this_month = [current_month, average_rate]
            monthly_data_result.append(data_this_month)

            current_month = month_number
            rate_sum = 0
            rate_counter = 0

        # grudzien dodajemy osobno, bo petla go nie obejmuje
    monthly_data_result.append([12, rate_sum / rate_counter])

    return monthly_data_result


def get_montly_data_from_url(url):
    try:
        return convert_daily_data_to_monthly(parse_json_text_to_list_of_date_and_rate_pairs(fetch_data(url)))
    except FetchDataError as e:
        print(f"Error: {e}")
    except json.JSONDecodeError as e:  # bo dane moga nie byc poprawnym jsonem
        print(f"Error decoding JSON data from {url}: {e}")


def plot():
    usd2021_url = "https://api.nbp.pl/api/exchangerates/rates/a/usd/2021-01-01/2022-01-01/"
    usd2022_url = "https://api.nbp.pl/api/exchangerates/rates/a/usd/2022-01-01/2023-01-01/"
    eur2021_url = "https://api.nbp.pl/api/exchangerates/rates/a/eur/2021-01-01/2022-01-01/"
    eur2022_url = "https://api.nbp.pl/api/exchangerates/rates/a/eur/2022-01-01/2023-01-01/"

    usd2021_monthly_data = get_montly_data_from_url(usd2021_url)
    usd2022_monthly_data = get_montly_data_from_url(usd2022_url)
    eur2021_monthly_data = get_montly_data_from_url(eur2021_url)
    eur2022_monthly_data = get_montly_data_from_url(eur2022_url)

    usd2021_monthly_rates = [date_and_rate[1] for date_and_rate in usd2021_monthly_data]
    usd2022_monthly_rates = [date_and_rate[1] for date_and_rate in usd2022_monthly_data]
    eur2021_monthly_rates = [date_and_rate[1] for date_and_rate in eur2021_monthly_data]
    eur2022_monthly_rates = [date_and_rate[1] for date_and_rate in eur2022_monthly_data]

    fig, (ax1, ax2) = plt.subplots(2, num="Currency exchange rates of PLN into EUR and USD 2021, 2022")
    x = list(range(1, 13))
    plt.setp((ax1, ax2), xticks=x)
    plt.suptitle("Monthly currency exchange rates in 2021 and 2022")
    ax1.set(xlabel='Month', ylabel='PLN rate')
    ax2.set(xlabel='Month', ylabel='PLN rate')
    ax1.set_title("2021")
    ax2.set_title("2022")
    ax1.plot(x, usd2021_monthly_rates, label="USD", color="blue")
    ax1.plot(x, eur2021_monthly_rates, label="EUR", color="red")
    ax1.legend()
    ax2.plot(x, usd2022_monthly_rates, label="USD", color="blue")
    ax2.plot(x, eur2022_monthly_rates, label="EUR", color="red")
    ax2.legend()

    plt.show()


plot()

#  przewidywania kursow nie chcialo mi sie robic
