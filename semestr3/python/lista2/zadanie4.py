from random import sample
text_file = open('lalka.txt', 'r', encoding='UTF-8')
# bylem leniwy :( dziala tylko na zdaniach zakonczonych . i wiele bialych znakow obok siebie jest ignorowanych, gdyz
# uzywalem metody split.
# https://wolnelektury.pl/katalog/lektura/lalka-tom-pierwszy.html


def delete_too_long_words(sentence, max_word_length):
    return ' '.join(word for word in sentence.split() if len(word) <= max_word_length)


def delete_number_of_words(sentence, max_words):
    word_list = sentence.split()
    word_list_length = len(word_list)
    num_of_words_to_keep = min(max_words, len(word_list))
    words_to_keep = sample(range(word_list_length), num_of_words_to_keep)  # lista z indeksami slow, ktore maja
    # zostac w zdaniu wynikowym
    return ' '.join(word_list[i] for i in words_to_keep)


def simplify_sentence(sentence, max_word_length, words_to_del):
    return delete_number_of_words(delete_too_long_words(sentence, max_word_length), words_to_del)


def simplify_text(text_file, max_word_length, words_to_del):
    sentences = text_file.read().split('.')
    result = ""
    for sentence in sentences:
        result += simplify_sentence(sentence, max_word_length, words_to_del) + '. '
    return result


sentence = "Podział peryklinalny inicjałów wrzecionowatych kambium charakteryzuje się" \
           " ścianą podziałową inicjowaną w płaszczyźnie maksymalnej."
print(simplify_text(text_file, 10, 5))
print(simplify_sentence(sentence, 10, 5))

text_file.close()
