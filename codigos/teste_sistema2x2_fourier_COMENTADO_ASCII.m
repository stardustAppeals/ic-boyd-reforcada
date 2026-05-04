% teste_sistema2x2_fourier_COMENTADO.m
%
% -------------------------------------------------------------------------
% OBJETIVO DO ARQUIVO
% -------------------------------------------------------------------------
% Este script valida, em um caso pequeno, a etapa temporal do metodo
% espectral em Fourier estudado na IC.
%
% A ideia teorica da IC e a seguinte:
%
%   1) Se o problema e periodico no tempo, e natural representar a
%      dependencia temporal por modos de Fourier.
%
%   2) Para um sistema linear com matriz constante,
%
%          U'(t) = A U(t) + b(t),
%
%      procuramos uma solucao periodica da forma
%
%          U(t) = soma_k U_hat_k exp(i k omega t).
%
%   3) Substituindo essa expansao na equacao diferencial, cada modo k
%      gera um sistema linear independente:
%
%          (i k omega I - A) U_hat_k = b_hat_k.
%
% Este codigo implementa exatamente esse procedimento em um sistema 2x2.
% Ele e o primeiro teste antes de aplicar a mesma logica a uma EDP.
%
% -------------------------------------------------------------------------
% PROBLEMA MATEMATICO USADO NA VALIDACAO
% -------------------------------------------------------------------------
% Partimos da EDO escalar de segunda ordem
%
%          x''(t) + x'(t) + x(t) = f(t).
%
% Introduzindo
%
%          u(t) = x(t),       v(t) = x'(t),
%
% obtemos o sistema de primeira ordem
%
%          u' = v,
%          v' = -u - v + f(t).
%
% Em forma matricial:
%
%          U'(t) = A U(t) + b(t),
%
% com
%
%          U(t) = [u(t); v(t)],
%
%          A    = [ 0   1;
%                  -1  -1],
%
%          b(t) = [0; f(t)].
%
% A solucao exata fabricada e
%
%          x_ex(t) = sin(t) + cos(2t).
%
% Assim, a forcante f(t) e escolhida para que x_ex satisfaca a EDO:
%
%          f(t) = x_ex''(t) + x_ex'(t) + x_ex(t).
%
% Esse tipo de teste e usado na IC para verificar se o algoritmo recupera
% corretamente uma solucao periodica conhecida.

% Limpa variaveis antigas da memoria.
% Isso evita que valores calculados em execucoes anteriores interfiram no teste.
clear;

% Limpa a janela de comandos.
% Nao altera a matematica, apenas melhora a leitura da execucao.
clc;

% Fecha figuras abertas anteriormente.
% Assim, os graficos produzidos por este script aparecem isoladamente.
close all;

% -------------------------------------------------------------------------
% 1. DADOS DO SISTEMA
% -------------------------------------------------------------------------

