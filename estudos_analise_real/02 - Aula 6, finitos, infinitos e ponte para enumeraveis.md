# Caderno 02 — Aula 6: Conjuntos finitos e infinitos (versão fundamentada)

> **Como usar.** Este caderno segue **exatamente a numeração das notas de aula** (seções 0 a 7). Cada seção traz:
> - o enunciado da nota, como está no quadro;
> - a **demonstração completa**, com cada passo justificado por uma etiqueta entre colchetes, como **[D3]** ou **[F2]**. As etiquetas remetem à "caixa de ferramentas" da Seção 0;
> - **exemplos** simples;
> - o **cruzamento com os livros** (página e número do resultado ou exercício).
>
> Os **8 exercícios deixados em aula** estão resolvidos no lugar onde aparecem (marcados com 📝) e reunidos no índice do fim. Depois vêm **exercícios extras** com solução e um apêndice-ponte para conjuntos enumeráveis.
>
> **Fontes:** fotos do quadro da Aula 6 (IMG_7922–7942); T. Tao, *Analysis I* (3ª ed., Springer/HBA 2016), §3.6 e §8.1; A. Maciel e O. Lima, *Introdução à Análise Real* (2ª ed.), §1.6; M. S. Monteiro, *Conjuntos Infinitos* (notas, 2018). As páginas citadas são as **impressas** no livro, não as do visualizador de PDF: no Tao, página impressa = página do PDF − 17; no Maciel, página impressa = página do PDF − 1.
>
> **Observação sobre os livros.** O Tao usa **exatamente a convenção do professor**: $0\in\mathbb N$ e $\{i\in\mathbb N: 1\le i\le n\}$. É o livro mais próximo desta aula. O *Elementos de Análise* (Gonçalves, UFSC) que está na pasta começa em topologia e não trata deste tema. O *Introdução ao Cálculo* da pasta não pôde ser aberto nesta sessão.

---

## 0. Convenções, fatos preliminares e caixa de ferramentas

### 0.1 Convenções da nota

- $0\in\mathbb N$ e $\mathbb N^*=\mathbb N\setminus\{0\}$. (Mesma convenção de Tao, cap. 2. Maciel e Martha usam $\mathbb N=\{1,2,\dots\}$: cuidado ao copiar fórmulas.)
- $I_n=\{i\in\mathbb N : 1\le i\le n\}$. Assim $I_0=\emptyset$, $I_1=\{1\}$, $I_3=\{1,2,3\}$. (Tao escreve $\{i\in\mathbb N:1\le i\le n\}$, p. 69; Maciel e Martha escrevem $\{1,\dots,n\}$ ou $F_n$.)

### 0.2 Caixa de ferramentas (cada passo das demonstrações cita uma destas)

**Definições sobre funções.** Seja $f:A\to B$.

- **[D1] Função.** Cada $a\in A$ tem **exatamente um** $f(a)\in B$.
- **[D2] Injetora:** $f(x)=f(y)\Rightarrow x=y$. **Sobrejetora:** para todo $b\in B$ existe $a\in A$ com $f(a)=b$. **Bijetora:** injetora e sobrejetora.
- **[D3] Imagem e pré-imagem.** Para $S\subseteq A$, $f(S)=\{f(s): s\in S\}$. Para $Y\subseteq B$, $f^{-1}(Y)=\{a\in A: f(a)\in Y\}$. **A pré-imagem existe para qualquer função**, mesmo sem inversa.
- **[D4] Finito.** $X$ é finito se existem $n\in\mathbb N$ e uma bijeção $I_n\to X$. **Infinito** significa não finito.

**Fatos sobre funções** (com prova curta, porque serão usados o tempo todo).

- **[F1] Composição.** Se $f:A\to B$ e $g:B\to C$ são injetoras (respectivamente sobrejetoras, bijetoras), então $g\circ f$ também é.
  *Prova.* Injetora: $g(f(x))=g(f(y))\Rightarrow f(x)=f(y)\Rightarrow x=y$, usando [D2] duas vezes. Sobrejetora: dado $c$, existe $b$ com $g(b)=c$ e existe $a$ com $f(a)=b$, logo $(g\circ f)(a)=c$.
- **[F2] Inversa.** Se $f:A\to B$ é bijetora, a regra $f^{-1}(b)=$ "o único $a$ com $f(a)=b$" define uma função $f^{-1}:B\to A$. O $a$ existe pela sobrejetividade e é único pela injetividade. Ela é bijetora, e vale $f^{-1}(f(a))=a$ e $f(f^{-1}(b))=b$. Além disso, para $Y\subseteq B$, a pré-imagem $f^{-1}(Y)$ de [D3] coincide com a imagem de $Y$ pela função inversa. Por isso a notação não gera conflito.
- **[F3] Imagem da pré-imagem.** Sempre $f(f^{-1}(Y))\subseteq Y$. Se $f$ é sobrejetora, $f(f^{-1}(Y))=Y$.
  *Prova.* Se $b=f(a)$ com $a\in f^{-1}(Y)$, então $b\in Y$ por [D3]. Se $f$ é sobrejetora e $y\in Y$, existe $a$ com $f(a)=y$; então $a\in f^{-1}(Y)$ e $y=f(a)\in f(f^{-1}(Y))$.
- **[F4] Restrição.** Se $f:A\to B$ é injetora e $S\subseteq A$, então $f|_S:S\to f(S)$ é bijetora. É injetora porque herda a injetividade de $f$, e sobrejetora por definição de $f(S)$.

**Fatos sobre $\mathbb N$.**

