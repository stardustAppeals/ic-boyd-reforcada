"""Fourier--Chebyshev para a equacao do calor 2D periodica no tempo."""

from __future__ import annotations

from dataclasses import dataclass

import numpy as np


@dataclass
class Heat2DInfo:
    NM: int
    K: int
    Nt: int
    T: float
    x: np.ndarray
    xint: np.ndarray
    yint: np.ndarray
    xx: np.ndarray
    yy: np.ndarray
    A: np.ndarray
    freqs: np.ndarray
    U_hat: np.ndarray
    B_hat: np.ndarray
    erro_norma1: np.ndarray
    erro_l1_total: float
    erro_max: float
    max_cond: float


def eq_calor_2d_timeperiodic_spectral(NM: int, K: int):
    """Resolve o teste fabricado da equacao do calor 2D."""

    D, x = cheb(NM)
    y = x.copy()
    xint = x[1:NM]
    yint = y[1:NM]

    xx_grid, yy_grid = np.meshgrid(xint, yint)
    xx = xx_grid.reshape(-1)
    yy = yy_grid.reshape(-1)

    D2 = D @ D
    D2 = D2[1:NM, 1:NM]
    Isp = np.eye(NM - 1)
    A = np.kron(Isp, D2) + np.kron(D2, Isp)

    T = 2 * np.pi
    Nt = 2 * K + 1
    tt = np.arange(Nt, dtype=float) * T / Nt

    max_cond, U_aprox, U_hat, B_hat, freqs = resolve_fourier_temporal(A, T, K, xx, yy, tt)
    U_ex = solucao_exata(xx, yy, tt)

    erro_abs = np.abs(U_aprox - U_ex)
    erro_max = float(np.max(erro_abs))
    erro_norma1 = np.sum(erro_abs, axis=0)
    erro_l1_total = float(np.sum(np.abs(erro_norma1)))
    erro_reportado = erro_max

    info = Heat2DInfo(
        NM=NM,
        K=K,
        Nt=Nt,
        T=T,
        x=x,
        xint=xint,
        yint=yint,
        xx=xx,
        yy=yy,
        A=A,
        freqs=freqs,
        U_hat=U_hat,
        B_hat=B_hat,
        erro_norma1=erro_norma1,
        erro_l1_total=erro_l1_total,
        erro_max=erro_max,
        max_cond=max_cond,
    )

    print(f"NM = {NM}, K = {K}, Nt = {Nt}")
    print(f"Numero de pontos internos no espaco: {A.shape[0]}")
    print(f"Maximo numero de condicao: {max_cond:.6e}")
    print(f"Erro maximo: {erro_reportado:.6e}")
    print(f"Erro L1 total: {erro_l1_total:.6e}")
    return erro_reportado, U_aprox, info


def resolve_fourier_temporal(A, T, K, xx, yy, tt):
    n = A.shape[0]
    omega = 2 * np.pi / T
    Nt = len(tt)
    freqs = np.r_[np.arange(0, K + 1), np.arange(-K, 0)]

    B = np.zeros((n, Nt), dtype=float)
    for j, t in enumerate(tt):
        B[:, j] = calcula_forcante(xx, yy, float(t))

    B_hat = np.fft.fft(B, axis=1) / Nt
    U_hat = np.zeros((n, Nt), dtype=complex)
    I = np.eye(n)
    max_cond = 0.0

    for idx, k in enumerate(freqs):
        M = 1j * k * omega * I - A
        max_cond = max(max_cond, float(np.linalg.cond(M, p=1)))
        U_hat[:, idx] = np.linalg.solve(M, B_hat[:, idx])

    U = np.zeros((n, Nt), dtype=float)
    for j, t in enumerate(tt):
        phase = np.exp(1j * freqs * omega * t)
        U[:, j] = np.real(U_hat @ phase)

    return max_cond, U, U_hat, B_hat, freqs


def cheb(N: int):
    """Matriz de diferenciacao de Chebyshev de Trefethen."""

    if N == 0:
        return np.array([[0.0]]), np.array([1.0])

    x = np.cos(np.pi * np.arange(N + 1) / N)
    c = np.r_[2.0, np.ones(N - 1), 2.0] * ((-1.0) ** np.arange(N + 1))
    X = np.tile(x.reshape(-1, 1), (1, N + 1))
    dX = X - X.T
    D = (np.outer(c, 1 / c)) / (dX + np.eye(N + 1))
    D = D - np.diag(np.sum(D, axis=1))
    return D, x


def calcula_forcante(x, y, t):
    gx = np.sin(np.pi * np.cos(np.pi * x))
    gy = np.sin(np.pi * np.cos(np.pi * y))

    u_t = np.sin(t) * gx * gy

    aux_x1 = np.pi**2 * gy * np.cos(t)
    aux_x2 = np.pi * np.cos(np.pi * x) * np.cos(np.pi * np.cos(np.pi * x))
    aux_x3 = np.pi**2 * (np.sin(np.pi * x) ** 2) * np.sin(np.pi * np.cos(np.pi * x))
    u_xx = aux_x1 * (aux_x2 + aux_x3)

    aux_y1 = np.pi**2 * gx * np.cos(t)
    aux_y2 = np.pi * np.cos(np.pi * y) * np.cos(np.pi * np.cos(np.pi * y))
    aux_y3 = np.pi**2 * (np.sin(np.pi * y) ** 2) * np.sin(np.pi * np.cos(np.pi * y))
    u_yy = aux_y1 * (aux_y2 + aux_y3)

    return u_t - (u_xx + u_yy)


def solucao_exata(xx, yy, tt):
    g = np.sin(np.pi * np.cos(np.pi * xx)) * np.sin(np.pi * np.cos(np.pi * yy))
    return np.outer(g, -np.cos(tt))


if __name__ == "__main__":
    for NM in (8, 16, 32):
        eq_calor_2d_timeperiodic_spectral(NM, 8)
