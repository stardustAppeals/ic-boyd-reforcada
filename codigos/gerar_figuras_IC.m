function gerar_figuras_IC()
% gerar_figuras_IC
% -------------------------------------------------------------------------
% Gera as figuras usadas no Capitulo 5 da IC.
%
% Este script usa os codigos Octave/MATLAB da pasta codigos/ e salva as
% figuras na pasta ../figuras, com os mesmos nomes chamados no LaTeX.
%
% Observacao importante:
% - A coluna "Erro maximo absoluto" do relatorio usa
%       max(abs(U_aprox - U_ex)(:)).
% - A coluna "Erro L1 total" corresponde a um diagnostico acumulado,
%   mantido apenas para comparacao com versoes preliminares.
% -------------------------------------------------------------------------

    close all; clc;

    pasta_atual = fileparts(mfilename('fullpath'));
    pasta_raiz = fileparts(pasta_atual);
    pasta_fig = fullfile(pasta_raiz, 'figuras');

    if ~exist(pasta_fig, 'dir')
        mkdir(pasta_fig);
    end

    addpath(pasta_atual);

    % ------------------------------------------------------------------
    % 1. Sistema 2x2: dados da validacao registrada no texto
    % ------------------------------------------------------------------
    Ks = [1 2 4 8 16 32 64];
    erros_2x2 = [4.2832e0 1.3323e-15 1.7764e-15 1.5543e-15 ...
                 1.1102e-15 6.6613e-16 1.1102e-15];
    residuos_2x2 = [6.5415e0 2.6645e-15 4.4409e-15 3.5527e-15 ...
                    5.7732e-15 5.3291e-15 4.4409e-15];

    figure;
    semilogy(Ks, erros_2x2, '-o', 'LineWidth', 1.4);
    xlabel('K'); ylabel('erro maximo'); grid on;
    title('Convergencia no sistema 2x2');
    salvar_png(fullfile(pasta_fig, 'grafico_convergencia_sistema2x2.png'));

    figure;
    semilogy(Ks, residuos_2x2, '-o', 'LineWidth', 1.4);
    xlabel('K'); ylabel('residuo maximo'); grid on;
    title('Residuo no sistema 2x2');
    salvar_png(fullfile(pasta_fig, 'grafico_residuo_sistema2x2.png'));

    % Erro temporal para K=8, obtido pela rotina generica.
    A = [0 1; -1 -1];
    T = 2*pi;
    K = 8;
    tempos = linspace(0, T, 400);
    bfun = @(t) [0; -2*sin(2*t) + cos(t) - 3*cos(2*t)];
    uexata = @(t) [sin(t) + cos(2*t); cos(t) - 2*sin(2*t)];
    resultado = periodic_solution_fourier_generico(A, T, K, bfun, tempos, uexata);

    figure;
    plot(tempos, resultado.erro(1,:), 'LineWidth', 1.4);
    xlabel('t'); ylabel('erro'); grid on;
    title('Erro no sistema 2x2 para K=8');
    salvar_png(fullfile(pasta_fig, 'grafico_erro_sistema2x2_K8.png'));

    % ------------------------------------------------------------------
    % 2. Equacao do calor 2D: graficos quantitativos
    % ------------------------------------------------------------------
    NCheb = [8 16 32 60 80];
    condicoes = [1.8242e2 2.6766e3 4.1914e4 5.0538e5 1.60e6];
    erro_max = [2.7111e0 2.0527e-2 1.1682e-6 1.75e-14 2.53e-14];
    residuos = [2.70e-13 4.55e-13 1.30e-12 7.45e-12 2.95e-11];

    figure;
    semilogy(NCheb, erro_max, '-o', 'LineWidth', 1.4);
    xlabel('N_{Cheb}'); ylabel('erro maximo absoluto'); grid on;
    title('Erro maximo absoluto na equacao do calor 2D');
    salvar_png(fullfile(pasta_fig, 'grafico_erro_calor2d.png'));

    figure;
    semilogy(NCheb, condicoes, '-o', 'LineWidth', 1.4);
    xlabel('N_{Cheb}'); ylabel('condicao maxima'); grid on;
    title('Condicionamento dos sistemas modais');
    salvar_png(fullfile(pasta_fig, 'grafico_condicao_calor2d.png'));

    figure;
    loglog(condicoes, erro_max, '-o', 'LineWidth', 1.4);
    xlabel('condicao maxima'); ylabel('erro maximo absoluto'); grid on;
    title('Erro versus condicionamento');
    salvar_png(fullfile(pasta_fig, 'grafico_erro_vs_condicao_calor2d.png'));

    figure;
    semilogy(NCheb, residuos, '-o', 'LineWidth', 1.4);
    xlabel('N_{Cheb}'); ylabel('residuo maximo'); grid on;
    title('Residuo maximo na equacao do calor 2D');
    salvar_png(fullfile(pasta_fig, 'grafico_residuo_calor2d.png'));

    % ------------------------------------------------------------------
    % 3. Superficies para NCheb = 8, 16, 32
    % ------------------------------------------------------------------
    for NM = [8 16 32]
        K = 8;
        [erro, U, info] = EqCalor2D_timeperiodic_SPECTRAL_COMENTADO(NM, K); %#ok<ASGLU>

        % Reconstroi a solucao exata no instante t=0 para comparacao visual.
        xx = info.xx;
        yy = info.yy;
        m = NM - 1;
        X = reshape(xx, m, m);
        Y = reshape(yy, m, m);
        U0 = reshape(U(:,1), m, m);
        Uex0 = -cos(0) .* sin(pi*cos(pi*X)) .* sin(pi*cos(pi*Y));
        E0 = abs(U0 - Uex0);

        figure;
        surf(X, Y, U0); shading interp;
        xlabel('x'); ylabel('y'); zlabel('u');
        title(sprintf('Solucao aproximada, NCheb=%d, K=8', NM));
        salvar_png(fullfile(pasta_fig, sprintf('superficie_solucao_calor2d_N%d_K8.png', NM)));

        figure;
        surf(X, Y, E0); shading interp;
        xlabel('x'); ylabel('y'); zlabel('erro');
        title(sprintf('Erro espacial, NCheb=%d, K=8', NM));
        salvar_png(fullfile(pasta_fig, sprintf('superficie_erro_calor2d_N%d_K8.png', NM)));
    end

    fprintf('Figuras geradas em: %s\n', pasta_fig);
end

function salvar_png(nome)
    % Salva a figura atual com resolucao adequada.
    try
        print(gcf, nome, '-dpng', '-r200');
    catch
        saveas(gcf, nome);
    end
end
