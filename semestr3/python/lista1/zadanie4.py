from random import uniform
from math import sqrt


def get_pi(tries):
    side = 10000
    half_side = side / 2
    counter = 0
    points_in_circle = 0
    points_in_square = 0
    while counter < tries:
        counter += 1
        x = uniform(-half_side, half_side)
        y = uniform(-half_side, half_side)
        point_distance = sqrt(x * x + y * y)
        if point_distance <= half_side:
            points_in_circle += 1
            points_in_square += 1
        else:
            points_in_square += 1
    return 4 * points_in_circle / points_in_square


print(get_pi(1000000))