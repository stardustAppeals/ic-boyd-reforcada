function [erro_reportado, U_aprox, info] = EqCalor2D_timeperiodic_SPECTRAL_COMENTADO(NM, K)
% EqCalor2D_timeperiodic_SPECTRAL_COMENTADO
%
% -------------------------------------------------------------------------
% OBJETIVO DO ARQUIVO
% -------------------------------------------------------------------------
% Este codigo implementa a formulacao Fourier--Chebyshev estudada na IC
% para a equacao do calor bidimensional periodica no tempo:
%
%     u_t(x,y,t) = Delta u(x,y,t) + f(x,y,t),
%     (x,y) em (-1,1) x (-1,1),
%     u = 0 na fronteira,
%     u(x,y,t+T) = u(x,y,t),  com T = 2*pi.
%
% A estrutura metodologica e exatamente a descrita no relatorio:
%
%   1) Chebyshev no espaco:
%      discretiza as variaveis x e y em pontos de Chebyshev--Gauss--Lobatto.
%
%   2) A EDP vira um sistema semidiscreto no tempo:
%          U'(t) = A U(t) + b(t),
%      onde A e o Laplaciano discreto 2D e U(t) contem os valores da solucao
%      nos pontos internos da malha espacial.
%
%   3) Fourier no tempo:
%      como a solucao e periodica, representa-se U(t) por modos de Fourier.
%
%   4) Para cada modo temporal k, resolve-se:
%          (i k omega I - A) U_hat_k = b_hat_k.
%
%   5) A solucao e reconstruida por soma modal:
%          U(t) = soma_k U_hat_k exp(i k omega t).
%
% Este codigo e a continuacao natural do teste 2x2: no teste 2x2, o sistema
% U'=AU+b(t) ja estava dado; aqui, ele surge apos discretizar a EDP no espaco.
%
% -------------------------------------------------------------------------
% ENTRADAS
% -------------------------------------------------------------------------
% NM : parametro da malha de Chebyshev.
%      A malha total tem NM+1 pontos em cada direcao.
%      Como as condicoes de Dirichlet impoem u=0 na fronteira, as incognitas
%      ficam apenas nos NM-1 pontos internos de cada direcao.
%
% K  : maior modo de Fourier usado no tempo.
%      O numero total de modos temporais e Nt = 2K+1.
%
% -------------------------------------------------------------------------
% SAIDAS
% -------------------------------------------------------------------------
% erro_reportado : erro maximo absoluto entre a solucao aproximada
%                  e a solucao exata fabricada, isto e,
%                  max(abs(U_aprox - U_ex)(:)).
%
% U_aprox        : matriz com a solucao aproximada nos pontos espaciais
%                  internos e nos tempos da malha de Fourier.
%
% info           : estrutura com dados auxiliares da simulacao.
%
% Exemplo de uso:
%     [erro, U, info] = EqCalor2D_timeperiodic_SPECTRAL_COMENTADO(32, 8);

    % Se o usuario nao informar NM, o programa solicita no console.
    if nargin < 1
        NM = input('Valor de NM (Chebyshev): ');
    end
    % Se o usuario nao informar K, o programa solicita no console.
    if nargin < 2
        K = input('Valor de K (modos de Fourier): ');
    end
    % ---------------------------------------------------------------------
    % 1. DISCRETIZACAO ESPACIAL POR CHEBYSHEV
    % ---------------------------------------------------------------------

    % Calcula a matriz de diferenciacao de Chebyshev D e os pontos x.
    % A matriz D aproxima a derivada primeira nos pontos de Chebyshev.
    % Essa rotina e a formulacao classica de Trefethen.
    [D, x] = cheb(NM);

    % Usa-se a mesma malha de Chebyshev na variavel y.
    y = x;

    % Remove os pontos de fronteira.
    % A malha total e x(1), x(2), ..., x(NM+1).
    % Os extremos x(1) e x(NM+1) correspondem a fronteira.
    % Como a condicao de Dirichlet e homogenea, u=0 nesses pontos, logo
    % eles nao sao incognitas do sistema linear.
    xint = x(2:NM);
    yint = y(2:NM);

    % Cria uma malha bidimensional com os pontos internos.
    % xx e yy inicialmente sao matrizes de coordenadas dos pontos internos.
    [xx, yy] = meshgrid(xint, yint);

    % Transforma as matrizes 2D em vetores coluna.
    % Isso e necessario porque a solucao U(t) sera armazenada como vetor.
    % Cada entrada de U(t) corresponde a um ponto interno (x_i,y_j).
    xx = xx(:);
    yy = yy(:);

    % Calcula a matriz de segunda derivada em uma dimensao.
    % Como D aproxima d/dx, D*D aproxima d^2/dx^2.
    D2 = D*D;

    % Remove linhas e colunas associadas a fronteira.
    % A matriz D2 reduzida atua apenas sobre os pontos internos.
    D2 = D2(2:NM, 2:NM);

    % Matriz identidade espacial em uma direcao.
    % Seu tamanho e NM-1 porque ha NM-1 pontos internos.
    Isp = eye(NM-1);

    % Laplaciano discreto bidimensional.
    % Na forma continua:
    %     Delta u = u_xx + u_yy.
    % Na forma discreta vetorizada:
    %     A = I \otimes D2 + D2 \otimes I.
    % O produto de Kronecker permite representar a acao separada das
    % derivadas nas direcoes x e y.
    A = kron(Isp, D2) + kron(D2, Isp);

    % Numero total de incognitas espaciais.
    % Como ha NM-1 pontos internos em x e NM-1 em y, espera-se
    %     n_spatial = (NM-1)^2.
    n_spatial = size(A,1);

    % ---------------------------------------------------------------------
    % 2. DISCRETIZACAO TEMPORAL POR FOURIER
    % ---------------------------------------------------------------------

    % Periodo temporal do problema.
    % A solucao fabricada usa cos(t), portanto T = 2*pi.
    T = 2*pi;

    % Numero total de modos/pontos temporais.
    % Sao usados os modos k = -K, ..., 0, ..., K.
    Nt = 2*K + 1;

    % Malha periodica temporal em [0,T).
    % Nao incluimos T porque t=0 e t=T representam o mesmo ponto do periodo.
    tt = (0:Nt-1) * T / Nt;

    % ---------------------------------------------------------------------
    % 3. RESOLUCAO ESPECTRAL NO TEMPO
    % ---------------------------------------------------------------------

    % A funcao resolve_fourier_temporal implementa a mesma ideia do codigo 2x2:
    %   - amostra b(t);
    %   - calcula b_hat por FFT;
    %   - resolve (i k omega I - A) U_hat_k = b_hat_k;
    %   - reconstroi U(t).
    [max_cond, U_aprox, U_hat, B_hat, freqs] = resolve_fourier_temporal(A, T, K, xx, yy, tt);

    % ---------------------------------------------------------------------
    % 4. VALIDACAO POR SOLUCAO FABRICADA
    % ---------------------------------------------------------------------

    % Calcula a solucao exata nos pontos internos e nos tempos tt.
    % A solucao fabricada foi escolhida para satisfazer:
    %   - periodicidade temporal;
    %   - condicao de Dirichlet homogenea na fronteira.
    U_ex = solucao_exata(xx, yy, tt);

    % Erro absoluto ponto a ponto entre a solucao aproximada e a solucao exata.
    erro_abs = abs(U_aprox - U_ex);

    % Erro principal usado na IC:
    %     erro_max = max(abs(U_aprox - U_ex)(:)).
    % A forma abaixo e equivalente e mais compativel com MATLAB/Octave.
    erro_max = max(erro_abs(:));

    % Mantemos a norma 1 temporal apenas como diagnostico secundario.
    erro_norma1 = zeros(1, Nt);
    for j = 1:Nt
        erro_norma1(j) = norm(U_aprox(:,j) - U_ex(:,j), 1);
    end
    erro_l1_total = norm(erro_norma1, 1);

    % A variavel retornada pela funcao agora representa o erro maximo.
    erro_reportado = erro_max;

    % ---------------------------------------------------------------------
    % 5. SAIDA DE INFORMACOES PARA INTERPRETACAO DOS RESULTADOS
    % ---------------------------------------------------------------------

    % Imprime os parametros principais da simulacao.
    fprintf('NM = %d, K = %d, Nt = %d\n', NM, K, Nt);

    % Imprime o numero de incognitas espaciais.
    fprintf('Numero de pontos internos no espaco: %d\n', n_spatial);

    % Imprime o maior numero de condicao entre os sistemas modais.
    % Esse valor ajuda a interpretar a tabela da IC: quando NM cresce,
    % as matrizes espectrais de Chebyshev tendem a ficar mais mal condicionadas.
    fprintf('Maximo numero de condicao: %.6e\n', max_cond);

    % Imprime o erro na metrica usada no codigo.
    fprintf('Erro maximo: %.6e\n', erro_reportado);

    % Guarda informacoes uteis em uma estrutura.
    % Isso facilita gerar tabelas, graficos e analises posteriores na IC.
    info.NM = NM;
    info.K = K;
    info.Nt = Nt;
    info.T = T;
    info.x = x;
    info.xint = xint;
    info.yint = yint;
    info.xx = xx;
    info.yy = yy;
    info.A = A;
    info.freqs = freqs;
    info.U_hat = U_hat;
    info.B_hat = B_hat;
    info.erro_norma1 = erro_norma1;
    info.erro_l1_total = erro_l1_total;
    info.erro_max = erro_max;
    info.max_cond = max_cond;
