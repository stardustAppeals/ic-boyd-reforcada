"""Teste 2x2 da rotina periodica por Fourier no tempo."""

from __future__ import annotations

import numpy as np

from periodic_solution_fourier_generico import periodic_solution_fourier_generico


def x_exata(t):
    return np.sin(t) + np.cos(2 * t)


def u_exata(t):
    t = np.asarray(t)
    return np.vstack((np.sin(t) + np.cos(2 * t), np.cos(t) - 2 * np.sin(2 * t)))


def bfun(t):
    f = -2 * np.sin(2 * t) + np.cos(t) - 3 * np.cos(2 * t)
    return np.array([0.0, f])


def rodar_teste(K=8, nplot=400):
    A = np.array([[0.0, 1.0], [-1.0, -1.0]])
    T = 2 * np.pi
    tempos = np.linspace(0.0, T, nplot)

    resultado = periodic_solution_fourier_generico(A, T, K, bfun, tempos, u_exata)
    x_aprox = resultado.u[0, :]
    erro = x_exata(tempos) - x_aprox

    print(f"Numero total de modos/pontos da FFT: Nt = {2*K + 1}")
    print(f"Maximo numero de condicao: {resultado.cond_max:.6e}")
    print(f"Erro maximo em norma infinito: {np.max(np.abs(erro)):.6e}")
    print(f"Residuo maximo: {resultado.residuo_max:.6e}")
    return resultado


if __name__ == "__main__":
    rodar_teste()
