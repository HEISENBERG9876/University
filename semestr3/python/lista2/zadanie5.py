text_file = open('lalka.txt', 'r', encoding='UTF-8')
# mozemy przyjac, ze tekst zawiera tylko litery i znaki przestankowe-
# biale znaki nas nie interesuja, ale dodam spacje po kazdym wyrazie dla czytelnosci.
# https://wolnelektury.pl/katalog/lektura/lalka-tom-pierwszy.html


def compress_word(word):
    result = []
    current_char = word[0]
    char_num = 1
    # liczymy ilosc takich samych znakow do momentu, gdy nie napotkamy innego znaku i wtedy dodajemy do wynikowej
    # listy pare znak + liczba wystapien
    for i in range(1, len(word)):
        if word[i] != current_char:
            result.append((current_char, char_num))
            current_char = word[i]
            char_num = 1
        else:
            char_num += 1
    # przypadek dla ostatniej litery
    result.append((current_char, char_num))
    return tuple(result)


def compress_text(text_file):
    return [compress_word(word) for word in text_file.read().split()]


def decompress_text(compressed_text):
    text_result = ''
    for compressed_word in compressed_text:
        word_result = ''
        for char_and_number in compressed_word:
            word_result += char_and_number[0] * char_and_number[1]
        text_result += word_result + ' '
    return text_result


print(decompress_text(compress_text(text_file)))
text_file.close()

