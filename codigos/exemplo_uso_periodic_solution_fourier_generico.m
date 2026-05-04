% EXEMPLO DE USO DA ROTINA GENERICA periodic_solution_fourier_generico
% ---------------------------------------------------------------------
% Este arquivo mostra como o usuario pode fornecer uma matriz A, uma
% funcao periodica b(t) e, opcionalmente, uma solucao exata para validacao.

clear; clc; close all;

% Sistema associado a x'' + x' + x = f(t), escrito como U' = A U + b(t).
A = [0 1; -1 -1];
T = 2*pi;
K = 8;
tempos = linspace(0, T, 401);
tempos(end) = [];  % evita repetir t=0 e t=T

% Forcante vetorial. Deve devolver vetor coluna 2 x 1.
bfun = @(t) [0; -2*sin(2*t) + cos(t) - 3*cos(2*t)];

% Solucao exata vetorial para validacao: U=[x; x'].
uexata = @(t) [sin(t) + cos(2*t); cos(t) - 2*sin(2*t)];

% Chamada da rotina generica.
resultado = periodic_solution_fourier_generico(A, T, K, bfun, tempos, uexata);

fprintf('Erro maximo   = %.6e\n', resultado.erro_max);
fprintf('Residuo maximo = %.6e\n', resultado.residuo_max);
fprintf('Condicao max.  = %.6e\n', resultado.cond_max);

% Grafico do erro na primeira componente.
figure;
plot(tempos, resultado.erro(1,:), 'LineWidth', 1.5);
grid on;
xlabel('t');
ylabel('erro(t)');
title('Erro na primeira componente - rotina generica');
