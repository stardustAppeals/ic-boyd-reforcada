"""Experimentos de regularidade para aproximacoes de Fourier.

Este arquivo acompanha `experimentos_regularidade_fourier_COMENTADO_ASCII.m`.
Ele compara dois casos:

1. u(t) = exp(cos(t)), suave e periodica;
2. u(t) = |sin(t)|, continua e periodica, mas nao diferenciavel em k*pi.

A moral numerica e a mesma discutida no relatorio: quanto mais regular a
funcao, mais rapido tendem a decair os coeficientes de Fourier.
"""

from __future__ import annotations

import csv
from pathlib import Path

import numpy as np

from periodic_solution_fourier_generico import periodic_solution_fourier_generico


ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "codigos_python" / "saida_regularidade"
OUT.mkdir(exist_ok=True)


def experimento_exp_cos() -> list[tuple[int, int, float, float, float]]:
    """Testa u(t)=exp(cos(t)) como solucao fabricada de uma EDO."""

    T = 2 * np.pi
    A = np.array([[0.0, 1.0], [-1.0, -1.0]])
    k_list = [1, 2, 4, 8, 16, 32, 64]
    tempos = np.linspace(0.0, T, 1200, endpoint=False)

    u = lambda t: np.exp(np.cos(t))
    up = lambda t: -np.sin(t) * np.exp(np.cos(t))
    upp = lambda t: (np.sin(t) ** 2 - np.cos(t)) * np.exp(np.cos(t))

    def uex(t):
        t = np.asarray(t)
        return np.vstack((u(t), up(t)))

    def bfun(t):
        return np.array([0.0, upp(t) + up(t) + u(t)])

    linhas = []
    for K in k_list:
        resultado = periodic_solution_fourier_generico(A, T, K, bfun, tempos, uex)
        linhas.append(
            (
                K,
                2 * K + 1,
                float(resultado.erro_max),
                float(resultado.residuo_max),
                float(resultado.cond_max),
            )
        )
    return linhas


def reconstruir_fourier_amostrado(valores: np.ndarray, tempos_finos: np.ndarray, T: float) -> np.ndarray:
    """Reconstrucao trigonometrica a partir dos coeficientes discretos da FFT."""

    Nt = valores.size
    K = (Nt - 1) // 2
    omega = 2 * np.pi / T
    coef = np.fft.fft(valores) / Nt
    freqs = np.r_[np.arange(0, K + 1), np.arange(-K, 0)]
    fases = np.exp(1j * np.outer(freqs, omega * tempos_finos))
    return np.real(coef @ fases)


def experimento_abs_sin() -> list[tuple[int, int, float]]:
    """Aproxima diretamente u(t)=|sin(t)| por Fourier discreto."""

    T = 2 * np.pi
    k_list = [2, 4, 8, 16, 32, 64, 128]
    tempos_finos = np.linspace(0.0, T, 5000, endpoint=False)
    u_exata = np.abs(np.sin(tempos_finos))

    linhas = []
    for K in k_list:
        Nt = 2 * K + 1
        ts = np.linspace(0.0, T, Nt, endpoint=False)
        valores = np.abs(np.sin(ts))
        u_rec = reconstruir_fourier_amostrado(valores, tempos_finos, T)
        erro = float(np.max(np.abs(u_rec - u_exata)))
        linhas.append((K, Nt, erro))
    return linhas


def salvar_csv(nome: str, cabecalho: list[str], linhas: list[tuple]) -> None:
    caminho = OUT / nome
    with caminho.open("w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow(cabecalho)
        writer.writerows(linhas)


def main() -> None:
    suave = experimento_exp_cos()
    pouco_regular = experimento_abs_sin()

    salvar_csv(
        "tabela_regularidade_exp_cos.csv",
        ["K", "Nt", "erro_maximo", "residuo_maximo", "condicao_maxima"],
        suave,
    )
    salvar_csv(
        "tabela_regularidade_abs_sin.csv",
        ["K", "Nt", "erro_maximo"],
        pouco_regular,
    )

    print("u(t)=exp(cos(t))")
    for K, Nt, erro, residuo, condicao in suave:
        print(f"K={K:3d} Nt={Nt:3d} erro={erro:.3e} residuo={residuo:.3e} cond={condicao:.3e}")

    print("\nu(t)=|sin(t)|")
    for K, Nt, erro in pouco_regular:
        print(f"K={K:3d} Nt={Nt:3d} erro={erro:.3e}")

    print(f"\nTabelas salvas em: {OUT}")


if __name__ == "__main__":
    main()