end
% ========================================================================
% ROTINA TEMPORAL FOURIER
% ========================================================================
function [max_cond, U, U_hat, B_hat, freqs] = resolve_fourier_temporal(A, T, K, xx, yy, tt)
    % resolve_fourier_temporal
    % ---------------------------------------------------------------------
    % Esta rotina recebe o sistema semidiscreto
    %
    %     U'(t) = A U(t) + b(t)
    %
    % e aplica Fourier no tempo.
    %
    % Ela e a parte comum entre o codigo 2x2 e o codigo da equacao do calor.
    % No codigo 2x2, A e pequena e dada diretamente.
    % Aqui, A e grande e vem da discretizacao de Chebyshev do Laplaciano.

    % Dimensao do sistema semidiscreto.
    n = size(A,1);

    % Frequencia angular fundamental.
    omega = 2*pi/T;

    % Numero de pontos temporais.
    Nt = length(tt);

    % Frequencias na ordem natural da FFT.
    % Para Nt=2K+1, a ordem e:
    %     0, 1, ..., K, -K, ..., -1.
    % Essa convencao e compativel com os coeficientes retornados por fft.
    freqs = [0:K, -K:-1];

    % Matriz de amostras da forcante.
    % Cada coluna B(:,j) representa b(t_j), isto e, f(x_i,y_i,t_j)
    % avaliada nos pontos internos e organizada como vetor.
    B = zeros(n, Nt);

    % Avalia a forcante em todos os tempos da malha periodica.
    for j = 1:Nt
        B(:,j) = calcula_forcante(xx, yy, tt(j));
    end
    % Calcula os coeficientes de Fourier da forcante.
    % A FFT e aplicada na segunda dimensao porque o tempo varia nas colunas.
    % O resultado B_hat contem os vetores b_hat_k.
    B_hat = fft(B, [], 2) / Nt;

    % Inicializa a matriz dos coeficientes de Fourier da solucao.
    % Cada coluna U_hat(:,idx) sera o vetor U_hat_k.
    U_hat = zeros(n, Nt);

    % Identidade da dimensao espacial semidiscreta.
    I = eye(n);

    % Inicializa o maior numero de condicao encontrado.
    max_cond = 0;

    % Loop sobre cada modo temporal.
    for idx = 1:Nt
        % Frequencia inteira associada ao indice idx.
        k = freqs(idx);

        % Matriz modal.
        % Esta e a matriz do sistema linear associado ao modo k:
        %     (i k omega I - A) U_hat_k = b_hat_k.
        M = 1i*k*omega*I - A;

        % Atualiza o maior numero de condicao, usando norma 1 para manter
        % compatibilidade com a metrica do codigo original.
        max_cond = max(max_cond, cond(M,1));

        % Resolve o sistema linear modal.
        % O lado direito e o coeficiente de Fourier da forcante.
        U_hat(:,idx) = M \ B_hat(:,idx);
    end
    % Reconstroi a solucao nos tempos da propria malha temporal.
    U = zeros(n, Nt);

    for j = 1:Nt
        % Fatores exp(i k omega t_j) para todos os modos.
        phase = exp(1i*freqs*omega*tt(j));

        % Soma modal da solucao aproximada.
        % O operador real remove residuos imaginarios de arredondamento.
        U(:,j) = real(U_hat * phase.');
    end
end
% ========================================================================
% MATRIZ DE DIFERENCIACAO DE CHEBYSHEV
% ========================================================================
function [D, x] = cheb(N)
    % cheb
    % ---------------------------------------------------------------------
    % Retorna os pontos de Chebyshev--Gauss--Lobatto e a matriz de
    % diferenciacao espectral de Chebyshev.
    %
    % Os pontos sao
    %     x_j = cos(j*pi/N),     j = 0, ..., N.
    %
    % Essa escolha concentra pontos perto das extremidades do intervalo,
    % o que ajuda a controlar oscilacoes de interpolacao em dominios limitados.

    % Caso degenerado: N=0.
    if N == 0
        D = 0;
        x = 1;
        return;
    end
    % Pontos de Chebyshev--Gauss--Lobatto no intervalo [-1,1].
    x = cos(pi*(0:N)/N)';

    % Vetor de pesos auxiliares usado na construcao explicita de D.
    c = [2; ones(N-1,1); 2] .* (-1).^(0:N)';

    % Matrizes com as coordenadas repetidas.
    X = repmat(x, 1, N+1);

    % Diferencas x_i - x_j.
    dX = X - X';

    % Formula explicita para as entradas fora da diagonal de D.
    % O termo eye(N+1) evita divisao por zero na diagonal temporariamente.
    D = (c*(1./c)')./(dX + eye(N+1));

    % Ajusta as entradas diagonais para que cada linha some zero.
    % Isso garante, por exemplo, que a derivada de uma funcao constante seja zero.
    D = D - diag(sum(D'));
end
% ========================================================================
% FORCANTE FABRICADA: f = u_t - Delta u
% ========================================================================
function b = calcula_forcante(x, y, t)
    % calcula_forcante
    % ---------------------------------------------------------------------
    % Constroi a forcante f(x,y,t) a partir de uma solucao exata fabricada.
    %
    % A solucao escolhida e
    %
    %     u(x,y,t) = -cos(t) sin(pi cos(pi x)) sin(pi cos(pi y)).
    %
    % Ela e adequada porque:
    %   1) e 2*pi-periodica no tempo;
    %   2) anula-se na fronteira x = +-1 e y = +-1;
    %   3) e suave, favorecendo o comportamento espectral.
    %
    % Como a equacao e
    %     u_t = Delta u + f,
    % a forcante correspondente e
    %     f = u_t - Delta u.

    % Parte espacial dependente de x.
    gx = sin(pi*cos(pi*x));

    % Parte espacial dependente de y.
    gy = sin(pi*cos(pi*y));

    % Derivada temporal de u.
    % Como u = -cos(t) gx gy, entao u_t = sin(t) gx gy.
    u_t = sin(t) .* gx .* gy;

    % Segunda derivada em x.
    % As variaveis auxiliares separam a expressao analitica de u_xx.
    aux_x1 = pi^2 .* gy .* cos(t);
    aux_x2 = pi .* cos(pi*x) .* cos(pi*cos(pi*x));
    aux_x3 = pi^2 .* (sin(pi*x).^2) .* sin(pi*cos(pi*x));
    u_xx = aux_x1 .* (aux_x2 + aux_x3);

    % Segunda derivada em y.
    aux_y1 = pi^2 .* gx .* cos(t);
    aux_y2 = pi .* cos(pi*y) .* cos(pi*cos(pi*y));
    aux_y3 = pi^2 .* (sin(pi*y).^2) .* sin(pi*cos(pi*y));
    u_yy = aux_y1 .* (aux_y2 + aux_y3);

    % Forcante da equacao do calor:
    %     f = u_t - (u_xx + u_yy).
    % O vetor b corresponde a f avaliada nos pontos internos.
    b = u_t - (u_xx + u_yy);
end
% ========================================================================
% SOLUCAO EXATA FABRICADA
% ========================================================================
function U = solucao_exata(xx, yy, tt)
    % solucao_exata
    % ---------------------------------------------------------------------
    % Calcula a solucao exata fabricada nos pontos internos e tempos dados.
    %
    % Entrada:
    %   xx, yy : vetores com coordenadas dos pontos internos;
    %   tt     : vetor de tempos.
    %
    % Saida:
    %   U      : matriz n_spatial x Nt.
    %            Cada coluna contem a solucao exata em um instante temporal.

    % Parte espacial da solucao.
    g = sin(pi*cos(pi*xx)) .* sin(pi*cos(pi*yy));

    % Multiplicacao externa entre a parte espacial e a parte temporal.
    % Resultado: cada coluna corresponde a um tempo de tt.
    U = g * (-cos(tt));
end