- **[F5] Indução.** Se $P(0)$ vale e $P(n)\Rightarrow P(n+1)$ para todo $n$, então $P(n)$ vale para todo $n\in\mathbb N$.
- **[F6] Boa ordem.** Todo subconjunto **não vazio** de $\mathbb N$ tem **mínimo** (Tao, Prop. 8.1.4, p. 183; Maciel, nota 9, p. 31). Falha em $\mathbb Z$ e em $\mathbb Q_{>0}$ (Tao, Ex. 8.1.2, p. 187).
- **[F7] Ordem em $\mathbb N$.** Para $a,b\in\mathbb N$: $a<b\iff a+1\le b$, e, se $b\ge 1$, $a<b\iff a\le b-1$.
  *Fundamento:* Tao, Prop. 2.2.12(e),(f), p. 28: $a<b$ se e só se $b=a+d$ com $d$ positivo. Todo natural positivo é $\ge 1$, logo $b\ge a+1$. Em palavras: **não há natural estritamente entre $a$ e $a+1$**. Em $\mathbb R$ isso é falso: $0<\tfrac12$, mas $0+1\not\le\tfrac12$.
- **[F8] Os $I_n$.** (a) $I_{n+1}=I_n\cup\{n+1\}$, e $n+1\notin I_n$. (b) Se $m\le n$, então $I_m\subseteq I_n$. (c) $I_{n+1}\setminus I_n=\{n+1\}$.
  *Prova.* (a) $1\le i\le n+1\iff (1\le i\le n$ ou $i=n+1)$, por [F7], pois $i<n+1\iff i\le n$. (b) $1\le i\le m\le n$. (c) Segue de (a).
- **[F9] Soma de naturais.** Se $x_1,\dots,x_n\in\mathbb N$, então $x_j\le x_1+\dots+x_n$ para cada $j$. Isso vale porque a soma é $x_j$ mais uma soma de naturais $\ge 0$.

### 0.3 Exemplos básicos (faça-os antes de seguir)

1. $f:\mathbb N\to\mathbb N$, $f(n)=2n$: injetora ($2n=2m\Rightarrow n=m$), **não** sobrejetora (1 não é atingido).
2. $g:\mathbb N\to\mathbb N$, $g(n)=\lfloor n/2\rfloor$: sobrejetora ($g(2m)=m$), **não** injetora ($g(0)=g(1)=0$).
3. $s:\mathbb N\to\mathbb N^*$, $s(n)=n+1$: bijetora. Injetora: $n+1=m+1\Rightarrow n=m$. Sobrejetora: dado $m\ge1$, $s(m-1)=m$. **A mesma regra, com contradomínio $\mathbb N$, não é sobrejetora.** O contradomínio faz parte da função.
4. Pré-imagem sem inversa: $g:\{1,2,3,4\}\to\{p,q,r\}$ com $g(1)=p,\ g(2)=q,\ g(3)=p,\ g(4)=r$. Então $g^{-1}(\{p\})=\{1,3\}$ e $g^{-1}(\{q,r\})=\{2,4\}$.
5. [F3] sem sobrejetividade: $g:\{1\}\to\{p,q\}$, $g(1)=p$. Então $g(g^{-1}(\{p,q\}))=\{p\}\ne\{p,q\}$.

---

## 1. Definição de conjunto finito

**Def.** $X$ é finito se existem $n\in\mathbb N$ e $f:I_n\to X$ bijetora. **[D4]**

**Exemplos.**

- $\{a,b,c\}$ (elementos distintos): $1\mapsto a$, $2\mapsto b$, $3\mapsto c$ é uma bijeção $I_3\to X$.
- $\emptyset$: com $n=0$, a função vazia $I_0=\emptyset\to\emptyset$ é bijetora. Logo $\emptyset$ é finito.
- $\{2,4,6,8\}$: $i\mapsto 2i$, de $I_4$ nesse conjunto.
- $\{x\in\mathbb R: x^2=4\}=\{-2,2\}$: $1\mapsto-2$, $2\mapsto 2$.

**Cruzamento.** Tao, Def. 3.6.5 e 3.6.10, pp. 69–70 (o Exemplo 3.6.7 trata de $\{a,b,c,d\}$); Maciel, §1.6, p. 32; Martha, Def. 2.1.4, p. 3.

### Lema

> **Lema.** Se $A\subseteq I_n$ e existe bijeção $f:I_n\to A$, então $A=I_n$.

**Demonstração (por indução em $n$, [F5]).** Seja $P(n)$: "para **todo** $A\subseteq I_n$, se existe bijeção $I_n\to A$, então $A=I_n$". A hipótese de indução precisa valer para todo $A$, e não para um $A$ fixo, porque no passo ela será aplicada a outro conjunto.

