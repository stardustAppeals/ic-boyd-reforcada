# IC Boyd reforcada

Projeto separado da IC com fundamentacao teorica reforcada, incluindo referencias conceituais associadas a metodos espectrais, Fourier, Chebyshev, aliasing, colocacao e validacao numerica.

Este repositorio nao substitui o projeto `ic-edps`; ele guarda uma segunda versao da IC para evolucao independente.

## Conteudo principal

- `IC_001_revisado3.tex`: arquivo principal do relatorio em LaTeX.
- `cap_01_introducao.tex` a `cap_06_codigos_comentados.tex`: capitulos do relatorio.
- `IC_001_revisado3.pdf`: PDF compilado do relatorio.
- `codigos/`: codigos oficiais em Octave/MATLAB.
- `codigos_python/`: versoes Python/NumPy dos codigos principais, para estudo e execucao local.
- `apps_interativos/`: pequenas aulas interativas em HTML para estudar a teoria e os algoritmos.
- `figuras/`: figuras usadas no relatorio.
- `ferramentas/`: scripts auxiliares, incluindo geracao de figuras em Python.
- `resultados_numericos_resumo.csv`: resumo dos resultados numericos.
- `README_ATUALIZACAO.md`: descricao detalhada das mudancas desta versao.

## Ideia central

A proposta e estudar solucoes periodicas no tempo de problemas diferenciais lineares usando uma formulacao espectral:

- Fourier no tempo, para explorar a periodicidade;
- Chebyshev no espaco, para discretizar dominios limitados;
- resolucao modal de sistemas do tipo

```text
(i*k*omega*I - A) U_hat_k = b_hat_k
```

A validacao numerica combina solucao fabricada, erro maximo absoluto, diagnostico acumulado em norma 1, residuo e numero de condicao.

## Como usar

Para trabalhar no relatorio, edite os arquivos `.tex` e compile `IC_001_revisado3.tex`.

Para regenerar figuras no Octave/MATLAB, use:

```text
codigos/gerar_figuras_IC.m
```

Em ambientes sem Octave/MATLAB, a pasta `ferramentas/` contem um script Python auxiliar para regeneracao de figuras.

Para estudar pelos codigos Python:

```text
python codigos_python/teste_sistema2x2_fourier.py
python codigos_python/EqCalor2D_timeperiodic_SPECTRAL.py
python codigos_python/experimentos_regularidade_fourier.py
```

Para estudar visualmente, abra:

```text
apps_interativos/index.html
```
