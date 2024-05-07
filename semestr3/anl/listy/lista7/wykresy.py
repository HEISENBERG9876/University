import numpy as np
import matplotlib.pyplot as plt
import math


def poly(x, xs):
    if len(xs) == 0:
        return 1
    return (x-xs[0]) * poly(x, xs[1:])


# wezly chebysheva
def cheby_points(n):
    return [math.cos(((2 * k + 1) / (2 * n + 2)) * math.pi) for k in range(0, n+1)]


fig, ax = plt.subplots(5, 4)

j = 0
change_i = 0

# tyle punktow bedziemy rysowac
x_space = np.linspace(-1, 1, 1000)

for i in range(1, 21):
    x_even_dist_points = np.linspace(-1, 1, i + 1)
    even_dist_y_space = [poly(x, x_even_dist_points) for x in x_space]
    cheb_y_space = [poly(x, cheby_points(i)) for x in x_space]
    prev_i = i + 1
    i = i - change_i * 4 - 1
    ax[j, i].set_title(str(prev_i))
    ax[j, i].plot(x_space, even_dist_y_space, color="red")
    ax[j, i].plot(x_space, cheb_y_space, color="blue")
    if i > 0 and i % 3 == 0:
        j += 1
        change_i += 1


plt.show()