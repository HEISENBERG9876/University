# wersja ze spamietywaniem
sudan_results = {}


def sudan(n, x, y):
    if (n, x, y) in sudan_results:
        return sudan_results[(n, x, y)]
    elif n == 0:
        result = x + y
    elif x >= 0 and y == 0:
        result = x
    else:
        result = sudan(n - 1, sudan(n, x, y - 1), sudan(n, x, y - 1) + y)

    sudan_results[(n, x, y)] = result
    return result


# dziala bez problemu
print(sudan(3, 1, 1))
print(sudan(1, 2, 3))
print(sudan(1, 2, 20))
# print(sudan(2, 1, 3)) za duzo wywolan
print(sudan(2, 2, 2))
print(sudan(2, 4, 2))


# wersja bez spamietywania
def sudan2(n, x, y):
    if n == 0:
        result = x + y
    elif x >= 0 and y == 0:
        result = x
    else:
        result = sudan2(n - 1, sudan2(n, x, y - 1), sudan2(n, x, y - 1) + y)
    return result


print(sudan2(3, 1, 1))
print(sudan2(1, 2, 3))
print(sudan2(1, 2, 20))
# print(sudan2(2, 1, 3)) za duzo wywolan
# print(sudan2(2, 2, 2)) # zajmuje bardzo dlugo (o ile w ogole sie doliczy). W wersji ze spamietywaniem dziala dobrze.
# print(sudan2(2, 4, 2)) # ta sama sytuacja co wyzej
# print(sudan2(2, 5, 2)) :(

