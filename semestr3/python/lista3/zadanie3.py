from collections import deque
#  mielismy uzyc deque tam, gdzie ma to sens. Uzywam metody pop, wiec ma to troche sensu.


def find_path(labirynth, coords):
    def find_path_help(labirynth, coords, result_path, visited):
        result_path.append(coords)
        visited.add(coords)

        if coords[1] == len(labirynth) - 1:  # coords[1] to nasza wspolrzedna y- badamy, czy dotarlismy do konca labiryntu.
            return result_path
        else:
            neighbors = find_valid_neighbors(labirynth, coords, visited)
            for neighbor in neighbors:
                if neighbor not in result_path:
                    new_path = find_path_help(labirynth, neighbor, result_path, visited)
                    if new_path:
                        return new_path
            result_path.pop()  # w przypadku, gdy sciezka okaze sie nie prowadzic do konca labiryntu
        return None  # w przypadku braku jakiejkolwiek sciezki

    return find_path_help(labirynth, coords, deque(), set())


def find_valid_neighbors(labirynth, coords, visited):
    x = coords[0]
    y = coords[1]
    max_x = len(labirynth[0]) - 1  # patrzymy na sume spacji i X'ow w wierszu
    max_y = len(labirynth) - 1  # patrzymy na ilosc wierszy
    potential_neighbors = [
        (min(x + 1, max_x), y),  # przy wyborze wspolrzednych musimy sprawdzac, czy nie wychodza poza labirynt
        (max(x - 1, 0), y),
        (x, min(y + 1, max_y)),
        (x, max(y - 1, 0))]
    return [neighbor for neighbor in potential_neighbors if neighbor not in visited and labirynth[neighbor[1]][neighbor[0]] != 'X']


# testy
labirynth1 = [
    [' ', 'X', ' ', ' ', ' ', ' '],
    [' ', 'X', ' ', 'X', ' ', ' '],
    [' ', ' ', ' ', 'X', ' ', ' '],
    [' ', 'X', ' ', 'X', ' ', 'X'],
    [' ', 'X', ' ', 'X', 'X', ' '],
    [' ', 'X', 'X', 'X', ' ', ' ']
]
print(find_path(labirynth1, (0, 0)))


no_path_labirynth = [
    [' ', ' ', ' ', 'X', 'X', ' '],
    ['X', 'X', ' ', 'X', 'X', ' '],
    [' ', ' ', ' ', 'X', ' ', ' '],
    ['X', 'X', 'X', 'X', 'X', 'X'],
    [' ', 'X', ' ', ' ', ' ', ' '],
    [' ', 'X', ' ', 'X', ' ', ' ']
]
print(find_path(no_path_labirynth, (0, 1)))


labirynth2 = [
    [' ', 'X', ' ', ' ', ' ', ' '],
    [' ', 'X', ' ', 'X', ' ', ' '],
    [' ', ' ', ' ', 'X', ' ', ' '],
    [' ', 'X', 'X', ' ', ' ', 'X'],
    [' ', 'X', ' ', 'X', 'X', ' '],
    [' ', 'X', 'X', 'X', ' ', ' ']
]
print(find_path(labirynth2, (4, 2)))
