# Códigos corrigidos para a IC — Octave/MATLAB

Esta pasta contém uma versão limpa dos códigos para estudar soluções periódicas usando métodos espectrais.

## Arquivos

- `periodic_solution_fourier_generico.m`  
  Rotina genérica para resolver sistemas periódicos do tipo `U'(t)=A U(t)+b(t)` usando Fourier no tempo.

- `exemplo_uso_periodic_solution_fourier_generico.m`  
  Exemplo simples de uso da rotina genérica no sistema associado a `x''+x'+x=f(t)`.

- `teste_sistema2x2_fourier_COMENTADO_ASCII.m`  
  Teste didático e autocontido da formulação temporal por Fourier para um sistema 2x2.

- `EqCalor2D_timeperiodic_SPECTRAL_COMENTADO.m`  
  Código principal da EDP do calor 2D. Usa Chebyshev no espaço e Fourier no tempo.

- `experimentos_regularidade_fourier_COMENTADO_ASCII.m`  
  Experimento adicional para comparar a convergência de Fourier em funções suaves e menos regulares.

## Correções aplicadas

1. O arquivo `periodic_solution_fourier_generico_COMENTADO_ASCII.m` foi renomeado para `periodic_solution_fourier_generico.m`, compatível com o nome da função interna.

2. O experimento de regularidade foi adicionado à pasta e corrigido para chamar:

```matlab
resultado = periodic_solution_fourier_generico(A, T, K, bfun, times, uex);
```

E usar os campos:

```matlab
resultado.erro_max
resultado.residuo_max
resultado.cond_max
```

3. O erro principal no código da equação do calor 2D é:

```matlab
erro_abs = abs(U_aprox - U_ex);
erro_max = max(erro_abs(:));
erro_reportado = erro_max;
```

A métrica antiga em norma 1 total foi preservada como diagnóstico:

```matlab
erro_l1_total = norm(erro_norma1, 1);
```

4. As terminações específicas do Octave (`endif`, `endfor`, `endfunction`) foram trocadas por `end`, que funciona tanto em MATLAB quanto em Octave.

## Ordem sugerida para estudar

1. Rode `teste_sistema2x2_fourier_COMENTADO_ASCII.m`.
2. Rode `exemplo_uso_periodic_solution_fourier_generico.m`.
3. Rode `EqCalor2D_timeperiodic_SPECTRAL_COMENTADO.m`.
4. Opcionalmente, rode `experimentos_regularidade_fourier_COMENTADO_ASCII.m` para estudar regularidade e convergência.


## Observação de alinhamento com o relatório

A formulação usada em todos os códigos segue a matriz modal `(i*k*omega*I - A)`, coerente com a dedução teórica apresentada no Capítulo 4. A rotina genérica também verifica o condicionamento máximo das matrizes modais.

## Geração das figuras do relatório

Foi acrescentado o script:

- `gerar_figuras_IC.m`  
  Gera as figuras chamadas no Capítulo 5 e salva os arquivos `.png` na pasta `../figuras`.

Para usar no Octave/MATLAB, entre na pasta `codigos` e execute:

```matlab
gerar_figuras_IC
```

O script gera os gráficos principais do sistema `2x2`, os gráficos da equação do calor 2D e as superfícies para `NCheb = 8, 16, 32`.
