import matplotlib.pyplot as plt

tk_list = [k / 95 for k in range(96)]

xk_list = [5.5, 8.5, 10.5, 13, 17, 20.5, 24.5, 28, 32.5, 37.5, 40.5, 42.5, 45, 47,
           49.5, 50.5, 51, 51.5, 52.5, 53, 52.8, 52, 51.5, 53, 54, 55, 56, 55.5, 54.5, 54, 55, 57, 58.5,
           59, 61.5, 62.5, 63.5, 63, 61.5, 59, 55, 53.5, 52.5, 50.5, 49.5, 50, 51, 50.5, 49, 47.5, 46,
           45.5, 45.5, 45.5, 46, 47.5, 47.5, 46, 43, 41, 41.5, 41.5, 41, 39.5, 37.5, 34.5, 31.5, 28, 24,
           21, 18.5, 17.5, 16.5, 15, 13, 10, 8, 6, 6, 6, 5.5, 3.5, 1, 0, 0, 0.5, 1.5, 3.5, 5, 5, 4.5, 4.5, 5.5,
           6.5, 6.5, 5.5]

yk_list = [41, 40.5, 40, 40.5, 41.5, 41.5, 42, 42.5, 43.5, 45, 47, 49.5, 53, 57, 59,
           59.5, 61.5, 63, 64, 64.5, 63, 61.5, 60.5, 61, 62, 63, 62.5, 61.5, 60.5, 60, 59.5, 59, 58.5,
           57.5, 55.5, 54, 53, 51.5, 50, 50, 50.5, 51, 50.5, 47.5, 44, 40.5, 36, 30.5, 28, 25.5, 21.5,
           18, 14.5, 10.5, 7.50, 4, 2.50, 1.50, 2, 3.50, 7, 12.5, 17.5, 22.5, 25, 25, 25, 25.5, 26.5,
           27.5, 27.5, 26.5, 23.5, 21, 19, 17, 14.5, 11.5, 8, 4, 1, 0, 0.5, 3, 6.50, 10, 13, 16.5, 20.5,
           25.5, 29, 33, 35, 36.5, 39, 41]


def get_list_of_lambdas(x):
    lambda_list = [0]
    for i in range(1, len(x) - 1):
        lambda_list.append((x[i] - x[i - 1]) / (x[i - 1] + x[i + 1]))
    return lambda_list


def get_list_of_h(x):
    h_list = [0]
    for i in range(1, len(x)):
        h_list.append(x[i] - x[i - 1])
    return h_list


def get_list_of_p_and_list_of_q(lambdas):
    p_list = [0]
    q_list = [0]
    for i in range(1, len(lambdas)):
        p_list.append(lambdas[i] * q_list[i - 1] + 2)
        q_list.append((lambdas[i] - 1) / p_list[i])
    return p_list, q_list


def get_list_of_d(x, y):
    d_list = [0]
    for i in range(1, len(x) - 1):
        f1 = (y[i + 1] - y[i]) / x[i + 1] - x[i]
        f2 = (y[i] - y[i - 1]) / x[i] - x[i - 1]
        d_list.append(6 * ((f1 - f2) / (x[i + 1] - x[i - 1])))
    return d_list


def get_list_of_u(d, lamb, p):
    u_list = [0]
    for i in range(1, len(d)):
        u_list.append((d[i] - lamb[i] * u_list[i - 1]) / p[i])
    return u_list


def get_list_of_m(u, q):
    m_list = [u[-1]]
    max = len(u)
    for i in range(1, max):
        m_list.append(u[max - i] + q[max - i] * m_list[i - 1])
    m_list.append(0)
    m_list = m_list[::-1]
    return m_list


def eval_sk(given_x, x, y, m, h, k):
    return ((1 / 6) * m[k - 1] * (x[k] - given_x) ** 3
            + (1 / 6) * m[k] * (given_x - x[k - 1]) ** 3
            + (y[k - 1] - (1 / 6) * m[k - 1] * h[k] ** 2) * (x[k] - given_x)
            + (y[k] - (1 / 6) * m[k] * h[k] ** 2) * (given_x - x[k - 1])) / h[k]


def get_list_of_eval_s(xk_list, yk_list, p_list, q_list, lambda_list, h_list, a):
    d_list = get_list_of_d(xk_list, yk_list)
    u_list = get_list_of_u(d_list, lambda_list, p_list)
    m_list = get_list_of_m(u_list, q_list)

    list_of_eval_s = []
    k = 1
    for x in a:
        if (x >= xk_list[k - 1]) and (x <= xk_list[k]):
            list_of_eval_s.append(eval_sk(x, xk_list, yk_list, m_list, h_list, k))
        if x > xk_list[k]:
            k += 1
            list_of_eval_s.append(eval_sk(x, xk_list, yk_list, m_list, h_list, k))
    return list_of_eval_s


lambda_list = get_list_of_lambdas(tk_list)
p_list = get_list_of_p_and_list_of_q(lambda_list)[0]
q_list = get_list_of_p_and_list_of_q(lambda_list)[1]
h_list = get_list_of_h(tk_list)

a = [k / 10000 for k in range(10001)]
fig, ax = plt.subplots()

xs = get_list_of_eval_s(tk_list, xk_list, p_list, q_list, lambda_list, h_list, a)
ys = get_list_of_eval_s(tk_list, yk_list, p_list, q_list, lambda_list, h_list, a)

ax.plot(xs, ys, color='red')

plt.show()
