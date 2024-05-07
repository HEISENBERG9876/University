import matplotlib.pyplot as plt
from scipy.interpolate import lagrange
import numpy as np

points = [
    (2.786, 5.927), (-0.048, 13.612), (4.691, 78.128), (-0.582, 21.363), (0.336, 8.531),
    (0.927, 1.725), (2.560, 2.466), (0.850, 3.062), (3.785, 32.489), (-0.496, 20.158),
    (3.006, 10.204), (2.653, 3.865), (0.291, 9.508), (-1.882, 36.090), (-0.372, 18.178),
    (4.054, 43.810), (1.911, -1.599), (3.033, 10.332), (0.202, 10.369), (-3.095, 37.327),
    (-1.713, 34.761), (2.263, -0.314), (4.690, 78.228), (4.085, 45.374), (-1.944, 36.815),
    (1.222, 0.003), (-1.837, 35.876), (2.552, 2.454), (3.468, 21.934), (-2.556, 38.925),
    (-1.468, 32.552), (1.718, -2.095), (2.413, 0.729), (1.169, 0.283), (4.003, 41.263),
    (1.711, -1.450), (1.334, -0.662), (-1.656, 34.538), (3.151, 13.223), (-1.677, 34.752),
    (3.052, 10.915), (0.136, 11.253), (1.156, 0.601), (2.367, 0.731), (-2.298, 38.382),
    (4.179, 49.736), (2.080, -1.145), (2.075, -1.363), (-2.004, 37.446), (-1.132, 28.660),
    (-0.621, 21.689), (-1.891, 36.628), (0.645, 4.903), (-2.118, 37.930), (-0.946, 25.876),
    (0.819, 3.333), (0.880, 2.495), (-2.954, 38.312), (4.750, 82.218), (-1.752, 35.281),
    (-1.546, 33.398), (3.890, 37.016), (2.813, 6.081), (-0.849, 25.150), (1.851, -1.768),
    (0.289, 8.975), (-2.765, 38.757), (0.593, 5.370), (0.460, 6.776), (1.838, -2.139),
    (-0.627, 21.402), (-1.392, 31.806), (-2.415, 39.225), (-0.400, 18.532), (-2.866, 38.618),
    (1.067, 0.953), (-3.171, 36.750), (-2.833, 38.350), (3.065, 10.959), (4.030, 42.846),
    (3.258, 15.667)
]


def f(x):
    return (x - 1.2)*(x + 4.7)*(x - 2.3)


x_points, y_points = zip(*points)

# a.
plt.subplot(5, 4, 1)
plt.title('A. F(x)')

x_plot_values = np.linspace(-4, 5, 100)
y_plot_values = f(x_plot_values)

plt.scatter(x_points, y_points, color='red')
plt.plot(x_plot_values, y_plot_values)


# b. do wyznaczenia wielomianu uzyte zostaly funkcje wbudowane
# wniosek jest ten sam- pojawiają się bardzoooo duze liczby: efekt rungego + pewnie pelno bledow obliczeniowych
plt.subplot(5, 4, 2)
plt.title('B. Wielomian interpolacyjny :(')

lagrange_poly = lagrange(x_points, y_points)
y_values_interpolated = lagrange_poly(x_plot_values)

plt.scatter(x_points, y_points, color='red')
plt.plot(x_plot_values, y_values_interpolated, color='green')


# c.
# w(x) = suma (pk(x) * ak(x))
def eval_at_given_x(x, c_list, d_list, a_list, degree):
    Pk_0 = 1
    Pk_1 = (x - c_list[1]) * Pk_0
    evaluated_optimal = a_list[0] * Pk_0 + a_list[1] * Pk_1

    for k in range(2, degree + 1):
        old_Pk_1 = Pk_1
        Pk_1 = (x - c_list[k]) * Pk_1 - d_list[k] * Pk_0
        Pk_0 = old_Pk_1
        evaluated_optimal += a_list[k] * Pk_1
    return evaluated_optimal


def eval_ck(Pk_minus_1_list, sum_Pk_minus_1_square, x_points):
    # Bierzemy zapamiętany iloczyn, zamiast liczyć ponownie
    sum_xP_square = 0  # x * p^2
    for x, p in zip(x_points, Pk_minus_1_list):
        sum_xP_square += x * p * p
    return sum_xP_square / sum_Pk_minus_1_square


# def eval_ck(Pk_minus_1_square_list, sum_Pk_minus_1_square, x_points):
#     # Bierzemy zapamiętany iloczyn, zamiast liczyć ponownie
#     sum_xP_square = 0
#     for x, p_squared in zip(x_points, Pk_minus_1_square_list):
#         sum_xP_square += x * p_squared
#     return sum_xP_square / sum_Pk_minus_1_square


def eval_dk(suma_Pk_minus_1_square, suma_Pk_minus_2_square):
    # bierzemy dwa zapamiętane iloczyny
    return suma_Pk_minus_1_square / suma_Pk_minus_2_square


def eval_ak(Pk, sum_Pk_square, y_points):
    sum_fPk = 0  # f * Pk
    for i in range(len(y_points)):
        sum_fPk += y_points[i] * Pk[i]
    return sum_fPk / sum_Pk_square


def plot_optimal(x_points, y_points, x_plot_values, degree):
    plt.subplot(5, 4, degree + 1)
    plt.title(f"C. Wielomian optymalny, stopień {degree}")

    Pk_minus_2_list = [1 for x in range(len(x_points))]
    sum_Pk_minus_2_square = len(x_points)
    ck_minus_1 = eval_ck(Pk_minus_2_list, sum_Pk_minus_2_square, x_points)
    Pk_minus_1_list = [x - ck_minus_1 for x in x_points]
    Pk_square = [p * p for p in Pk_minus_1_list]
    sum_Pk_square = sum(Pk_square)
    sum_Pk_minus_1_square = len(x_points)

    c_list = [0, ck_minus_1]
    d_list = [0, 0]
    a_list = [eval_ak(Pk_minus_2_list, sum_Pk_minus_2_square, y_points), eval_ak(Pk_minus_1_list, sum_Pk_square, y_points)]

    for k in range(2, degree + 1):
        sum_Pk_minus_2_square = sum_Pk_minus_1_square
        sum_Pk_minus_1_square = sum_Pk_square
        ck = eval_ck(Pk_minus_1_list, sum_Pk_minus_1_square, x_points)
        dk = eval_dk(sum_Pk_minus_1_square, sum_Pk_minus_2_square)
        old_Pk_minus_1 = Pk_minus_1_list
        Pk_minus_1_list = [(x - ck) * xPk_minus_1 - dk * xPk_minus_2 for x, xPk_minus_1, xPk_minus_2 in zip(x_points, Pk_minus_1_list, Pk_minus_2_list)]
        Pk_minus_2_list = old_Pk_minus_1
        c_list.append(ck)
        d_list.append(dk)
        sum_Pk_square = sum([p * p for p in Pk_minus_1_list])
        a_list.append(eval_ak(Pk_minus_1_list, sum_Pk_square, y_points))

    plt.plot(x_plot_values, [eval_at_given_x(x, c_list, d_list, a_list, degree) for x in x_plot_values])
    plt.scatter(x_points, y_points, color='red')


for degree in range(2, 16):
    plot_optimal(x_points, y_points, x_plot_values, degree)

plt.tight_layout()
plt.show()

