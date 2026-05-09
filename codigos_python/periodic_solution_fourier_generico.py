"""Rotina generica para solucoes periodicas por Fourier no tempo."""

from __future__ import annotations

from dataclasses import dataclass
from typing import Callable, Optional

import numpy as np


Array = np.ndarray


@dataclass
class FourierResult:
    u: Array
    tempos: Array
    tau: Array
    b_amostras: Array
    b_fft: Array
    u_fft: Array
    freqs: Array
    omega: float
    residuo: Array
    residuo_max: float
    cond_max: float
    erro: Optional[Array] = None
    erro_max: Optional[float] = None


def periodic_solution_fourier_generico(
    A: Array,
    T: float,
    K: int,
    bfun: Callable[[float], Array],
    tempos: Array,
    uexata_fun: Optional[Callable[[Array], Array]] = None,
) -> FourierResult:
    """Aproxima a solucao periodica de U' = A U + b(t)."""

    A = np.asarray(A, dtype=float)
    if A.ndim != 2 or A.shape[0] != A.shape[1]:
        raise ValueError("A matriz A deve ser quadrada.")
    if T <= 0:
        raise ValueError("O periodo T deve ser positivo.")
    if K < 0 or int(K) != K:
        raise ValueError("K deve ser um inteiro nao negativo.")

    K = int(K)
    n = A.shape[0]
    tempos = np.asarray(tempos, dtype=float).reshape(-1)
    omega = 2 * np.pi / T
    Nt = 2 * K + 1
    tau = np.arange(Nt, dtype=float) * T / Nt
    freqs = np.r_[np.arange(0, K + 1), np.arange(-K, 0)]

    B = np.zeros((n, Nt), dtype=float)
    for j, t in enumerate(tau):
        bj = np.asarray(bfun(float(t)), dtype=float).reshape(-1)
        if bj.size != n:
            raise ValueError(f"bfun(t) deve devolver um vetor com {n} componentes.")
        B[:, j] = bj

    B_fft = np.fft.fft(B, axis=1) / Nt
    U_fft = np.zeros((n, Nt), dtype=complex)
    I = np.eye(n)
    cond_max = 0.0

    for idx, k in enumerate(freqs):
        M = 1j * k * omega * I - A
        cond_max = max(cond_max, float(np.linalg.cond(M, p=1)))
        U_fft[:, idx] = np.linalg.solve(M, B_fft[:, idx])

    u = np.zeros((n, tempos.size), dtype=float)
    u_deriv = np.zeros_like(u)
    for j, t in enumerate(tempos):
        fase = np.exp(1j * freqs * omega * t)
        fase_deriv = (1j * freqs * omega) * fase
        u[:, j] = np.real(U_fft @ fase)
        u_deriv[:, j] = np.real(U_fft @ fase_deriv)

    residuo = np.zeros_like(u)
    for j, t in enumerate(tempos):
        bj = np.asarray(bfun(float(t)), dtype=float).reshape(-1)
        residuo[:, j] = u_deriv[:, j] - A @ u[:, j] - bj
    residuo_max = float(np.max(np.abs(residuo)))

    erro = None
    erro_max = None
    if uexata_fun is not None:
        uex = _avaliar_funcao_vetorial(uexata_fun, tempos, n)
        erro = uex - u
        erro_max = float(np.max(np.abs(erro)))

    return FourierResult(
        u=u,
        tempos=tempos,
        tau=tau,
        b_amostras=B,
        b_fft=B_fft,
        u_fft=U_fft,
        freqs=freqs,
        omega=omega,
        residuo=residuo,
        residuo_max=residuo_max,
        cond_max=cond_max,
        erro=erro,
        erro_max=erro_max,
    )


def _avaliar_funcao_vetorial(fun: Callable[[Array], Array], tempos: Array, n: int) -> Array:
    try:
        valores = np.asarray(fun(tempos), dtype=float)
        if valores.shape == (n, tempos.size):
            return valores
    except Exception:
        pass

    valores = np.zeros((n, tempos.size), dtype=float)
    for j, t in enumerate(tempos):
        valores[:, j] = np.asarray(fun(float(t)), dtype=float).reshape(-1)
    return valores
