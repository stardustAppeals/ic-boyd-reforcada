% EXPERIMENTOS_REGULARIDADE_FOURIER_COMENTADO_ASCII
%
% Este arquivo gera dois experimentos complementares para a IC.
% O objetivo e estudar como a regularidade da funcao influencia
% a convergencia de aproximacoes espectrais de Fourier.
%
% Experimento 1: u(t) = exp(cos(t)).
% Esta funcao e suave e periodica. Ela possui infinitos harmonicos,
% mas seus coeficientes de Fourier decaem rapidamente. O teste e feito
% usando a rotina generica para o sistema U' = A U + b(t).
%
% Experimento 2: u(t) = abs(sin(t)).
% Esta funcao e periodica e continua, mas nao e diferenciavel nos pontos
% t = k*pi. Por isso, nao e usada aqui como solucao classica de uma EDO.
% Ela e usada apenas para testar a aproximacao espectral direta por Fourier
% e evidenciar a perda de convergencia quando a regularidade diminui.
%
% Os resultados esperados sao:
% - exp(cos(t)): convergencia rapida, ate a precisao de maquina;
% - abs(sin(t)): convergencia mais lenta, associada ao decaimento algebrico
%   dos coeficientes de Fourier.

clear; clc; close all;

% Periodo comum aos dois exemplos.
T = 2*pi;

% Lista de modos de Fourier usados nos testes.
K_list = [1 2 4 8 16 32 64];

% Tempos finos para avaliar erro e plotar resultados.
times = linspace(0, T, 1200);
times(end) = [];

% -------------------------------------------------------------------------
% EXPERIMENTO 1: u(t) = exp(cos(t))
% -------------------------------------------------------------------------

% Matriz do sistema de segunda ordem escrito como sistema de primeira ordem.
% Corresponde a x'' + x' + x = f(t).
A = [0 1; -1 -1];

% Solucao exata escalar e suas derivadas.
u = @(t) exp(cos(t));
up = @(t) -sin(t).*exp(cos(t));
upp = @(t) (sin(t).^2 - cos(t)).*exp(cos(t));

% Solucao vetorial U=(u,u').
uex = @(t) [u(t); up(t)];

% Forcante vetorial b(t)=U'(t)-A U(t).
% Como U=(u,u'), obtemos b(t)=[0; u''+u'+u].
bfun = @(t) [0; upp(t) + up(t) + u(t)];

% Vetores para guardar erro, residuo e condicionamento.
err_ecos = zeros(size(K_list));
res_ecos = zeros(size(K_list));
cond_ecos = zeros(size(K_list));

for m = 1:length(K_list)
    K = K_list(m);
    resultado = periodic_solution_fourier_generico(A, T, K, bfun, times, uex);
    err_ecos(m) = resultado.erro_max;
    res_ecos(m) = resultado.residuo_max;
    cond_ecos(m) = resultado.cond_max;
end

% Salva tabela do experimento suave.
tabela_ecos = [K_list(:), (2*K_list(:)+1), err_ecos(:), res_ecos(:), cond_ecos(:)];
csvwrite('tabela_regularidade_ecos.csv', tabela_ecos);

% Grafico do erro.
figure;
semilogy(K_list, err_ecos, 'o-', 'LineWidth', 1.5);
grid on;
xlabel('K'); ylabel('erro maximo');
title('Convergencia para u(t)=exp(cos(t))');
print('grafico_regularidade_erro_ecos.png','-dpng','-r300');

% Grafico do residuo.
figure;
semilogy(K_list, res_ecos, 'o-', 'LineWidth', 1.5);
grid on;
xlabel('K'); ylabel('residuo maximo');
title('Residuo para u(t)=exp(cos(t))');
print('grafico_regularidade_residuo_ecos.png','-dpng','-r300');

% -------------------------------------------------------------------------
% EXPERIMENTO 2: u(t) = |sin(t)|
% -------------------------------------------------------------------------

% Este teste nao usa a rotina de EDO, pois |sin(t)| nao e diferenciavel
% nos pontos k*pi. A finalidade aqui e estudar a aproximacao espectral
% direta da funcao e comparar seu comportamento com o caso suave.
K_list_abs = [2 4 8 16 32 64 128];
tfine = linspace(0,T,5000);
tfine(end) = [];
uabs_exata = abs(sin(tfine));
err_abs = zeros(size(K_list_abs));

for m = 1:length(K_list_abs)
    K = K_list_abs(m);
    Nt = 2*K + 1;
    ts = linspace(0,T,Nt+1);
    ts(end) = [];
    vals = abs(sin(ts));

    % Coeficientes discretos de Fourier.
    C = fft(vals)/Nt;

    % Mapeamento das frequencias na ordem natural da FFT.
    freqs = zeros(1,Nt);
    for idx = 1:Nt
        k = idx-1;
        if k <= K
            freqs(idx) = k;
        else
            freqs(idx) = k - Nt;
        end
    end

    % Reconstrucao na malha fina.
    urec = zeros(size(tfine));
    for idx = 1:Nt
        urec = urec + real(C(idx)*exp(1i*freqs(idx)*tfine));
    end

    err_abs(m) = max(abs(urec - uabs_exata));
end

% Salva tabela do caso menos regular.
tabela_abs = [K_list_abs(:), (2*K_list_abs(:)+1), err_abs(:)];
csvwrite('tabela_regularidade_abs_sin.csv', tabela_abs);

% Grafico do erro.
figure;
loglog(K_list_abs, err_abs, 'o-', 'LineWidth', 1.5);
grid on;
xlabel('K'); ylabel('erro maximo');
title('Convergencia para u(t)=|sin(t)|');
print('grafico_regularidade_erro_abs_sin.png','-dpng','-r300');

% Grafico comparativo de aproximacoes para K=4,16,64.
figure;
plot(tfine, uabs_exata, 'k-', 'LineWidth', 1.5); hold on;
for K = [4 16 64]
    Nt = 2*K + 1;
    ts = linspace(0,T,Nt+1); ts(end) = [];
    vals = abs(sin(ts));
    C = fft(vals)/Nt;
    freqs = zeros(1,Nt);
    for idx = 1:Nt
        k = idx-1;
        if k <= K
            freqs(idx) = k;
        else
            freqs(idx) = k - Nt;
        end
    end
    urec = zeros(size(tfine));
    for idx = 1:Nt
        urec = urec + real(C(idx)*exp(1i*freqs(idx)*tfine));
    end
    plot(tfine, urec, 'LineWidth', 1.0);
end
xlim([0 pi]); grid on;
xlabel('t'); ylabel('u(t)');
title('Aproximacao de u(t)=|sin(t)|');
legend('exata','K=4','K=16','K=64');
print('grafico_regularidade_aproximacao_abs_sin.png','-dpng','-r300');