% Matriz A do sistema U' = A U + b(t).
% Ela vem da transformacao da EDO escalar x'' + x' + x = f(t)
% no sistema de primeira ordem U = [x; x'].
A = [0 1; -1 -1];

% Periodo temporal do problema.
% Como a solucao exata envolve sin(t) e cos(2t), um periodo comum e 2*pi.
T = 2*pi;

% Maior modo de Fourier mantido na aproximacao.
% Serao usados os modos k = -K, ..., -1, 0, 1, ..., K.
K = 8;

% Numero total de modos de Fourier.
% Ha K modos negativos, K modos positivos e o modo zero.
% Portanto, Nt = 2K + 1.
Nt = 2*K + 1;

% Numero de pontos usados apenas para avaliar e desenhar a solucao.
% Esta malha e mais fina que a malha da FFT para produzir graficos suaves.
Nplot = 400;

% Vetor de tempos em que a solucao sera reconstruida para comparacao grafica.
% Aqui inclui-se o intervalo completo [0,T].
times = linspace(0, T, Nplot);

% -------------------------------------------------------------------------
% 2. CALCULO DA SOLUCAO PERIODICA APROXIMADA
% -------------------------------------------------------------------------

% Chama a rotina que implementa o metodo de Fourier no tempo.
% Entrada:
%   A     : matriz do sistema;
%   T     : periodo;
%   times : tempos em que queremos avaliar a solucao;
%   K     : numero maximo de modos positivos e negativos.
% Saida:
%   U_aprox : matriz 2 x Nplot com as duas componentes de U(t);
%   info    : estrutura com dados auxiliares, como Nt e numero de condicao.
[U_aprox, info] = periodic_solution_fourier_2x2(A, T, times, K);

% A solucao vetorial e U(t) = [x(t); x'(t)].
% A primeira linha de U_aprox contem a aproximacao de x(t).
x_aprox = U_aprox(1,:);

% Calcula a solucao exata nos mesmos tempos.
x_ex = x_exata(times);

% Erro ponto a ponto na primeira componente.
% Aqui comparamos a aproximacao numerica de x(t) com a solucao exata.
erro = x_ex - x_aprox;

% -------------------------------------------------------------------------
% 3. DIAGNOSTICOS NUMERICOS
% -------------------------------------------------------------------------

% Exibe o numero total de modos/pontos usados pela FFT.
% No metodo espectral temporal, Nt tambem e o numero de amostras no periodo.
fprintf('Numero total de modos/pontos da FFT: Nt = %d\n', info.Nt);

% Exibe o maior numero de condicao entre as matrizes
%     M_k = i k omega I - A.
% Esse diagnostico aparece na IC porque indica a estabilidade da resolucao
% dos sistemas lineares modo a modo.
fprintf('Maximo numero de condicao: %.6e\n', info.max_cond);

% Exibe o erro maximo em norma infinito na primeira componente.
% Como a solucao fabricada e conhecida, esse erro mede diretamente a precisao.
fprintf('Erro maximo em norma infinito: %.6e\n', max(abs(erro)));

% -------------------------------------------------------------------------
% 4. GRAFICOS DA SOLUCAO E DO ERRO
% -------------------------------------------------------------------------

% Primeiro grafico: solucao exata e solucao aproximada.
figure;
plot(times, x_ex, 'LineWidth', 1.5); hold on;
plot(times, x_aprox, '--', 'LineWidth', 1.5);
xlabel('t');
ylabel('x(t)');
legend('solucao exata', 'solucao aproximada');
grid on;
title('Sistema 2x2: solucao exata e aproximada');

% Segundo grafico: erro ponto a ponto.
% Na IC, esse grafico serve para evidenciar visualmente se a aproximacao
% acompanha a solucao periodica ao longo de todo o periodo.
figure;
plot(times, erro, 'LineWidth', 1.5);
xlabel('t');
ylabel('erro(t)');
grid on;
title('Sistema 2x2: erro na primeira componente');


% ========================================================================
% FUNCOES AUXILIARES
% ========================================================================

function x = x_exata(t)
    % x_exata
    % ---------------------------------------------------------------------
    % Solucao exata fabricada para validar o metodo.
    % A funcao e 2*pi-periodica e contem dois modos temporais simples:
    %   sin(t)    -> modo de frequencia 1;
    %   cos(2t)  -> modo de frequencia 2.
    % Isso e util porque a solucao tem representacao exata por poucos modos.
    x = sin(t) + cos(2*t);
end
function b = bfun(t)
    % bfun
    % ---------------------------------------------------------------------
    % Termo forcante vetorial b(t) para o sistema U' = A U + b(t).
    %
    % A EDO escalar e
    %     x'' + x' + x = f(t).
    %
    % Como U = [x; x'], o termo forcante entra somente na segunda equacao:
    %     b(t) = [0; f(t)].
    %
    % Para x_ex(t) = sin(t) + cos(2t), temos
    %     x_ex'(t)  = cos(t) - 2 sin(2t),
    %     x_ex''(t) = -sin(t) - 4 cos(2t).
    %
    % Logo,
    %     f(t) = x_ex'' + x_ex' + x_ex
    %          = -2 sin(2t) + cos(t) - 3 cos(2t).
    f = -2*sin(2*t) + cos(t) - 3*cos(2*t);

    % Vetor forcante compativel com U = [x; x'].
    b = [0; f];
end
function [U, info] = periodic_solution_fourier_2x2(A, T, times, K)
    % periodic_solution_fourier_2x2
    % ---------------------------------------------------------------------
    % Implementa o algoritmo espectral de Fourier no tempo para
    %
    %     U'(t) = A U(t) + b(t),
    %
    % procurando diretamente uma solucao T-periodica.
    %
    % Fundamentacao teorica usada na IC:
    %
    % Se
    %     U(t) = soma_k U_hat_k exp(i k omega t)
    % e
    %     b(t) = soma_k b_hat_k exp(i k omega t),
    % entao
    %     U'(t) = soma_k i k omega U_hat_k exp(i k omega t).
    %
    % Substituindo em U' = A U + b e comparando modos de Fourier:
    %
    %     (i k omega I - A) U_hat_k = b_hat_k.
    %
    % Portanto, o problema diferencial periodico e convertido em varios
    % sistemas lineares independentes, um para cada modo k.

    % Dimensao do sistema.
    % Neste teste, n = 2, mas a rotina e escrita de modo mais geral.
    n = size(A,1);

    % Frequencia angular fundamental.
    % Como T = 2*pi neste exemplo, omega = 1.
    omega = 2*pi/T;

    % Numero total de modos e tambem de pontos de amostragem da FFT.
    Nt = 2*K + 1;

    % Frequencias na ordem natural da FFT para Nt = 2K+1:
    %   0, 1, ..., K, -K, ..., -1.
    % Essa ordem evita a necessidade de rearranjar os coeficientes.
    freqs = [0:K, -K:-1];

    % Malha periodica usada para amostrar a forcante.
    % Usa-se [0,T), e nao [0,T], porque b(0) = b(T) em funcoes periodicas.
    % Repetir o ponto final duplicaria a mesma informacao.
    tau = (0:Nt-1) * T / Nt;

    % Matriz de amostras da forcante.
    % Cada coluna B(:,j) e o vetor b(tau_j).
    B = zeros(n, Nt);

    % Avaliacao da forcante nos Nt pontos temporais.
    for j = 1:Nt
        B(:,j) = bfun(tau(j));
    end
    % FFT em relacao a variavel temporal.
    % Como o tempo varia nas colunas de B, aplicamos fft na dimensao 2.
    % A divisao por Nt fornece a normalizacao dos coeficientes de Fourier.
    B_hat = fft(B, [], 2) / Nt;

    % Matriz que armazenara os coeficientes de Fourier da solucao.
    % Cada coluna U_hat(:,idx) corresponde a um modo temporal.
    U_hat = zeros(n, Nt);

    % Matriz identidade usada em M_k = i k omega I - A.
    I = eye(n);

    % Inicializa o maior numero de condicao encontrado.
    max_cond = 0;

    % Loop sobre os modos de Fourier.
    for idx = 1:Nt
        % Frequencia inteira associada a coluna idx da FFT.
        k = freqs(idx);

        % Matriz do sistema linear do modo k.
        % Esta linha e a traducao computacional de
        %     (i k omega I - A) U_hat_k = b_hat_k.
        M = 1i*k*omega*I - A;

        % Atualiza o maior numero de condicao.
        % Na IC, esse valor ajuda a interpretar possiveis perdas de precisao.
        max_cond = max(max_cond, cond(M));

        % Resolve o sistema linear do modo k.
        % O operador \ e preferivel a inv(M)*B_hat(:,idx), pois e mais estavel.
        U_hat(:,idx) = M \ B_hat(:,idx);
    end
    % Numero de tempos onde a solucao sera reconstruida.
    Neval = length(times);

    % Matriz que armazenara a solucao reconstruida.
    U = zeros(n, Neval);

    % Reconstrucao da solucao nos tempos desejados.
    for j = 1:Neval
        % Tempo atual.
        t = times(j);

        % Vetor com os fatores exp(i k omega t) para todos os modos.
        phase = exp(1i*freqs*omega*t);

        % Soma modal:
        %     U(t) = soma_k U_hat_k exp(i k omega t).
        % O resultado teorico e real; pequenas partes imaginarias podem surgir
        % apenas por arredondamento numerico.
        U(:,j) = real(U_hat * phase.');
    end
    % Informacoes uteis retornadas para diagnostico e relatorio.
    info.Nt = Nt;
    info.freqs = freqs;
    info.max_cond = max_cond;
end