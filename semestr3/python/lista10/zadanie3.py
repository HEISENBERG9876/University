import numpy as np
import random
import matplotlib.pyplot as plt

# on, off dodane dla czytelnosci. Przyjmuja wartosc 0 lub 1 i od nich zalezy kolor bloku na obrazku
on = 1
off = 0


def update_board_state(board, board_size):
    new_board = board.copy()

    for row in range(board_size):
        for col in range(board_size):
            living_neighbors = find_living_neighbors(board, row, col, board_size)

            if board[row, col] == on:
                if living_neighbors < 2 or living_neighbors > 3:
                    new_board[row, col] = off
            else:
                if living_neighbors == 3:
                    new_board[row, col] = on
    return new_board


def find_living_neighbors(board, row, col, board_size):
    living_neighbors = 0

    for x in (-1, 0, 1):  # offsety na x i y nowych sasiadow, np. sasiad (x, y) moze miec pozycje (x, y-1)
        for y in (-1, 0, 1):
            if x != 0 or y != 0:  # nie chcemy sprawdzac, czy komorka jest swoim wlasnym sasiadem
                neighbor_x_coord = (row + x) % board_size  # jak bloczek wyjdzie poza mape, to po prostu przenosimy go na druga strone
                neighbor_y_coord = (col + y) % board_size
                if board[neighbor_x_coord, neighbor_y_coord] == on:
                    living_neighbors += 1
    return living_neighbors


def generate_starting_board(board_size):
    board = np.zeros((board_size, board_size), dtype=float)  # inicjalizujemy zerami
    for row in range(board_size):
        for col in range(board_size):
            random_color = random.choices([on, off], weights=[0.1, 0.9], k=1)[0]  # zmieniamy zera na losowy kolor. Mozna by tylko losowo wybierac kolor on- czyli 1, bo tablica jest juz wypelniona zerami, ale moze tak jest czytelniej.
            board[row, col] = random_color
    return board


def start_game_of_life(board_size, update_speed):
    board = generate_starting_board(board_size)

    plt.figure(num="Game of life")

    while True:
        plt.xticks([])
        plt.yticks([])

        plt.imshow(board)
        plt.show(block=False)
        plt.pause(update_speed)
        plt.clf()
        board = update_board_state(board, board_size)


start_game_of_life(80, 0.1)
# wydaje sie dzialac