- **Base, $n=0$.** $A\subseteq I_0=\emptyset$, logo $A=\emptyset=I_0$.
- **Passo.** Suponha $P(n)$. Sejam $A\subseteq I_{n+1}$ e $f:I_{n+1}\to A$ bijetora. Ponha $b=f(n+1)\in A$ e $A'=A\setminus\{b\}$.
  1. $f|_{I_n}:I_n\to A'$ é bijetora. Pela restrição [F4], $f|_{I_n}$ é bijeção sobre $f(I_n)$. Como $I_{n+1}=I_n\cup\{n+1\}$ [F8a] e $f$ é bijetora, $f(I_n)=f(I_{n+1})\setminus\{f(n+1)\}=A\setminus\{b\}=A'$. (Nenhum $i\le n$ tem $f(i)=b$, pela injetividade [D2].)
  2. **Caso 1: $n+1\notin A'$.** Então $A'\subseteq I_{n+1}\setminus\{n+1\}=I_n$ [F8c]. Por $P(n)$ aplicado a $A'$, $A'=I_n$. Como $b\notin A'=I_n$ e $b\in I_{n+1}$, temos $b=n+1$ [F8c]. Logo $A=A'\cup\{b\}=I_n\cup\{n+1\}=I_{n+1}$ [F8a].
  3. **Caso 2: $n+1\in A'$.** Então $b\ne n+1$ e, como $b\in I_{n+1}$, $b\in I_n$. Seja $\tau:I_{n+1}\to I_{n+1}$ a troca $\tau(b)=n+1$, $\tau(n+1)=b$, $\tau(i)=i$ nos demais. $\tau$ é bijetora (é sua própria inversa).
     - $\tau(A')\subseteq I_n$: um elemento $i\in A'$ é $n+1$ (e vai para $b\in I_n$) ou pertence a $I_n\setminus\{b\}$ (e fica fixo). Note que $b\notin A'$.
     - $\tau\circ f|_{I_n}:I_n\to\tau(A')$ é bijetora, por [F1] e [F4].
     - Por $P(n)$, $\tau(A')=I_n$. Então $\tau(A)=\tau(A')\cup\{\tau(b)\}=I_n\cup\{n+1\}=I_{n+1}$.
     - Como $\tau$ é bijetora de $I_{n+1}$ em si mesmo, $A=\tau^{-1}(\tau(A))=\tau^{-1}(I_{n+1})=I_{n+1}$.

  Em ambos os casos $A=I_{n+1}$, o que prova $P(n+1)$. Por [F5], o Lema vale para todo $n$. ∎

**Exemplo que o Lema proíbe.** Não existe bijeção $I_3\to\{1,2\}$: seria uma bijeção de $I_3$ sobre um subconjunto seu diferente de $I_3$.

### Teorema (unicidade da cardinalidade)

> **Teo.** Se $f:I_n\to X$ e $g:I_m\to X$ são bijeções, então $n=m$. Define-se $|X|=n$.

**Demonstração.**

1. Sem perda de generalidade, $m\le n$ (os papéis são simétricos). Então $I_m\subseteq I_n$ [F8b].
2. $g^{-1}:X\to I_m$ é bijetora [F2]. Portanto $h=g^{-1}\circ f:I_n\to I_m$ é bijetora [F1].
3. $h$ é uma bijeção de $I_n$ sobre o subconjunto $I_m\subseteq I_n$. Pelo **Lema**, $I_m=I_n$.
4. Se fosse $m<n$, teríamos $n\ge1$, $n\in I_n$ e $n\notin I_m$ (pois $n>m$). Isso contradiz $I_m=I_n$. Logo $m=n$. ∎

**Por que isso é necessário.** Sem este teorema, "$|X|$" poderia ter dois valores. Maciel (p. 32) diz "É claro que … $n=m$" sem provar. Tao prova com **outro método** (Lema 3.6.9 e Prop. 3.6.8, p. 70): retira um elemento de $X$ e usa indução, sem a troca $\tau$. Vale ler as duas provas.

**Consequência.** Se $X\sim Y$ (existe bijeção) e $X$ é finito, então $|X|=|Y|$. Isso é o Corolário (i), mais adiante.

📝 **Exercícios de aula 1 e 2** (Lema e unicidade): resolvidos acima.

---

## 2. Conjunto finito não é equivalente a subconjunto próprio

> **Teo.** Se $X$ é finito, $Y\subseteq X$ e $f:X\to Y$ é bijeção, então $X=Y$. Em outras palavras, se $X$ é finito, não existe bijeção de $X$ com um subconjunto próprio.

**Demonstração do quadro, fundamentada.**

1. $X$ é finito, então existem $n$ e $g:I_n\to X$ bijetora. **[D4]**
2. $A:=g^{-1}(Y)$ é um conjunto bem definido **[D3]** e $A\subseteq I_n$ (é formado por elementos do domínio de $g$).
3. $h:I_n\to A$, $h(i)=g^{-1}(f(g(i)))$. **É preciso checar que $h(i)\in A$:** $g(i)\in X$, então $f(g(i))\in Y$ (a imagem de $f$ está em $Y$). Logo o índice $j=g^{-1}(f(g(i)))$ satisfaz $g(j)=f(g(i))\in Y$ [F2], isto é, $j\in g^{-1}(Y)=A$ **[D3]**. Assim $h$ é uma função de $I_n$ em $A$ **[D1]**.
4. 📝 **Exercício de aula 3: $h$ é injetora.** Como função de $I_n$ em $I_n$, $h=g^{-1}\circ f\circ g$ é composição de três injetoras: $g$ e $f$ são bijetoras por hipótese e $g^{-1}$ é bijetora por [F2]. Pelo fato [F1], $h$ é injetora. Diretamente: se $h(i)=h(i')$, aplique $g$ e use $g(g^{-1}(z))=z$ [F2] para obter $f(g(i))=f(g(i'))$. Pela injetividade de $f$, $g(i)=g(i')$. Pela injetividade de $g$, $i=i'$. A injetividade não depende do contradomínio escolhido, então vale também para $h:I_n\to A$.
5. **$h$ é sobrejetora.** Seja $a\in A$. Por **[D3]**, $y:=g(a)\in Y$, e por [F2], $g^{-1}(y)=a$. Como $f$ é sobrejetora **[D2]**, existe $x\in X$ com $f(x)=y$. Como $g$ é sobrejetora, existe $i\in I_n$ com $g(i)=x$. Então $h(i)=g^{-1}(f(g(i)))=g^{-1}(f(x))=g^{-1}(y)=a$.
6. $h:I_n\to A$ é bijeção com $A\subseteq I_n$. Pelo **Lema**, $A=I_n$, isto é, $I_n=g^{-1}(Y)$.
7. $X=g(I_n)$, porque $g$ é sobrejetora, $=g(g^{-1}(Y))=Y$ por [F3], porque $g$ é sobrejetora. ∎

**Leitura de $h$.** $h$ faz o caminho "índice → elemento de $X$ → elemento de $Y$ → índice". A prova **transporta o problema para $I_n$**, onde o Lema resolve. Guarde essa técnica: ela reaparece na Seção 3.

**Exemplo.** $X=\{p,q,r\}$, $Y=\{p,q\}$, com $g(1)=p,\ g(2)=q,\ g(3)=r$. Se existisse uma bijeção $f:X\to Y$, teríamos $A=g^{-1}(Y)=\{1,2\}$ e $h$ seria uma bijeção de $I_3$ em $\{1,2\}\subsetneq I_3$, o que é impossível pelo Lema.

**Cruzamento.** Tao, Prop. 3.6.14(c), p. 71 ($Y\subsetneq X\Rightarrow\#Y<\#X$, equivalente a este teorema); prova no Ex. 3.6.4, p. 72. Tao, §8.1, p. 181, comenta que isso **falha** para infinitos. Martha, p. 5.

---

## 3. Subconjunto de conjunto finito é finito

> **Teo.** Se $X$ é finito e $Y\subseteq X$, então $Y$ é finito e $|Y|\le|X|$.

### 📝 Exercício de aula 4: por que basta provar para $X=I_n$?

Suponha provado: "todo $B\subseteq I_n$ é finito e $|B|\le n$". Seja $X$ finito com bijeção $\varphi:I_n\to X$ **[D4]**, e seja $Y\subseteq X$.

1. $B:=\varphi^{-1}(Y)\subseteq I_n$ **[D3]**. Pelo caso provado, existem $k\le n$ e uma bijeção $\psi:I_k\to B$.
2. $\varphi|_B:B\to\varphi(B)$ é bijeção [F4], e $\varphi(B)=\varphi(\varphi^{-1}(Y))=Y$ [F3] porque $\varphi$ é sobrejetora.
3. $\varphi|_B\circ\psi:I_k\to Y$ é bijeção [F1]. Logo $Y$ é finito e $|Y|=k\le n=|X|$ (unicidade, Seção 1). ∎

### Demonstração principal (indução em $n$)

$P(n)$: "**todo** $Y\subseteq I_n$ é finito e $|Y|\le n$".

- **Base, $n=0$.** $Y\subseteq\emptyset$, então $Y=\emptyset$, que é finito com $|Y|=0\le 0$.
- **Passo.** Suponha $P(n)$ e seja $Y\subseteq I_{n+1}$. **Os três casos cobrem tudo**: ou $Y\subseteq I_n$, ou $Y=I_{n+1}$, ou nenhum dos dois.
  - **Caso $Y\subseteq I_n$.** Por $P(n)$, $Y$ é finito e $|Y|\le n\le n+1=|I_{n+1}|$.
  - **Caso $Y=I_{n+1}$.** A identidade $I_{n+1}\to Y$ é bijeção, então $|Y|=n+1$.
  - **Caso restante.**
    - *Por que $n+1\in Y$:* como $Y\not\subseteq I_n$, existe $y\in Y\setminus I_n\subseteq I_{n+1}\setminus I_n=\{n+1\}$ [F8c]. Logo $y=n+1$.
    - *Por que existe $a\in I_n\setminus Y$:* como $Y\ne I_{n+1}$ e $Y\subseteq I_{n+1}$, existe $a\in I_{n+1}\setminus Y$. Como $n+1\in Y$, $a\ne n+1$, logo $a\in I_n$ [F8a].
    - $Z:=(Y\setminus\{n+1\})\cup\{a\}$ satisfaz $Z\subseteq I_n$, pois $Y\setminus\{n+1\}\subseteq I_{n+1}\setminus\{n+1\}=I_n$ e $a\in I_n$.
    - $g:Y\to Z$, $g(m)=m$ se $m\ne n+1$, e $g(n+1)=a$. Os valores caem em $Z$ por construção.
    - 📝 **Exercício de aula 5: $g$ é bijetora.**
      - *Injetora:* sejam $m\ne m'$ em $Y$. Se nenhum é $n+1$, $g(m)=m\ne m'=g(m')$. Se $m=n+1$, então $m'\ne n+1$, e $g(m)=a$, $g(m')=m'\in Y$. **Como $a\notin Y$**, $a\ne m'$.
      - *Sobrejetora:* $a=g(n+1)$, e cada $z\in Y\setminus\{n+1\}$ é $g(z)$.

      O papel da hipótese $a\notin Y$ é justamente evitar que dois elementos caiam em $a$.
    - Por $P(n)$, $Z$ é finito: existem $k$ e $h:I_k\to Z$ bijeção, com $k=|Z|\le n$.
    - $g^{-1}\circ h:I_k\to Y$ é bijeção [F2], [F1]. Então $Y$ é finito e, pela unicidade, $|Y|=k=|Z|\le |I_n|=n\le n+1=|I_{n+1}|$. ∎

**Exemplo do caso restante.** $n=3$ e $Y=\{1,4\}\subseteq I_4$. Temos $4\in Y$ e $I_3\setminus Y=\{2,3\}$; escolha $a=2$. Então $Z=\{1,2\}=I_2$ e $g(1)=1$, $g(4)=2$. Com $h$ = identidade de $I_2$, $g^{-1}\circ h$ é $1\mapsto1,\ 2\mapsto4$, e $|Y|=2\le 4$.

**Cruzamento.** Tao, Prop. 3.6.14(c), p. 71, e Ex. 3.6.4, p. 72; Maciel, Cor. 1.2, p. 33 (versão para contáveis); Tao, Cor. 8.1.7, p. 184.

---

## 4. Corolário: funções e finitude

> **Cor.** Seja $f:X\to Y$.
> (i) Se $f$ é bijetora, $X$ é finito $\iff$ $Y$ é finito, e então $|X|=|Y|$.
> (ii) Se $f$ é injetora e $Y$ é finito, então $X$ é finito e $|X|\le|Y|$.
> (iii) Se $f$ é sobrejetora e $X$ é finito, então $Y$ é finito e $|Y|\le|X|$.

### 📝 Exercício de aula 6: demonstração dos três itens

**(i)** ($\Rightarrow$) Seja $g:I_n\to X$ bijeção **[D4]**. Então $f\circ g:I_n\to Y$ é bijeção [F1], e $Y$ é finito com $|Y|=n=|X|$ (unicidade). ($\Leftarrow$) Igual, usando $f^{-1}$, que é bijetora [F2].

**(ii)** Pela restrição [F4], $f:X\to f(X)$ é bijeção. Como $f(X)\subseteq Y$ e $Y$ é finito, a **Seção 3** dá que $f(X)$ é finito com $|f(X)|\le|Y|$. Por (i), aplicado à bijeção $X\to f(X)$, $X$ é finito e $|X|=|f(X)|\le|Y|$.

**(iii)** Seja $\varphi:I_n\to X$ bijeção. Para cada $y\in Y$, o conjunto $S_y=\{i\in I_n: f(\varphi(i))=y\}$ é **não vazio**: $f$ é sobrejetora, então $y=f(x)$ para algum $x$, e $x=\varphi(i)$ para algum $i$. Além disso $S_y\subseteq\mathbb N$. Pela boa ordem [F6], $S_y$ tem mínimo $i_y$. Defina $s:Y\to X$, $s(y)=\varphi(i_y)$.

- $f(s(y))=y$, por definição de $S_y$.
- $s$ é injetora: $s(y)=s(y')\Rightarrow y=f(s(y))=f(s(y'))=y'$.

Por (ii) aplicado a $s:Y\to X$, $Y$ é finito e $|Y|\le|X|$. ∎

*Por que usar "o menor índice":* assim não é preciso escolher arbitrariamente uma pré-imagem para cada $y$. A escolha fica determinada pela boa ordem. Para conjuntos quaisquer, isso exigiria o Axioma da Escolha (Tao, Ex. 8.4.3, p. 202).

**Exemplos de uso.**

- Não existe $f:I_5\to\{a,b,c\}$ injetora: por (ii), teríamos $5\le 3$.
- Não existe $f:\{a,b\}\to I_3$ sobrejetora: por (iii), teríamos $3\le 2$.
- **Casa dos pombos:** entre 13 pessoas, duas fazem aniversário no mesmo mês. A função "pessoa $\mapsto$ mês" vai de 13 elementos em 12 e não pode ser injetora, por (ii).

**Cruzamento.** (ii): Tao, Ex. 3.6.7, p. 72 (injeção $A\to B$ $\iff\#A\le\#B$). (iii): Tao, Prop. 3.6.14(d), p. 71 ($\#f(X)\le\#X$). Seções e retrações: Maciel, Ex. 1.24 e 1.25, p. 40. Composição de bijeções: Maciel, Ex. 1.26, p. 40. Casa dos pombos: Tao, Ex. 3.6.10, p. 73.

---

## 5. Conjuntos infinitos

> **Def.** $X$ é infinito se não é finito. Em outras palavras, para todo $n\in\mathbb N$ e toda $f:I_n\to X$, $f$ não é bijetora.

A segunda frase é apenas a **negação lógica** de [D4]: "não existem $n$ e $f$ bijetora" equivale a "para todos $n$ e $f$, $f$ não é bijetora".

**Exemplo 1: $\mathbb N$ é infinito.**

1. $s:\mathbb N\to\mathbb N\setminus\{0\}$, $s(n)=n+1$, é bijeção (Seção 0.3, ex. 3).
2. $\mathbb N\setminus\{0\}\subsetneq\mathbb N$, pois $0\notin\mathbb N\setminus\{0\}$.
3. Se $\mathbb N$ fosse finito, o **Teorema da Seção 2** daria $\mathbb N=\mathbb N\setminus\{0\}$, o que é falso. Logo $\mathbb N$ é infinito.

*Outra prova (Tao, Thm. 3.6.12, p. 71):* se $f:I_n\to\mathbb N$ fosse bijeção, os valores $f(1),\dots,f(n)$ seriam limitados por $M$ (aqui [F9] basta, com $M=\sum f(i)$), e $M+1$ não seria atingido. Compare com a Seção 6.

**Exemplo 2 e 📝 Exercício de aula 7: $\mathbb Z,\mathbb Q,\mathbb R,\mathbb C$ e todo corpo ordenado $\mathbb K$ são infinitos.**

*Princípio:* se existe $j:\mathbb N\to Y$ injetora, então $Y$ é infinito. **Prova:** se $Y$ fosse finito, o **Corolário (ii)** daria $\mathbb N$ finito, contradizendo o Exemplo 1. (É a contrapositiva de (ii).)

*As injeções:*

- $\mathbb Z,\mathbb Q,\mathbb R,\mathbb C$: a inclusão $j(n)=n$. É injetora porque $j(n)=j(m)$ significa literalmente $n=m$.
- $\mathbb K$ corpo ordenado: $j(n)=n\cdot 1_{\mathbb K}$, onde $0\cdot1_{\mathbb K}=0_{\mathbb K}$ e $(n+1)\cdot 1_{\mathbb K}=n\cdot1_{\mathbb K}+1_{\mathbb K}$.
  - *Injetora:* se $m<n$, então $n\cdot1_{\mathbb K}-m\cdot1_{\mathbb K}=(n-m)\cdot1_{\mathbb K}>0$, pois $n-m\ge1$.
  - O fato "$k\cdot1_{\mathbb K}>0$ para $k\ge1$" foi provado por indução no Caderno 01, §2.4 e Ex. 5: $1_{\mathbb K}>0$ e soma de positivos é positiva.
  - Logo $j(m)\ne j(n)$.

(Observação: $\mathbb C$ **não** é corpo ordenado, mas a inclusão já basta.)

**Cruzamento.** Tao, §8.1, p. 181 (a bijeção $n\mapsto n+1$ e o comentário); Tao, Remark 3.6.13, p. 71 (conjuntos ilimitados são infinitos); Martha, p. 5 (caracterização de Dedekind).

---

## 6. Subconjuntos de $\mathbb N$: finito ⇔ limitado ⇔ tem máximo

> **Teo.** Seja $X\subseteq\mathbb N$ não vazio. São equivalentes: (i) $X$ é finito; (ii) $X$ é limitado; (iii) $X$ possui máximo.

O ciclo (i)⇒(ii)⇒(iii)⇒(i) prova as seis implicações.

**(i)⇒(ii).**

1. $0$ é cota inferior, pois todo natural é $\ge0$. Resta achar uma cota superior.
2. Existe bijeção $f:I_n\to X$ **[D4]**, e **$n\ge1$**: se $n=0$, $f$ seria sobrejetora do vazio, forçando $X=\emptyset$, o que contraria a hipótese.
3. Seja $a=\sum_{i=1}^n f(i)\in\mathbb N$. Dado $x\in X$, existe $i_0\in I_n$ com $x=f(i_0)$ (sobrejetividade), e $f(i_0)\le a$ por [F9], porque os $f(i)$ são naturais, portanto $\ge0$.
4. Logo $a$ é cota superior e $X$ é limitado.

*O truque depende de os termos serem $\ge 0$.* Em $\mathbb Z$, $\{-5,2\}$ tem soma $-3$, que não é cota superior.

**(ii)⇒(iii).**

1. $A=\{n\in\mathbb N: n\ge x\ \forall x\in X\}$ é o conjunto das cotas superiores naturais. É não vazio por (ii).
2. Pela boa ordem [F6], $A$ tem mínimo $a$.
3. $a\ge x$ para todo $x\in X$, pois $a\in A$.
4. **$a\in X$.** Suponha que não.
   - Então, para todo $x\in X$, $a\ge x$ e $a\ne x$, isto é, $a>x$.
   - Tomando algum $x_0\in X$ (existe, pois $X\ne\emptyset$), $a>x_0\ge0$. Logo $a\ge1$ [F7] e $a-1\in\mathbb N$.
   - Por [F7], $x<a\Rightarrow x\le a-1$, para todo $x\in X$. Então $a-1\in A$.
   - Mas $a-1<a$, o que contradiz a minimalidade de $a$.
5. Logo $a\in X$ e $a\ge x$ para todo $x\in X$, ou seja, $a=\max X$.

*Dois cuidados:* verificar $a\ge1$ antes de escrever $a-1$; e o passo "$x<a\Rightarrow x\le a-1$" só vale em $\mathbb N$ ou $\mathbb Z$. Em $\mathbb R$, $(0,1)$ é limitado e não tem máximo.

**(iii)⇒(i).**

1. Seja $n=\max X$. Se $x\in X$, então $0\le x\le n$: ou $x=0$, ou $1\le x\le n$. Logo $X\subseteq I_n\cup\{0\}$.
2. $I_n\cup\{0\}$ é finito: $j:I_{n+1}\to I_n\cup\{0\}$, $j(i)=i-1$, é bijeção. É injetora porque $i-1=i'-1\Rightarrow i=i'$. É sobrejetora porque $k\in\{0,\dots,n\}$ é $j(k+1)$.
3. Pela **Seção 3**, $X$ é finito. ∎

**Exemplos.**

- Os pares são infinitos: não há máximo, pois $2n<2n+2$. Pelo teorema, (iii) falha, então (i) falha.
- $\{n\in\mathbb N: n^2<50\}=\{0,\dots,7\}$: limitado por 7 (se $n\ge8$, $n^2\ge64$), com máximo 7, portanto finito.
- **O teorema exige $X\subseteq\mathbb N$.** $\{-1,-2,-3,\dots\}\subseteq\mathbb Z$ tem máximo $-1$ e é infinito. $[0,1]\subseteq\mathbb R$ tem máximo e é infinito.

**Cruzamento.** Tao, Ex. 3.6.3, p. 72 (finito ⇒ limitado, por indução, outro caminho); boa ordem: Tao, Prop. 8.1.4, p. 183, e Ex. 8.1.2, p. 187; Maciel, nota 9, p. 31, e Ex. 1.29, p. 40 (indução ⇔ boa ordem).

---

## 7. Todo conjunto infinito contém uma "cópia" de $\mathbb N$

> **Teo.** Se $X$ é infinito, existe $f:\mathbb N\to X$ injetora.

**Demonstração do quadro, fundamentada.**

1. **Escolha.** Para cada $A\subseteq X$ não vazio, escolha $y_A\in A$.
   - Isto é o **Axioma da Escolha**: uma função $A\mapsto y_A\in A$ definida em todos os subconjuntos não vazios de $X$ (Tao, Axiom 8.1, p. 200; §8.4 a partir da p. 198).
   - Para $X\subseteq\mathbb N$ ela não é necessária: basta tomar $y_A=\min A$ [F6].
   - Para $X$ arbitrário não há regra natural, e o axioma é usado. Tao observa (Ex. 8.1.1, p. 187) que o resultado equivalente "infinito ⇔ equipotente a um subconjunto próprio" requer a escolha.
2. **Definição recursiva.**
   - $f(0)=y_X$. Note que $X\ne\emptyset$, pois $\emptyset$ é finito.
   - Dados $f(0),\dots,f(n)$, seja $A_{n+1}=X\setminus\{f(0),\dots,f(n)\}$ e ponha $f(n+1)=y_{A_{n+1}}$.
   - Cada valor depende de todos os anteriores. É uma recursão "de curso completo", garantida pelo princípio de definição recursiva (Tao, Ex. 3.5.12, p. 67).
3. 📝 **Exercício de aula 8: $A_{n+1}\ne\emptyset$.**
   - Suponha $A_{n+1}=\emptyset$. Então $X=\{f(0),\dots,f(n)\}$.
   - A função $F:\{0\}\cup I_n\to X$, $F(k)=f(k)$, é sobrejetora.
   - $\{0\}\cup I_n$ é finito, pois está em bijeção com $I_{n+1}$ via $i\mapsto i-1$ (Seção 6).
   - Pelo **Corolário (iii)**, $X$ seria finito, o que contradiz a hipótese. Logo $A_{n+1}\ne\emptyset$, e $y_{A_{n+1}}$ existe.
4. **Injetividade.**
   - Sejam $m\ne n$; sem perda de generalidade, $m<n$. Então $n\ge1$ e $f(n)=y_{A_n}\in A_n=X\setminus\{f(0),\dots,f(n-1)\}$.
   - Como $m\le n-1$ [F7], $f(m)\in\{f(0),\dots,f(n-1)\}$.
   - Um elemento de $A_n$ não está nesse conjunto, logo $f(m)\ne f(n)$ **[D2]**. ∎

**Exemplo.** $X=\mathbb Z$, escolhendo "o elemento de menor valor absoluto e, havendo empate, o positivo". Obtemos $f(0)=0,\ f(1)=1,\ f(2)=-1,\ f(3)=2,\ f(4)=-2,\dots$ Aqui $f$ é até bijetora, mas o teorema só garante injetora.

**Consequências.**

- (Seções 5 e 7) **$X$ é infinito $\iff$ existe uma injeção $\mathbb N\to X$.**
- **Caracterização de Dedekind:** $X$ é infinito $\iff$ $X$ é equipotente a um subconjunto próprio. Veja o Extra 6.

**Cruzamento.** Maciel, Ex. 1.38, p. 41 ("todo conjunto infinito contém um subconjunto enumerável": é este teorema, pois $f(\mathbb N)\sim\mathbb N$ por [F4]) e Ex. 1.39, p. 41 (Dedekind); Tao, Ex. 8.1.1, p. 187.

---

## Índice dos exercícios deixados em aula

| # | Exercício | Onde está resolvido |
|---|---|---|
| 1 | Lema $A\subseteq I_n$, bijeção $\Rightarrow A=I_n$ | Seção 1 |
| 2 | Unicidade da cardinalidade | Seção 1 |
| 3 | $h=g^{-1}\circ f\circ g$ injetora | Seção 2, passo 4 |
| 4 | Por que basta $X=I_n$ | Seção 3 |
| 5 | $g:Y\to Z$ bijetora | Seção 3, caso restante |
| 6 | Corolário (i), (ii), (iii) | Seção 4 |
| 7 | Injeções $\mathbb N\to\mathbb Z,\mathbb Q,\mathbb R,\mathbb C,\mathbb K$ | Seção 5 |
| 8 | $\{0\}\cup I_n\to X$ não é sobrejetora | Seção 7, passo 3 |

---

## Exercícios extras (com solução)

### Nível básico

**B1.** Quantas bijeções existem de $I_3$ em $\{a,b,c\}$?
*Sol.:* $3\cdot2\cdot1=6$. Há 3 escolhas para $f(1)$, 2 para $f(2)$ (não repete) e 1 para $f(3)$.

**B2.** Mostre que $f:I_3\to\{a,b\}$ nunca é injetora e que $g:\{a,b\}\to I_3$ nunca é sobrejetora.
*Sol.:* Corolário (ii) e (iii): seriam necessários $3\le2$ e $3\le 2$, respectivamente.

**B3.** Calcule $I_0$, $I_1\cap I_4$, $I_5\setminus I_3$ e decida se $\{0\}\subseteq I_2$.
*Sol.:* $\emptyset$; $\{1\}$; $\{4,5\}$; não, pois $0\notin I_2$ ($I_n$ começa em 1).

**B4.** $f:\mathbb N\to\mathbb N$, $f(n)=n+3$. Calcule $f^{-1}(\{0,1,2\})$ e $f^{-1}(\{5,6\})$.
*Sol.:* $\emptyset$ (nenhum $n$ tem $n+3\le2$); $\{2,3\}$.

**B5.** Decida se é finito e dê o máximo quando existir: (a) $\{n\in\mathbb N: 3n+1<40\}$; (b) os ímpares.
*Sol.:* (a) $3n+1<40\iff 3n\le 38\iff n\le12$ [F7], logo é $\{0,\dots,12\}$, com máximo 12, finito. (b) Não tem máximo ($n$ ímpar $\Rightarrow n+2$ ímpar e maior), logo é infinito pela Seção 6.

### Nível intermediário

**E1 (Tao, Ex. 3.6.2, p. 72).** $|X|=0\iff X=\emptyset$.
*Sol.:* $|X|=0$ significa que existe bijeção $\emptyset=I_0\to X$. Ela é sobrejetora, e todo $x\in X$ teria pré-imagem em $\emptyset$, o que é impossível; logo $X=\emptyset$. A volta: a função vazia $\emptyset\to\emptyset$ é bijetora.

**E2 (Tao, Prop. 3.6.14(a), p. 71).** Se $X$ é finito e $x\notin X$, então $|X\cup\{x\}|=|X|+1$.
*Sol.:* Seja $g:I_n\to X$ bijeção. Defina $G:I_{n+1}\to X\cup\{x\}$ por $G=g$ em $I_n$ e $G(n+1)=x$ [F8a]. $G$ é injetora: em $I_n$ é $g$, e $x\notin X$ separa $G(n+1)$ dos demais. $G$ é sobrejetora: atinge $X$ via $g$ e atinge $x$.

**E3 (Tao, Prop. 3.6.14(b), p. 71).** Se $C,D$ são finitos e disjuntos, $|C\cup D|=|C|+|D|$. Sem a hipótese de disjuntos, vale $\le$.
*Sol.:* Sejam $f:I_c\to C$ e $g:I_d\to D$ bijeções. Defina $H:I_{c+d}\to C\cup D$ por $H(i)=f(i)$ se $i\le c$ e $H(i)=g(i-c)$ se $i>c$. $H$ é sobrejetora. Se $C\cap D=\emptyset$, também é injetora: índices da mesma "metade" usam a injetividade de $f$ ou de $g$, e índices de metades diferentes caem em conjuntos disjuntos. Sem disjunção, $H$ é apenas sobrejetora, e o Corolário (iii) dá $\le$.

**E4 (Maciel, Ex. 1.35, p. 41 = Tao, Ex. 3.6.9, p. 72).** $|A|+|B|=|A\cup B|+|A\cap B|$ para $A,B$ finitos.
*Sol.:* $A\cup B=A\sqcup(B\setminus A)$ e $B=(B\setminus A)\sqcup(A\cap B)$ são uniões disjuntas. Todos os conjuntos envolvidos são finitos (Seção 3 e E3). Por E3, $|A\cup B|=|A|+|B\setminus A|$ e $|B|=|B\setminus A|+|A\cap B|$. Subtraindo, $|A\cup B|-|B|=|A|-|A\cap B|$.

**E5 (Tao, Ex. 3.6.10, p. 73, casa dos pombos).** Se $A_1,\dots,A_n$ são finitos e $|A_1\cup\dots\cup A_n|>n$, algum $|A_i|\ge2$.
*Sol.:* Se todos tivessem $|A_i|\le1$, então por E3 (na forma $\le$, por indução em $n$) $|\bigcup A_i|\le\sum|A_i|\le n$. Contradição.

### Nível desafio

**E6 (Maciel, Ex. 1.39, p. 41; Tao, Ex. 8.1.1, p. 187, Dedekind).** $X$ é infinito $\iff$ existe $Y\subsetneq X$ com $Y\sim X$.
*Sol.:*
- ($\Leftarrow$) É a contrapositiva da Seção 2.
- ($\Rightarrow$) Pela Seção 7, existe $f:\mathbb N\to X$ injetora. Defina $F:X\to X\setminus\{f(0)\}$ por $F(f(n))=f(n+1)$ e $F(x)=x$ se $x\notin f(\mathbb N)$.
- $F$ é injetora: nos pontos de $f(\mathbb N)$ usa-se a injetividade de $f$; pontos fora de $f(\mathbb N)$ ficam fixos e não se confundem com os de dentro.
- $F$ é sobrejetora sobre $X\setminus\{f(0)\}$: $f(m)$ com $m\ge1$ é $F(f(m-1))$, e o resto é fixo.
- É o "Hotel de Hilbert" dentro de $X$.

**E7.** Mostre que, entre 5 pontos de coordenadas inteiras no plano, há dois cujo ponto médio tem coordenadas inteiras.
*Sol.:* Classifique pela paridade de $(x,y)$: há 4 classes. Com 5 pontos e 4 classes, o Corolário (ii) impede a injetividade, então dois pontos estão na mesma classe. Nesse caso $x_1+x_2$ e $y_1+y_2$ são pares.

**E8 (Maciel, Ex. 1.43(a), p. 42).** Se $|A|=n$, o conjunto das partes $\mathcal P(A)$ tem $2^n$ elementos.
*Esboço:* indução em $n$ usando E2. Os subconjuntos de $A\cup\{x\}$ são os de $A$ mais os de $A$ acrescidos de $x$, duas famílias disjuntas de mesmo tamanho. Por E3, o total dobra.

---

## Apêndice — ponte para conjuntos enumeráveis (Martha; Maciel §1.6; Tao §8.1)

*(Não está no quadro da Aula 6. Serve de preparação para o que vem a seguir.)*

- **Enumerável:** $X\sim\mathbb N$ (Tao, Def. 8.1.1, p. 181; Maciel, p. 33, com $\mathbb N$ a partir de 1). Pela Seção 5, enumerável implica infinito.
- **Exemplos:**
  - $\mathbb N^*$ e os pares (Tao, Ex. 8.1.3, pp. 181–182).
  - $\mathbb Z$ (Tao, Cor. 8.1.11, p. 185). Na convenção do professor: $f(n)=\frac{n+1}{2}$ se $n$ é ímpar e $f(n)=-\frac n2$ se $n$ é par, que dá $0,1,-1,2,-2,\dots$
- **Todo subconjunto infinito de $\mathbb N$ é enumerável** (Tao, Prop. 8.1.5, pp. 183–184). É a versão sem escolha da Seção 7: tome sempre o **mínimo** do que sobra.
- **União enumerável de enumeráveis é enumerável** (Maciel, Prop. 1.7, p. 34), percorrendo a tabela pelas diagonais. Daí **$\mathbb Q$ é enumerável** (Maciel, Thm. 1.3, p. 35; Tao, Cor. 8.1.15, p. 187).
- **$\mathbb R$ não é enumerável** (Maciel, Thm. 1.4, p. 35; Martha, Teo. 2.1.17, p. 9), pela diagonal de Cantor. O número construído existe **por causa do supremo** (Aula 4).

---

## O que você precisa fortalecer

1. **Provas de injetividade, sobrejetividade e pré-imagem** [D2], [D3], [F3]. Sem isso, as Seções 2 e 3 não fecham.
2. **Verificar o contradomínio** ao definir uma função, como $h(i)\in A$ e $g(m)\in Z$. É o passo que mais se esquece.
3. **Indução com hipótese "para todo subconjunto"** (Lema e Seção 3).
4. **Boa ordem e [F7]**: o cuidado $a\ge1$ antes de usar $a-1$.
5. **Contrapositiva do Corolário (ii)**: "se $\mathbb N$ injeta em $Y$, então $Y$ é infinito".
6. **Convenção $0\in\mathbb N$**: não misture com as fórmulas de Maciel e Martha.

**Revisão espaçada.**
- Hoje: enuncie as definições D4 e o Corolário sem olhar.
- Amanhã: refaça o Lema e a Seção 2.
- Em 3 dias: refaça a Seção 3 com $Y=\{2,5\}\subseteq I_5$.
- Em uma semana: refaça a Seção 6 inteira e o E6.
