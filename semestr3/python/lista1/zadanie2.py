#zadanie2

def check_palindrom(word):
    letters = []

    for char in word:
        if char.isalnum():
            letters.append(char.lower())

    if letters == letters[::-1]:
        return True
    else:
        return False


print(check_palindrom("Kobyła ma mały bok"))
print(check_palindrom("Kobyła ma mały bok."))
print(check_palindrom("7AaAaAaAaA7."))
print(check_palindrom("Eine güldne, gute Tugend: Lüge nie!"))
print(check_palindrom("Míč omočím."))

print(check_palindrom("ABCDA."))
print(check_palindrom("OK."))
