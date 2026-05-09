# Versoes Python dos codigos da IC

Esta pasta contem versoes em Python/NumPy dos codigos MATLAB/Octave usados no
relatorio. A ideia nao e substituir os codigos oficiais, mas criar uma versao
mais facil de executar, testar e estudar passo a passo.

## Arquivos

- `periodic_solution_fourier_generico.py`: rotina generica para sistemas periodicos da forma `U'(t) = A U(t) + b(t)`.
- `teste_sistema2x2_fourier.py`: teste finito-dimensional que valida Fourier no tempo.
- `EqCalor2D_timeperiodic_SPECTRAL.py`: formulacao Fourier--Chebyshev para a equacao do calor 2D periodica no tempo.
- `experimentos_regularidade_fourier.py`: compara convergencia de Fourier para uma funcao suave e uma funcao menos regular.

## Como executar

A partir da raiz do repositorio:

```bash
python codigos_python/teste_sistema2x2_fourier.py
python codigos_python/EqCalor2D_timeperiodic_SPECTRAL.py
python codigos_python/experimentos_regularidade_fourier.py
```

As tres rotinas acima usam apenas `numpy`.

## Como estudar

1. Comece por `teste_sistema2x2_fourier.py`.
   Ele mostra a parte temporal isolada: FFT da forcante, resolucao dos modos e reconstrucao.

2. Depois leia `periodic_solution_fourier_generico.py`.
   Esse arquivo transforma o teste 2x2 em uma rotina reutilizavel.

3. Em seguida leia `EqCalor2D_timeperiodic_SPECTRAL.py`.
   Ele mostra como a EDP do calor vira `U'(t)=AU(t)+b(t)` depois de Chebyshev no espaco.

4. Por fim rode `experimentos_regularidade_fourier.py`.
   Ele explica numericamente por que funcoes suaves convergem muito mais rapido em metodos espectrais.

## Metrica de erro

Na equacao do calor 2D, o erro principal desta versao e:

```text
erro_max = max(abs(U_aprox - U_ex))
```

A norma 1 acumulada aparece apenas como diagnostico secundario:

```text
erro_l1_total = sum_t ||U_aprox(t) - U_ex(t)||_1
```
