import math


# [-3 : 2]
def funkcja1(x):
    return 2024 * (x**8) - 1977 * (x**4) - 1981


# [-3 : 3]
def funkcja2(x):
    return 1 / (1 + x**2)


# [-3pi : pi/6]
def funkcja3(x):
    return math.sin(5 * x - math.pi / 3)


# def trapezoid(i, a, b, f):
#     podzialy = 2**i
#     result = 0
#     hi = (b - a) / podzialy
#
#     for k in range(0, 2**i):
#         xk = a + hi * k
#         xk_plus_1 = a + hi * (k + 1)
#         f1 = f(xk)
#         f2 = f(xk_plus_1)
#         result += (f1 + f2) / 2
#
#     result = result * hi
#
#     return result


def trapezoid_method(i, a, b, f):
    podzialy = 2**i
    result = 0
    hi = (b - a) / podzialy

    result += f(a) / 2
    result += f(b) / 2

    for k in range(1, 2**i):
        xk = a + hi * k
        result += f(xk)

    result = result * hi

    return result


# dziala 100% dobrze, wolfram alpha potwierdza. Z zasady trapezow.
def calculate_romberg_first_column(f, a, b):
    result = {}
    max_k = 20

    for k in range(max_k + 1):
        result[(0, k)] = trapezoid_method(k, a, b, f)

    return result


def calculate_romberg(f, a, b):
    result = calculate_romberg_first_column(f, a, b)
    for m in range(1, 21):
        max_k = 20 - m
        for k in range(0, max_k + 1):
            result[(m, k)] = ((4 ** m) * result[(m-1, k+1)] - result[(m-1, k)]) / (4**m - 1)
    return result


romberg1 = calculate_romberg(funkcja1, -3, 2)
romberg2 = calculate_romberg(funkcja2, -3, 3)
romberg3 = calculate_romberg(funkcja3, -3 * math.pi, math.pi/6)

result1 = romberg1[(20, 0)]
result2 = romberg2[(20, 0)]
result3 = romberg3[(20, 0)]

print("Calka z funkcji 2024 * (x**8) - 1977 * (x**4) - 1981:")
print(result1)
print("Rzeczywista wartość: 4422911.111111")
print(f"Błąd = {abs(4422991.111111111111 - result1)}")
print()

print("Calka z funkcji 1 / (1 + x**2):")
print(result2)
print("Rzeczywista wartość: 2.4980915447")
print(f"Błąd = {abs(2.49809154479650 - result2)}")
print()

print("Calka z funkcji sin(5 * x - pi / 3):")
print(result3)
print("Rzeczywista wartość: -0.1")
print(f"Błąd = {abs(-0.1 - result3)}")
print()



# for x in romberg1:
#     print(x, romberg1[x])

# for x in romberg2:
#     print(x, romberg2[x])

# for x in romberg3:
#     print(x, romberg3[x])


# Co zauważamy?
# Pierwsze parę wyników jest 2/10 :(
# Wyniki są coraz dokładniejsze, ale nadal mają nieznaczne błędy, zazwyczaj gdzieś koło 10 miejsca po przecinku.
# Nie wiem czy coś ciekawszego można zauważyć.









