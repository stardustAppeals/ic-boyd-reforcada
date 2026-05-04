function resultado = periodic_solution_fourier_generico(A, T, K, bfun, tempos, uexata_fun, cond_threshold)
% PERIODIC_SOLUTION_FOURIER_GENERICO
% -------------------------------------------------------------------------
% Rotina generica para aproximar a solucao periodica do sistema linear
%
%       U'(t) = A U(t) + b(t),       b(t+T) = b(t),
%
% usando expansao de Fourier no tempo.
%
% Esta rotina e uma versao mais geral do codigo usado no teste 2x2 da IC.
% A diferenca principal e que agora a matriz A e a funcao b(t) sao fornecidas
% pelo usuario. Assim, a mesma implementacao pode ser usada para diferentes
% sistemas lineares finito-dimensionais.
%
% ENTRADAS:
%   A          : matriz constante n x n do sistema.
%   T          : periodo temporal positivo.
%   K          : numero maximo de modos positivos e negativos de Fourier.
%   bfun       : funcao que recebe um escalar t e devolve um vetor coluna n x 1.
%   tempos     : vetor com os tempos em que a solucao sera reconstruida.
%   uexata_fun : opcional. Funcao exata para validacao. Deve receber t e
%                devolver vetor coluna n x 1 ou matriz n x length(t).
%   cond_threshold : opcional. Limite para o numero de condicao modal.
%
% SAIDA:
%   resultado  : estrutura contendo:
%       resultado.u              valores aproximados de U(t)
%       resultado.tempos         tempos de avaliacao
%       resultado.U_fft          coeficientes de Fourier da solucao
%       resultado.B_fft          coeficientes de Fourier da forcante
%       resultado.freqs          frequencias inteiras usadas pela FFT
%       resultado.residuo        residuo R(t)=U'(t)-A*U(t)-b(t)
%       resultado.residuo_max    norma infinito maxima do residuo
%       resultado.cond_max       maior numero de condicao entre os modos
%       resultado.erro           erro, se uexata_fun for fornecida
%       resultado.erro_max       erro maximo, se uexata_fun for fornecida
%
% RESTRICOES MATEMATICAS IMPORTANTES:
%   1. A matriz A deve ser quadrada e constante.
%   2. A funcao bfun deve ser T-periodica, ou aproximadamente T-periodica
%      no intervalo de amostragem.
%   3. bfun(t) deve devolver sempre um vetor coluna com a mesma dimensao de A.
%   4. Para que os sistemas modais sejam bem postos, as matrizes
%
%          (i*k*omega*I - A)
%
%      devem ser inversiveis, ou pelo menos numericamente bem condicionadas,
%      para os modos k utilizados.
%   5. Quanto mais suave for b(t), melhor tende a ser a convergencia espectral.
%
% FUNDAMENTACAO NA IC:
%   A rotina implementa diretamente a formula modal
%
%          (i*k*omega*I - A) U_k = b_k,
%
%   obtida ao substituir as expansoes
%
%          U(t) = sum U_k exp(i*k*omega*t),
%          b(t) = sum b_k exp(i*k*omega*t)
%
%   no sistema diferencial U'=AU+b.
% -------------------------------------------------------------------------

    % -------------------------
    % 1. Verificacoes iniciais
    % -------------------------

    % Verifica se A e quadrada. A formulacao U'=AU+b exige A n x n.
    [n_linhas, n_colunas] = size(A);
    if n_linhas ~= n_colunas
        error('A matriz A deve ser quadrada.');
    end
    n = n_linhas;

    % O periodo deve ser positivo.
    if T <= 0
        error('O periodo T deve ser positivo.');
    end

    % K deve ser inteiro nao negativo.
    if K < 0 || K ~= floor(K)
        error('K deve ser um inteiro nao negativo.');
    end

    % Garante que tempos seja vetor linha para facilitar a reconstrucao.
    tempos = tempos(:).';

    % Se a solucao exata nao foi fornecida, usamos lista vazia.
    if nargin < 6
        uexata_fun = [];
    end

    % Limite padrao para o condicionamento modal.
    if nargin < 7 || isempty(cond_threshold)
        cond_threshold = 1e12;
    end

    % Frequencia fundamental associada ao periodo T.
    omega = 2*pi/T;

    % Numero total de modos/pontos de amostragem: -K,...,0,...,K.
    Nt = 2*K + 1;

    % -------------------------
    % 2. Malha periodica
    % -------------------------

    % A malha de amostragem usa Nt pontos em [0,T), sem repetir o ponto T.
    % Isso evita duplicar o mesmo ponto do ciclo, pois b(0)=b(T).
    tau = (0:Nt-1) * T/Nt;

    % -------------------------
    % 3. Amostragem da forcante
    % -------------------------

    % B guarda os valores b(tau_j). Cada coluna e um vetor b(tau_j).
    B = zeros(n, Nt);

    for j = 1:Nt
        bj = bfun(tau(j));
        bj = bj(:);  % garante vetor coluna

        % Verifica compatibilidade dimensional entre b(t) e A.
        if length(bj) ~= n
            error('bfun(t) deve devolver um vetor com %d componentes.', n);
        end

        B(:,j) = bj;
    end

    % -------------------------
    % 4. Coeficientes de Fourier de b(t)
    % -------------------------

    % A FFT e aplicada ao longo da segunda dimensao, isto e, ao longo do tempo.
    % O fator 1/Nt normaliza os coeficientes.
    B_fft = fft(B, [], 2) / Nt;

    % A ordem natural da FFT e: 0,1,...,K,-K,...,-1.
    % O vetor freqs traduz cada coluna para a frequencia inteira correspondente.
    freqs = zeros(1, Nt);
    for idx = 1:Nt
        q = idx - 1;
        if q <= K
            freqs(idx) = q;
        else
            freqs(idx) = q - Nt;
        end
    end

    % -------------------------
    % 5. Resolucao dos sistemas modais
    % -------------------------

    % U_fft guardara os coeficientes de Fourier da solucao.
    U_fft = zeros(n, Nt);
    I = eye(n);
    cond_max = 0;

    for idx = 1:Nt
        k = freqs(idx);

        % Matriz modal obtida de (i*k*omega*I - A) U_k = b_k.
        M = 1i*k*omega*I - A;

        % Numero de condicao: mede a sensibilidade do sistema linear.
        cond_atual = cond(M, 1);
        cond_max = max(cond_max, cond_atual);

        if cond_atual > cond_threshold
            error('Numero de condicao modal %.3e excede o limite %.3e no modo k=%d.', cond_atual, cond_threshold, k);
        end

        % Resolve o sistema linear do modo k.
        U_fft(:,idx) = M \ B_fft(:,idx);
    end

    % -------------------------
    % 6. Reconstrucao da solucao e da derivada
    % -------------------------

    N_eval = length(tempos);
    u = zeros(n, N_eval);
    u_deriv = zeros(n, N_eval);

    for j = 1:N_eval
        t = tempos(j);

        % Vetor com exp(i*k*omega*t) para cada frequencia k.
        fase = exp(1i*freqs*omega*t);

        % Reconstrucao de U(t) pela soma de Fourier.
        u(:,j) = real(U_fft * fase.');

        % Reconstrucao de U'(t). A derivada de exp(i*k*omega*t)
        % e i*k*omega*exp(i*k*omega*t).
        fase_deriv = (1i*freqs*omega) .* fase;
        u_deriv(:,j) = real(U_fft * fase_deriv.');
    end

    % -------------------------
    % 7. Calculo do residuo
    % -------------------------

    residuo = zeros(n, N_eval);
    for j = 1:N_eval
        bj = bfun(tempos(j));
        bj = bj(:);
        residuo(:,j) = u_deriv(:,j) - A*u(:,j) - bj;
    end
    residuo_max = max(max(abs(residuo)));

    % -------------------------
    % 8. Erro em relacao a solucao exata, se fornecida
    % -------------------------

    erro = [];
    erro_max = [];

    if ~isempty(uexata_fun)
        Uex = avaliar_funcao_vetorial(uexata_fun, tempos, n);
        erro = Uex - u;
        erro_max = max(max(abs(erro)));
    end

    % -------------------------
    % 9. Organizacao da saida
    % -------------------------

    resultado.u = u;
    resultado.tempos = tempos;
    resultado.tau = tau;
    resultado.B_amostras = B;
    resultado.B_fft = B_fft;
    resultado.U_fft = U_fft;
    resultado.freqs = freqs;
    resultado.omega = omega;
    resultado.residuo = residuo;
    resultado.residuo_max = residuo_max;
    resultado.cond_max = cond_max;
    resultado.erro = erro;
    resultado.erro_max = erro_max;
end

function valores = avaliar_funcao_vetorial(fun, tempos, n)
% Avalia uma funcao vetorial em varios tempos.
% A funcao pode devolver uma matriz n x length(tempos) de uma vez,
% ou pode devolver um vetor n x 1 para cada tempo escalar.

    try
        valores = fun(tempos);
        if size(valores,1) == n && size(valores,2) == length(tempos)
            return;
        end
    catch
        % Se a avaliacao vetorizada falhar, avaliamos ponto a ponto.
    end

    valores = zeros(n, length(tempos));
    for j = 1:length(tempos)
        v = fun(tempos(j));
        valores(:,j) = v(:);
    end
end
