# Caderno de Análise Real — Aula 6: conjuntos finitos, infinitos e ponte para enumeráveis

## Como ler este caderno

Este é o segundo bloco da sequência, depois de *01 - Aula 2, ponte e Aula 4*. Transcrevi e conferi, em ordem numérica, as 18 fotografias da **Aula 6** (IMG_7922 a IMG_7942; os números 7925, 7934 e 7941 não estão na pasta). O que está no quadro vem marcado com **[quadro, IMG_xxxx]**. O que eu acrescentei para completar o raciocínio (demonstrações deixadas como exercício, passos pulados, exemplos) vem marcado com **[complemento]**. A seção 8 vem das notas da Martha, não do quadro, e está marcada como **[Martha]**.

**Pergunta condutora:** o que quer dizer *contar* os elementos de um conjunto, e como sabemos que um conjunto é infinito sem "contar até o fim"?

**Roteiro do bloco**

0. Fundamentos que a aula usa sem repetir: funções, imagem, pré-imagem, injetora, sobrejetora, bijetora, composição, indução e boa ordem.
1. O que é contar: `Iₙ`, conjunto finito, e por que `|X|` está bem definido.
2. Um conjunto finito não pode ser posto em bijeção com um subconjunto próprio.
3. Subconjunto de conjunto finito é finito.
4. Corolário: bijeções, injeções e sobrejeções entre conjuntos finitos (e a casa dos pombos).
5. Conjuntos infinitos: definição e primeiros exemplos.
6. Subconjuntos de ℕ: finito ⇔ limitado ⇔ tem máximo.
7. Todo conjunto infinito contém uma "cópia" de ℕ.
8. Ponte (Martha): conjuntos enumeráveis, ℚ enumerável, ℝ não enumerável.
9. Exercícios resolvidos.
10. O que você precisa fortalecer.
11. Ponte para a Aula 8.

### Fontes

| Fonte | Trecho usado | Para quê |
|---|---|---|
| [Fotografias da Aula 6](https://drive.google.com/drive/folders/1aXxoo93MSb10_QmzeI0ckJoBWJcTJlDh) | IMG_7922–7942 | Todo o conteúdo das seções 1 a 7. |
| [Martha Salerno Monteiro, *Conjuntos Infinitos* (2018)](https://drive.google.com/file/d/18jTPPU_qtuqDMDurVDS-vVGZbAtghbv7/view) | pp. 1–12 | Motivação (contar = bijeção), cardinalidade, enumeráveis, diagonal de Cantor, exercícios. |
| [Fotografias da Aula 8](https://drive.google.com/drive/folders/1bVCzGnl8CjifGY6AtWxDnlVL1vl_cyXt) | IMG_8017–8019 | Apenas a ponte final: sequência como função. |
| Caderno 01 (Aulas 2 e 4) | seções 2.4 e 3.3 | `n·1_K ≠ 0` e a ligação entre sup e expansão decimal. |

### ⚠️ Aviso de convenção (fonte de erro em prova)

- **No quadro do professor, `0 ∈ ℕ`.** Veja: a indução começa em `n = 0` com `I₀ = ∅` (IMG_7928), aparece `ℕ∖{0}` (IMG_7933) e `f(0)` (IMG_7940). Ainda assim, `Iₙ = {1, 2, …, n}` começa em 1.
- **Nas notas da Martha, `ℕ = {1, 2, 3, …}`**, e ela usa `Fₙ = {1, …, n}` no lugar de `Iₙ`.

Nada de importante muda, mas fórmulas explícitas (como a bijeção `ℕ → ℤ`) mudam. Na prova, siga a convenção do professor e, na dúvida, escreva qual está usando.

---

## 0. Fundamentos que a aula usa o tempo todo

A Aula 6 é quase toda feita de **funções**. Se algum item abaixo não estiver automático para você, as demonstrações vão parecer mágica. Vale a pena gastar tempo aqui.

### 0.1 Função, domínio, contradomínio, imagem

Uma **função** `f : A → B` associa **cada** elemento `a ∈ A` a **exatamente um** elemento `f(a) ∈ B`.

- `A` é o **domínio**, `B` é o **contradomínio**.
- A **imagem** é `f(A) = Im f = {f(a) : a ∈ A}`. Ela é um subconjunto de `B`, mas pode não ser `B` inteiro.

**Exemplo 0.1.** `A = {1, 2, 3}`, `B = {a, b, c, d}`, `f(1) = a`, `f(2) = c`, `f(3) = a`.
Então `Im f = {a, c}`. Os elementos `b` e `d` não são atingidos.

**O que não é função:** "associar 1 a `a` **e** a `b`" (dois valores para o mesmo elemento), ou "não associar nada a 2" (elemento do domínio sem imagem). A Martha dá a imagem das cadeiras: se sobram pessoas em pé, a regra "cada pessoa → sua cadeira" **nem é uma função**, porque há pessoas sem cadeira.

### 0.2 Injetora, sobrejetora, bijetora

| Nome | Significado em palavras | Como se **prova** |
|---|---|---|
| **Injetora** | elementos diferentes vão para lugares diferentes | suponha `f(x) = f(y)` e conclua `x = y` |
| **Sobrejetora** | todo elemento de `B` é atingido: `Im f = B` | tome `b ∈ B` qualquer e **encontre** `a ∈ A` com `f(a) = b` |
| **Bijetora** | injetora **e** sobrejetora | faça as duas provas acima |

Exemplos básicos com `ℕ = {0, 1, 2, …}` (a convenção do professor):

1. `f(n) = 2n` de `ℕ` em `ℕ`: **injetora** (`2n = 2m ⇒ n = m`), **não sobrejetora** (1 não é `2n` para nenhum `n`).
2. `g(n) = ⌊n/2⌋` (parte inteira de `n/2`) de `ℕ` em `ℕ`: `g(0)=0, g(1)=0, g(2)=1, g(3)=1, …`. **Sobrejetora** (dado `m`, `g(2m) = m`), **não injetora** (`g(0) = g(1)`).
3. `s(n) = n + 1` de `ℕ` em `ℕ∖{0}`: **bijetora**. Injetora: `n+1 = m+1 ⇒ n = m`. Sobrejetora: dado `m ≥ 1`, `m − 1 ∈ ℕ` e `s(m−1) = m`. **Este é o exemplo do quadro (IMG_7933).**
4. A mesma regra `s(n) = n + 1`, agora vista como função de `ℕ` em `ℕ`, **não** é sobrejetora (0 não é atingido). **O contradomínio faz parte da função.**

**Pergunta de fixação:** `f(x) = x²` de ℝ em ℝ é injetora? E de `[0, ∞)` em `[0, ∞)`?
*Resposta:* de ℝ em ℝ, não, pois `f(−1) = f(1)`. De `[0,∞)` em `[0,∞)`, é bijetora.

### 0.3 Imagem direta e pré-imagem (atenção à notação `g⁻¹(Y)`)

Seja `g : A → B`.

- **Imagem direta** de `S ⊆ A`: `g(S) = {g(s) : s ∈ S}`.
- **Pré-imagem** (imagem inversa) de `Y ⊆ B`: `g⁻¹(Y) = {a ∈ A : g(a) ∈ Y}`.

> **Importante:** a pré-imagem `g⁻¹(Y)` **existe para qualquer função**, mesmo sem inversa. É só o conjunto dos pontos que caem dentro de `Y`. O símbolo `g⁻¹` sozinho, como função, só existe quando `g` é bijetora.

**Exemplo 0.3.** `g : {1,2,3,4} → {p,q,r}`, `g(1)=p, g(2)=q, g(3)=p, g(4)=r`.
- `g⁻¹({p}) = {1, 3}`; `g⁻¹({q, r}) = {2, 4}`; `g⁻¹(∅) = ∅`.
- `g({1,3}) = {p}`.

**Dois fatos usados no quadro (IMG_7927):**
- Sempre vale `g(g⁻¹(Y)) ⊆ Y` (quem veio de `Y` volta para `Y`).
- Se `g` é **sobrejetora**, vale `g(g⁻¹(Y)) = Y`: todo `y ∈ Y` é `g(a)` para algum `a`, e esse `a` está em `g⁻¹(Y)`.

*Contraexemplo para a igualdade sem sobrejetividade:* `g : {1} → {p, q}`, `g(1) = p`, `Y = {p, q}`. Então `g⁻¹(Y) = {1}` e `g({1}) = {p} ≠ Y`.

### 0.4 Composição e inversa

- **Composição:** se `f : A → B` e `g : B → C`, então `g ∘ f : A → C`, `(g∘f)(a) = g(f(a))`.
- **Composição de injetoras é injetora:** `g(f(x)) = g(f(y)) ⇒ f(x) = f(y)` (porque `g` é injetora) `⇒ x = y` (porque `f` é injetora).
- **Composição de sobrejetoras é sobrejetora:** dado `c ∈ C`, existe `b` com `g(b) = c` e existe `a` com `f(a) = b`; logo `g(f(a)) = c`.
- **Logo, composição de bijetoras é bijetora.**
- **Inversa:** se `f : A → B` é bijetora, `f⁻¹ : B → A` associa a cada `b` o **único** `a` com `f(a) = b`. `f⁻¹` também é bijetora, e `f⁻¹(f(a)) = a`, `f(f⁻¹(b)) = b`.
- **Restrição:** se `f : A → B` é injetora e `S ⊆ A`, então `f` restrita a `S` é uma **bijeção de `S` sobre `f(S)`**. Esse truque aparece várias vezes.

**Exemplo 0.4.** `f : {1,2,3} → {a,b,c}`, `f(1)=b, f(2)=c, f(3)=a`. Então `f⁻¹(a)=3, f⁻¹(b)=1, f⁻¹(c)=2`, e `f⁻¹∘f` é a identidade de `{1,2,3}`.

### 0.5 Indução e boa ordem

- **Princípio da indução:** se `P(0)` é verdadeira e `P(n) ⇒ P(n+1)` para todo `n`, então `P(n)` vale para todo `n ∈ ℕ`.
- **Princípio da boa ordem (PBO):** todo subconjunto **não vazio** de ℕ tem um **menor elemento**. Usado em IMG_7937.

Atenção: o PBO é falso em ℤ (ℤ não tem menor elemento) e em `ℚ ∩ (0, 1)` (não há racional positivo "menor que todos").

### 0.6 Uma propriedade de ℕ que aparece no canto do quadro

**[quadro, IMG_7922 e IMG_7938]** Para `a, b ∈ ℕ`:

`a < b ⇔ a + 1 ≤ b ⇔ a ≤ b − 1`.

Em ℕ, "estritamente menor" quer dizer "pelo menos uma unidade abaixo", porque **não há naturais entre `a` e `a + 1`**. Em ℝ, isso é falso: `0 < 0,5`, mas `0 + 1 ≤ 0,5` não vale.

---

## 1. O que é contar

### 1.1 Os conjuntos-padrão `Iₙ`

**[quadro, IMG_7922]**

`Iₙ = {i ∈ ℕ : 1 ≤ i ≤ n}`,  e  `Iₙ₊₁ = Iₙ ∪ {n+1}`.

Exemplos: `I₀ = ∅` (não há `i` com `1 ≤ i ≤ 0`), `I₁ = {1}`, `I₃ = {1, 2, 3}`, `I₄ = I₃ ∪ {4}`.

A fórmula `Iₙ₊₁ = Iₙ ∪ {n+1}` é a que torna as **induções** possíveis: para passar de `n` para `n + 1`, basta pensar no único elemento novo, `n + 1`.

### 1.2 Definição de conjunto finito

**[quadro, IMG_7922]** `X` é **finito** se existem `n ∈ ℕ` e uma bijeção `f : Iₙ → X`.

Isso formaliza o ato de contar. A Martha resume assim: quando uma criança conta 5 lápis, ela está montando uma bijeção entre os lápis e `{1, 2, 3, 4, 5}`: "este é o 1, este é o 2, …".

**Exemplos**

1. `X = {♠, ♥, ♦}`: `f(1) = ♠, f(2) = ♥, f(3) = ♦` é uma bijeção `I₃ → X`. Logo `X` é finito.
2. `X = {2, 4, 6, 8}`: `f(i) = 2i` é uma bijeção `I₄ → X`.
3. `X = ∅`: com `n = 0`, a função vazia `I₀ = ∅ → ∅` é bijetora. **O vazio é finito.**
4. `X = {x ∈ ℝ : x² = 4} = {−2, 2}`: bijeção `I₂ → X`, `1 ↦ −2`, `2 ↦ 2`.

### 1.3 Por que "o número de elementos" está bem definido?

Parece óbvio que um conjunto não pode ter 3 **e** 5 elementos. Mas "óbvio" não é prova. O professor enunciou:

**[quadro, IMG_7922] Lema.** Se `A ⊆ Iₙ` e existe uma bijeção `f : Iₙ → A`, então `A = Iₙ`.

**[quadro, IMG_7922] Teorema.** Se `f : Iₙ → X` e `g : Iₘ → X` são bijeções, então `n = m`. Nesse caso escrevemos **`|X| = n`** (o número de elementos, ou cardinalidade, de `X`).

As fotos não trazem as demonstrações. Seguem versões completas.

**Demonstração do Lema [complemento].** Por indução em `n`. Seja `P(n)`: "para todo `A ⊆ Iₙ`, se existe bijeção `Iₙ → A`, então `A = Iₙ`".

- *Base, `n = 0`.* `A ⊆ I₀ = ∅` força `A = ∅ = I₀`.
- *Passo.* Suponha `P(n)`. Seja `A ⊆ Iₙ₊₁` e `f : Iₙ₊₁ → A` bijetora. Chame `b = f(n+1)` e `A' = A ∖ {b}`. A restrição de `f` a `Iₙ` é uma bijeção `Iₙ → A'` (tiramos `n+1` do domínio e `b` da imagem).
  - *Caso 1: `n+1 ∉ A'`.* Então `A' ⊆ Iₙ` e, por `P(n)`, `A' = Iₙ`. Como `b ∉ A'` e `b ∈ Iₙ₊₁`, sobra `b = n+1`. Logo `A = Iₙ ∪ {n+1} = Iₙ₊₁`.
  - *Caso 2: `n+1 ∈ A'`.* Então `b ≠ n+1`, e `b ∈ Iₙ`. Seja `τ : Iₙ₊₁ → Iₙ₊₁` a troca que leva `b` em `n+1`, `n+1` em `b` e fixa o resto. `τ` é bijetora e `τ(A') ⊆ Iₙ`, porque o único elemento de `A'` fora de `Iₙ`, que é `n+1`, vai para `b ∈ Iₙ`. A composição `τ ∘ f`, restrita a `Iₙ`, é uma bijeção `Iₙ → τ(A')`. Por `P(n)`, `τ(A') = Iₙ`. Então `τ(A) = τ(A') ∪ {τ(b)} = Iₙ ∪ {n+1} = Iₙ₊₁`. Como `τ` é uma bijeção de `Iₙ₊₁` nele mesmo, `A = τ⁻¹(Iₙ₊₁) = Iₙ₊₁`. ∎

**Demonstração do Teorema [complemento].** Sem perda de generalidade, `m ≤ n`, e então `Iₘ ⊆ Iₙ`. A função `g⁻¹ ∘ f : Iₙ → Iₘ` é composição de bijeções, logo bijeção. Ela vai de `Iₙ` para o subconjunto `Iₘ ⊆ Iₙ`. Pelo Lema, `Iₘ = Iₙ`, e portanto `m = n`. ∎

**Moral:** contar de dois jeitos diferentes sempre dá o mesmo resultado. Isso é um **teorema**, e ele depende da indução.

---

## 2. Conjunto finito não é "do tamanho" de um subconjunto próprio

### 2.1 Enunciado

**[quadro, IMG_7923–7924] Teorema.** Se `X` é finito, `Y ⊆ X` e `f : X → Y` é bijeção, então `X = Y`.

"Em outras palavras, se `X` é finito, então não existe bijeção de `X` com um subconjunto próprio." (*Subconjunto próprio* = `Y ⊆ X` com `Y ≠ X`.)

**Intuição:** se você tem 3 bolas numa caixa e tira uma, não dá para "casar" as 3 bolas originais, uma a uma, com as 2 que ficaram. Com conjuntos infinitos isso **dá** (seção 5), e é exatamente essa diferença que a aula explora.

### 2.2 Demonstração do quadro, passo a passo

**[quadro, IMG_7924]** Como `X` é finito, existem `n ∈ ℕ` e uma bijeção `g : Iₙ → X`. Defina

`A = g⁻¹(Y) ⊆ Iₙ` (os índices cujos elementos estão em `Y`),

e

`h : Iₙ → A`,  `h(i) = g⁻¹(f(g(i)))`.

**Por que `h(i)` cai mesmo em `A`? [complemento]** `g(i) ∈ X`, então `f(g(i)) ∈ Y` (a imagem de `f` está em `Y`). Logo `g⁻¹(f(g(i)))` é um índice cujo elemento está em `Y`, isto é, pertence a `g⁻¹(Y) = A`. **Esse detalhe precisa ser verificado sempre que você define uma função com um contradomínio escolhido.**

Leia `h` como um "caminho": índice `i` → elemento `g(i)` de `X` → elemento `f(g(i))` de `Y` → índice desse elemento.

**[quadro, IMG_7926] `h` é injetora (exercício do quadro).** *Solução:* `h = g⁻¹ ∘ f ∘ g` é composição de três injetoras (`g`, `f` e `g⁻¹` são bijetoras), logo é injetora (seção 0.4).

**[quadro, IMG_7926] `h` é sobrejetora.** Tome `a ∈ A`. Pela definição de `A`, existe `y ∈ Y` com `g(a) = y` (isto é, `g⁻¹(y) = a`). Como `f` é sobrejetora, existe `x ∈ X` com `f(x) = y`. Como `g` é sobrejetora, existe `i ∈ Iₙ` com `g(i) = x`. Para esse `i`:

`h(i) = g⁻¹(f(g(i))) = g⁻¹(f(x)) = g⁻¹(y) = a`.

Então `h : Iₙ → A` é bijeção com `A ⊆ Iₙ`. **Pelo Lema, `A = Iₙ`.**

**[quadro, IMG_7927] Conclusão.** `Iₙ = A = g⁻¹(Y)`. Como `g` é bijetora,

`X = g(Iₙ) = g(g⁻¹(Y)) = Y`. ∎

### 2.3 Vendo a prova funcionar num exemplo concreto

`X = {p, q, r}`, `g(1)=p, g(2)=q, g(3)=r`. Suponha que alguém diga ter uma bijeção `f : X → Y` com `Y = {p, q}`. Então `A = g⁻¹(Y) = {1, 2}`, e `h` seria uma bijeção de `I₃` em `{1, 2}`. Mas `{1,2} = I₂ ≠ I₃`, o que contradiz o Lema. Logo, essa `f` não existe. A prova transporta o problema de `X` para o "mundo-padrão" `Iₙ`, onde o Lema resolve.

**Técnica para guardar:** para provar algo sobre um conjunto finito qualquer, **transporte para `Iₙ` via a bijeção `g`**, prove lá e transporte de volta.

---

## 3. Subconjunto de finito é finito

### 3.1 Enunciado

**[quadro, IMG_7928] Teorema.** Se `X` é finito e `Y ⊆ X`, então `Y` é finito e `|Y| ≤ |X|`.

### 3.2 "Basta mostrar para `X = Iₙ`" (exercício do quadro, resolvido)

**[complemento]** Suponha o teorema provado para os conjuntos `Iₙ`. Seja `X` finito, com bijeção `φ : Iₙ → X`, e seja `Y ⊆ X`. Então `B = φ⁻¹(Y) ⊆ Iₙ`, e pelo caso provado `B` é finito com `|B| ≤ n`: existe bijeção `ψ : I_k → B`, com `k ≤ n`. A restrição de `φ` a `B` é uma bijeção `B → Y` (0.4, e `φ(φ⁻¹(Y)) = Y` porque `φ` é sobrejetora). Então `φ ∘ ψ : I_k → Y` é bijeção. Logo `Y` é finito e `|Y| = k ≤ n = |X|`.

Esta é a mesma técnica da seção 2.3: transportar para `Iₙ`.

### 3.3 Demonstração por indução em `n = |X|`

**[quadro, IMG_7928]** *Base, `n = 0`.* A única possibilidade é `Y = ∅`, que é finito, e `|Y| = 0 ≤ |I₀|`.

**[quadro, IMG_7929]** *Passo.* Suponha o resultado válido para `n` fixado (para **todo** subconjunto de `Iₙ`) e tome `Y ⊆ Iₙ₊₁`. Há três casos:

- **Caso A: `Y ⊆ Iₙ`.** Pela hipótese de indução, `Y` é finito e `|Y| ≤ |Iₙ| = n ≤ n+1 = |Iₙ₊₁|`.
- **Caso B: `Y = Iₙ₊₁`.** Então `Y` é finito e `|Y| = n+1 ≤ |Iₙ₊₁|`.
- **Caso C [quadro, IMG_7930]: `Y ≠ Iₙ₊₁` e `Y ⊄ Iₙ`.** Como `Y ⊄ Iₙ`, temos `n+1 ∈ Y`. Como `Y ≠ Iₙ₊₁`, falta algum elemento, e ele não é `n+1`: existe `a ∈ Iₙ ∖ Y`.

   Defina `Z = (Y ∖ {n+1}) ∪ {a}` e observe que `Z ⊆ Iₙ`. A ideia é **trocar o elemento `n+1` pelo "buraco" `a`**. Defina também

   `g : Y → Z`,  `g(m) = m` se `m ≠ n+1`,  `g(m) = a` se `m = n+1`.

   "Como `a ∉ Y`, verifica-se que `g` é bijetora (exercício)."

   **[quadro, IMG_7931]** Pela hipótese de indução, `Z` é finito: existem `k` e uma bijeção `h : I_k → Z`. A composição `g⁻¹ ∘ h : I_k → Y` é bijeção. Para encerrar:

   `|Y| = k = |Z| ≤ |Iₙ| ≤ |Iₙ₊₁|`. ∎

**Exercício do quadro resolvido: `g` é bijetora [complemento].**
- *Injetora:* sejam `m ≠ m'` em `Y`. Se nenhum deles é `n+1`, `g(m) = m ≠ m' = g(m')`. Se, digamos, `m = n+1`, então `g(m) = a` e `g(m') = m' ∈ Y`. Como `a ∉ Y`, `a ≠ m'`.
- *Sobrejetora:* `a = g(n+1)`, e todo `z ∈ Y ∖ {n+1}` é `g(z)`.

É por isso que se escolhe `a` **fora** de `Y`: se `a` estivesse em `Y`, dois elementos iriam para `a`.

### 3.4 Exemplo concreto do Caso C

`n = 3` e `Y = {1, 4} ⊆ I₄`. Temos `4 ∈ Y` e `Y ≠ I₄`. Os elementos de `I₃ ∖ Y` são 2 e 3; escolha `a = 2`. Então `Z = {1} ∪ {2} = {1, 2} ⊆ I₃`, `g(1) = 1`, `g(4) = 2`. `Z = I₂`, então `h` = identidade de `I₂`, e `g⁻¹ ∘ h : I₂ → Y` é `1 ↦ 1`, `2 ↦ 4`. Logo `|Y| = 2 ≤ 4`. ✔

---

## 4. Corolário: funções entre conjuntos finitos

**[quadro, IMG_7932] Corolário.** Seja `f : X → Y` uma função.

1. Se `f` é bijetora, então `X` é finito se, e somente se, `Y` é finito, e nesse caso `|X| = |Y|`.
2. Se `f` é injetora e `Y` é finito, então `X` é finito e `|X| ≤ |Y|`.
3. Se `f` é sobrejetora e `X` é finito, então `Y` é finito e `|Y| ≤ |X|`.

*Demonstração: exercício (no quadro).* Solução completa **[complemento]**:

**(i)** Se `X` é finito, com `g : Iₙ → X` bijeção, então `f ∘ g : Iₙ → Y` é bijeção. Logo `Y` é finito e `|Y| = n`. A volta usa `f⁻¹ ∘ h`, com `h : Iₘ → Y`.

**(ii)** Como `f` é injetora, `f : X → f(X)` é bijeção (0.4). `f(X) ⊆ Y` e `Y` é finito, então pelo teorema da seção 3 `f(X)` é finito com `|f(X)| ≤ |Y|`. Por (i), `X` é finito e `|X| = |f(X)| ≤ |Y|`.

**(iii)** Seja `φ : Iₙ → X` bijeção. Para cada `y ∈ Y`, o conjunto `{i ∈ Iₙ : f(φ(i)) = y}` é não vazio (porque `f` é sobrejetora) e está contido em ℕ, então tem menor elemento `i_y` (PBO). Defina `s : Y → X`, `s(y) = φ(i_y)`. Então `f(s(y)) = y`, e isso torna `s` injetora: `s(y) = s(y') ⇒ y = f(s(y)) = f(s(y')) = y'`. Por (ii) aplicado a `s`, `Y` é finito e `|Y| ≤ |X|`.

(Escolher "o menor índice" evita ter de "escolher arbitrariamente" uma pré-imagem para cada `y`.)

### 4.1 A casa dos pombos (consequência do item ii)

Se `|X| > |Y|`, **não existe** função injetora `X → Y`. Em palavras: se há mais pombos do que casas, alguma casa recebe dois pombos.

- **Exemplo 1:** entre 13 pessoas, duas fazem aniversário no mesmo mês. A função "pessoa ↦ mês", de um conjunto de 13 elementos em um de 12, não pode ser injetora.
- **Exemplo 2:** escolha 6 números de `I₁₀`. Dois deles têm soma 11. Casas: os pares `{1,10}, {2,9}, {3,8}, {4,7}, {5,6}`, que são 5. Com 6 números, algum par recebe dois deles, e cada par soma 11.

### 4.2 Exemplos de uso direto

- `f : I₅ → {a, b, c}` **nunca** é injetora (item ii: seria preciso `5 ≤ 3`).
- `f : {a, b} → I₃` **nunca** é sobrejetora (item iii: seria preciso `3 ≤ 2`).
- Entre conjuntos finitos **de mesmo tamanho**, injetora ⇔ sobrejetora ⇔ bijetora (vale a pena provar como exercício, usando a seção 2). Em conjuntos infinitos isso é falso: `n ↦ n+1` de ℕ em ℕ é injetora e não sobrejetora.

---

## 5. Conjuntos infinitos

### 5.1 Definição

**[quadro, IMG_7932–7933]** Um conjunto `X` é **infinito** se `X` não é finito. Em outras palavras, para **qualquer** `n ∈ ℕ` e **qualquer** função `f : Iₙ → X`, `f` não é bijetora.

Note que "infinito" é uma **negação**. Para provar que algo é infinito, geralmente se supõe que é finito e se chega a uma contradição, ou se usa um critério pronto (seções 5.2, 6 e 7).

### 5.2 ℕ é infinito

**[quadro, IMG_7933 e IMG_7935]** A função `f : ℕ → ℕ∖{0}`, `f(n) = n + 1`, é bijeção (seção 0.2, exemplo 3). "Como `ℕ∖{0}` é subconjunto próprio, temos que ℕ não pode ser finito" (pela seção 2). Logo ℕ é infinito.

**A lógica em uma linha:** se ℕ fosse finito, a seção 2 proibiria uma bijeção com um subconjunto próprio. Mas acabamos de exibir uma. Contradição.

**Imagem mental (Hotel de Hilbert):** um hotel com quartos 0, 1, 2, … está lotado. Chega um hóspede. Cada hóspede muda do quarto `n` para o quarto `n+1`, e o quarto 0 fica livre. Isso é exatamente a bijeção `ℕ → ℕ∖{0}`. Num hotel finito, é impossível.

### 5.3 ℤ, ℚ, ℝ, ℂ e todo corpo ordenado são infinitos

**[quadro, IMG_7935]** "`ℤ, ℚ, ℝ, ℂ`, `K` corpo ordenado são todos infinitos, pois existe função injetora de ℕ nesses conjuntos."

**Por que uma injeção de ℕ basta [complemento]:** se `f : ℕ → Y` é injetora e `Y` fosse finito, o item (ii) do Corolário faria de ℕ um conjunto finito, o que é falso. Portanto `Y` é infinito.

**As injeções:**
- `ℤ, ℚ, ℝ, ℂ`: a inclusão `n ↦ n`.
- `K` corpo ordenado qualquer: `n ↦ n·1_K`. É injetora porque, **pelo Caderno 01 (seção 2.4)**, `n·1_K > 0` para `n ≥ 1`. Então, se `m < n`, `n·1_K − m·1_K = (n−m)·1_K > 0` e as imagens são diferentes. É aqui que a Aula 4 volta.

**Regra geral:** *se um conjunto contém uma cópia de ℕ, ele é infinito.* A seção 7 mostra que vale a volta: *todo infinito contém uma cópia de ℕ*.

---

## 6. Subconjuntos de ℕ: finito ⇔ limitado ⇔ tem máximo

**[quadro, IMG_7935] Teorema.** Seja `X ⊆ ℕ` não vazio. São equivalentes:

1. `X` é finito;
2. `X` é limitado;
3. `X` possui um máximo.

**Como se prova "são equivalentes":** basta um ciclo `(i) ⇒ (ii) ⇒ (iii) ⇒ (i)`. Três implicações dão as seis.

### 6.1 (i) ⇒ (ii): o truque da soma

**[quadro, IMG_7936]** `X` tem `0` como cota inferior (tudo em ℕ é `≥ 0`). Como `X` é finito e não vazio, existe bijeção `f : Iₙ → X` com `n ∈ ℕ*` (isto é, `n ≥ 1`). Tome

`a = f(1) + f(2) + ⋯ + f(n)`.

Dado `x ∈ X`, existe `i₀ ∈ Iₙ` com `x = f(i₀) ≤ a`. **[quadro, IMG_7937]** Logo `a` é cota superior de `X`, e `X` é limitado.

**Por que `f(i₀) ≤ a`? [complemento]** Porque `a = f(i₀) + (soma dos outros termos)` e os outros termos são naturais, portanto `≥ 0`. **O truque depende de todos os números serem não negativos.** Em ℤ ele falha: para `X = {−5, 2}`, a soma é `−3`, que não é cota superior.

**Exemplo:** `X = {3, 7, 10}`. Então `a = 20`, e de fato `3, 7, 10 ≤ 20`. A cota não precisa ser a melhor; basta existir.

### 6.2 (ii) ⇒ (iii): boa ordem aplicada às cotas superiores

**[quadro, IMG_7937]** Como `X` é limitado, o conjunto

`A = {n ∈ ℕ : n ≥ x para todo x ∈ X}` (as cotas superiores naturais de `X`)

é não vazio. Pelo princípio da boa ordem, `A` possui um elemento mínimo `a ∈ A`.

Vejamos que `a = máx X`. Como `a ∈ A`, já sabemos que `a ≥ x` para todo `x ∈ X`. Falta verificar que `a ∈ X`. Suponha, por contradição, que `a ∉ X`. Então `a > x` para todo `x ∈ X`. Em particular `a ≥ 1` (tome algum `x ∈ X`: `a > x ≥ 0`), e pelas propriedades da ordem, **[quadro, IMG_7938]** `a < b ⇔ a ≤ b − 1` em ℕ, então

`a − 1 ≥ x` para todo `x ∈ X`.

Disso, `a − 1 ∈ A` e `a − 1 < a`, o que contradiz o fato de `a` ser o mínimo de `A`.

**Os dois cuidados desta prova:**
- Verificar `a ≥ 1` **antes** de usar `a − 1`. Se `a = 0`, `a − 1` não é natural.
- O passo "`a > x ⇒ a − 1 ≥ x`" usa que estamos em ℕ (seção 0.6). Em ℝ é falso, e é por isso que em ℝ um conjunto limitado pode **não** ter máximo (ex.: `(0, 1)`).

**Exemplo:** `X = {3, 7, 10}`. `A = {10, 11, 12, …}`, `mín A = 10 = máx X`. ✔

### 6.3 (iii) ⇒ (i)

**[quadro, IMG_7938–7939]** Seja `n = máx X`. Então `X ⊆ Iₙ ∪ {0}`. Como `Iₙ ∪ {0}` é finito, `X` é finito "por um resultado anterior" (seção 3). ∎

**Por que `Iₙ ∪ {0}` é finito? [complemento]** `j : Iₙ₊₁ → Iₙ ∪ {0}`, `j(i) = i − 1`, é bijeção. (O 0 aparece porque, na convenção do professor, `0 ∈ ℕ` e pode estar em `X`.)

### 6.4 Consequências e exemplos

**[quadro, IMG_7939]** *Exemplo.* O conjunto dos naturais pares é infinito, pois não tem máximo: `2n < 2n + 2` para todo `n ∈ ℕ`.

Mais exemplos **[complemento]**:
- `{n ∈ ℕ : n² < 50}` é finito: é limitado por 7 (se `n ≥ 8`, `n² ≥ 64`). O máximo é 7.
- `{n ∈ ℕ : n é múltiplo de 3}` é infinito: não tem máximo, porque `3k < 3(k+1)`.
- **O teorema exige `X ⊆ ℕ`.** Em ℤ, `{−1, −2, −3, …}` tem máximo `−1` e é infinito. Em ℝ, `[0, 1]` tem máximo 1 e é infinito. As implicações (ii) ⇒ (i) e (iii) ⇒ (i) falham fora de ℕ.

---

## 7. Todo conjunto infinito contém uma cópia de ℕ

**[quadro, IMG_7939] Teorema.** Se `X` é um conjunto infinito, então existe uma função injetora `f : ℕ → X`.

### 7.1 Demonstração do quadro

**[quadro, IMG_7939]** Para cada `A ⊆ X` não vazio, escolha um elemento `y_A ∈ A`.

**[quadro, IMG_7940]** Definimos `f : ℕ → X` de maneira indutiva:

- `f(0) = y_X`.
- Suponha que, para `n ∈ ℕ`, `f(0), …, f(n)` estejam definidos, e considere o conjunto `Aₙ₊₁ = X ∖ {f(0), …, f(n)}`.

**[quadro, IMG_7942]** Como `X` é infinito, temos `Aₙ₊₁ ≠ ∅`. Caso contrário, `f : {0} ∪ Iₙ → X` seria sobrejetora, o que não é possível. Fazemos `f(n+1) = y_{Aₙ₊₁}`.

**Injetividade.** Tome `m, n ∈ ℕ` com `m ≠ n`. Podemos supor, sem perda de generalidade (SPG), que `m < n`. Então

`f(n) ∈ Aₙ = X ∖ {f(0), …, f(n−1)}` e `f(m) ∈ {f(0), …, f(n−1)}`, pois `m < n`.

Logo `f(m) ≠ f(n)`. ∎

### 7.2 Entendendo os detalhes

- **Por que "seria sobrejetora, o que não é possível"? [complemento]** Se `Aₙ₊₁ = ∅`, todo elemento de `X` está entre `f(0), …, f(n)`. Então `f`, restrita ao conjunto finito `{0} ∪ Iₙ`, é sobrejetora sobre `X`, e pelo Corolário (iii) `X` seria finito. Contradição.
- **A ideia em palavras:** tire um elemento de `X`, depois outro diferente, depois outro… Como `X` é infinito, nunca falta elemento. A sequência de escolhas é injetora porque cada escolha é feita **entre os que ainda não foram usados**.
- **Sobre "escolha `y_A`":** escolher simultaneamente um elemento de cada subconjunto não vazio é o **Axioma da Escolha**. O professor usa isso livremente; basta saber que é essa ferramenta que permite a construção quando não há uma regra explícita. Em ℕ não é necessário (pode-se usar "o menor elemento"), mas para um `X` qualquer, como um subconjunto estranho de ℝ, não há regra natural.

**Exemplo concreto [complemento].** `X = ℤ`, escolhendo sempre "o elemento de menor valor absoluto e, havendo empate, o positivo". Obtemos `f(0) = 0, f(1) = 1, f(2) = −1, f(3) = 2, f(4) = −2, …`. Neste caso `f` é até bijetora, mas o teorema só garante injetora.

### 7.3 Consequências importantes

Juntando as seções 5.3 e 7.1:

> **`X` é infinito ⇔ existe uma função injetora `ℕ → X`.**

E daí vem a **caracterização de Dedekind** citada pela Martha (p. 5): *um conjunto é infinito se, e somente se, está em bijeção com algum subconjunto próprio.*

**Prova da ida [complemento].** Seja `f : ℕ → X` injetora. Defina `F : X → X ∖ {f(0)}` por `F(f(n)) = f(n+1)` e `F(x) = x` se `x` não é da forma `f(n)`. É o Hotel de Hilbert dentro de `X`: os elementos da "cópia de ℕ" andam uma casa para frente e os demais ficam parados. `F` é bijetora, e `X ∖ {f(0)}` é subconjunto próprio.

**A volta** é a contrapositiva da seção 2.

---

## 8. Ponte [Martha]: conjuntos enumeráveis

Esta seção **não está no quadro** da Aula 6. Ela vem das notas *Conjuntos Infinitos* da Martha (pp. 2–12), indicadas no seu guia de leitura para esta aula. Ela responde à pergunta natural: *todos os infinitos são do mesmo tamanho?*

Ao ler as notas, lembre que lá `ℕ = {1, 2, 3, …}`.

### 8.1 Mesma cardinalidade e enumerável

- `A ∼ B` (**mesma cardinalidade**) quando existe bijeção `A → B`. É uma relação de equivalência: reflexiva (identidade), simétrica (inversa) e transitiva (composição).
- `A` é **enumerável** se `A ∼ ℕ`; **não enumerável** se não é finito nem enumerável; **no máximo enumerável** se é finito ou enumerável. Nessa convenção, **enumerável implica infinito**.
- **Enumerar** = listar sem repetições: `A = {a₁, a₂, a₃, …}`, com `aᵢ ≠ aⱼ` para `i ≠ j`.

### 8.2 Exemplos que surpreendem

1. **Pares:** `f(n) = 2n` é bijeção de ℕ sobre os pares. Um subconjunto próprio tem "o mesmo tamanho" de ℕ.
2. **ℤ é enumerável:** liste `0, 1, −1, 2, −2, 3, −3, …`.
   - Martha (`ℕ` a partir de 1): `f(n) = n/2` se `n` é par, `f(n) = (1−n)/2` se `n` é ímpar. Assim `f(1)=0, f(2)=1, f(3)=−1, f(4)=2, …`
   - Professor (`ℕ` a partir de 0): `f(n) = (n+1)/2` se `n` é ímpar, `f(n) = −n/2` se `n` é par. Assim `f(0)=0, f(1)=1, f(2)=−1, f(3)=2, f(4)=−2, …`
   - *Verificação (convenção do professor):* ímpares vão para os positivos (`1, 2, 3, …`), pares para `0, −1, −2, …`. Em cada grupo a fórmula é injetora e atinge tudo.

### 8.3 Os teoremas (com a ideia de cada prova)

- **Todo subconjunto infinito de um enumerável é enumerável** (Teo. 2.1.8). *Ideia:* percorra a lista `a₁, a₂, …` e guarde, **na ordem**, apenas os termos que estão em `B`. Como `B` é infinito, essa sublista nunca acaba. *Moral:* enumerável é o **menor** tipo de infinito.
- **União enumerável de enumeráveis é enumerável** (Teo. 2.1.11). *Ideia:* coloque `Eₙ` na linha `n` de uma tabela infinita e percorra as **diagonais**: `e₁₁; e₂₁, e₁₂; e₃₁, e₂₂, e₁₃; …` (soma dos índices 2, depois 3, depois 4, …). Cada diagonal é finita, então todo elemento aparece numa posição finita da lista.
- **`A × B` é enumerável se `A` e `B` são** (Teo. 2.1.14). *Ideia:* `A × B = ⋃_{a∈A} ({a} × B)`, uma união enumerável de cópias de `B`.
- **ℚ é enumerável** (Cor. 2.1.16). *Ideia:* `f : ℤ × ℤ* → ℚ`, `(p, q) ↦ p/q`, é sobrejetora e tem domínio enumerável. A imagem é infinita (contém ℤ), então ℚ é enumerável.

**Exemplo da diagonal para ℚ positivo:** na tabela com linhas `p = 1, 2, 3, …` e colunas `q = 1, 2, 3, …`, percorrendo as diagonais e **pulando as repetições** (`2/2 = 1/1`, etc.):
`1/1, 2/1, 1/2, 3/1, 1/3, 4/1, 3/2, 2/3, 1/4, 5/1, …`

### 8.4 ℝ não é enumerável: a diagonal de Cantor (Teo. 2.1.17)

**Afirmação:** `[0, 1]` é infinito e não enumerável.

*Infinito:* contém `{1/n : n ≥ 1}`, que está em bijeção com ℕ.

*Não enumerável, por absurdo:* suponha uma lista `x₁, x₂, x₃, …` com todos os pontos de `[0, 1]`. Escreva cada um em decimal infinito. Para evitar ambiguidade, a Martha usa a forma terminada em 9s: `0,5 = 0,4999…` e `1 = 0,999…`.

```
x₁ = 0, a₁₁ a₁₂ a₁₃ …
x₂ = 0, a₂₁ a₂₂ a₂₃ …
x₃ = 0, a₃₁ a₃₂ a₃₃ …
```

Construa `b = 0, b₁ b₂ b₃ …` com `bₙ = 5` se `aₙₙ ≠ 5` e `bₙ = 6` se `aₙₙ = 5`. Então `b` difere de `x₁` na 1ª casa, de `x₂` na 2ª, …, de `xₙ` na `n`-ésima. `b ∈ [0,1]` não está na lista. Contradição.

**Exemplo numérico.** Se a lista começa com
`x₁ = 0,5123…`, `x₂ = 0,1415…`, `x₃ = 0,3333…`, `x₄ = 0,9995…`,
os dígitos da diagonal (1ª casa de `x₁`, 2ª de `x₂`, 3ª de `x₃`, 4ª de `x₄`) são `5, 4, 3, 5`, e então `b = 0,6556…`. Confira: `b` difere de cada `xₙ` na casa `n`.

**Ligação com a Aula 4:** a Martha pergunta "esse número `b` existe?" e responde com `b = sup { b₁/10 + b₂/10² + ⋯ + bₙ/10ⁿ : n ∈ ℕ }`. **O número `b` existe por causa da completude de ℝ.** Em ℚ esse sup poderia não existir. Um decimal infinito é um supremo.

**Consequências:** ℝ não é enumerável (Cor. 2.1.18). ℝ∖ℚ não é enumerável (Cor. 2.1.19): se fosse, `ℝ = ℚ ∪ (ℝ∖ℚ)` seria união de dois enumeráveis, portanto enumerável. **Há "mais" irracionais do que racionais**, embora os racionais sejam densos (Caderno 01, seção 3.3).

**Quadro-resumo dos tamanhos**

| Conjunto | Tipo |
|---|---|
| `∅`, `{a,b,c}`, `Iₙ` | finito |
| ℕ, pares, ℤ, ℚ, `ℕ×ℕ`, algébricos | enumerável (o "menor" infinito) |
| `[0,1]`, ℝ, ℝ∖ℚ, transcendentes | não enumerável |

---

## 9. Exercícios resolvidos

### Exercício 1 — contar bijeções

Quantas bijeções existem de `I₃` em `{a, b, c}`?

**Solução.** `f(1)` tem 3 opções. `f(2)` tem 2 (não pode repetir, pois `f` é injetora). `f(3)` tem 1. Total: `3·2·1 = 6`. Todas mostram que `|{a,b,c}| = 3`, e o teorema da seção 1.3 garante que nenhuma bijeção "conta" 4 ou 2.

### Exercício 2 — ℕ é infinito por outra bijeção

Mostre, usando `f(n) = 2n`, que ℕ é infinito.

**Solução.** `f : ℕ → P` (pares) é bijetora: injetora porque `2n = 2m ⇒ n = m`, sobrejetora porque todo par é `2k`. `P ⊊ ℕ`, pois `1 ∉ P`. Pela seção 2, ℕ não pode ser finito.

### Exercício 3 — aplicar o teorema da seção 6

Decida se é finito e, se for, encontre o máximo: (a) `X = {n ∈ ℕ : 3n + 1 < 40}`; (b) `Y = {n ∈ ℕ : n é ímpar}`.

**Solução.** (a) `3n + 1 < 40 ⇔ 3n < 39 ⇔ n < 13 ⇔ n ≤ 12` (seção 0.6). Logo `X = {0, …, 12}`: limitado, então finito, com `máx X = 12`. (b) Se `n` é ímpar, `n + 2` também é e é maior, então `Y` não tem máximo. Pelo teorema, `Y` é infinito.

### Exercício 4 — por que o teorema da seção 6 exige ℕ

Dê um conjunto `X ⊆ ℤ` que tem máximo e é infinito.

**Solução.** `X = {−1, −2, −3, …}`: `máx X = −1`. `X` é infinito porque `n ↦ −(n+1)` é injetora de ℕ em `X` (seção 5.3). A prova de (iii) ⇒ (i) usou `X ⊆ Iₙ ∪ {0}`, o que só faz sentido para naturais.

### Exercício 5 — acrescentar um elemento

Se `X` é finito com `|X| = n` e `x ∉ X`, mostre que `X ∪ {x}` é finito com `n + 1` elementos.

**Solução.** Seja `g : Iₙ → X` bijeção. Defina `G : Iₙ₊₁ → X ∪ {x}` por `G(i) = g(i)` se `i ≤ n` e `G(n+1) = x`. `G` é injetora: em `Iₙ` é `g`, e `x ∉ X` garante que `G(n+1) ≠ G(i)`. `G` é sobrejetora: atinge `X` via `g` e atinge `x`. Aqui se vê de novo a fórmula `Iₙ₊₁ = Iₙ ∪ {n+1}`.

### Exercício 6 — união de finitos

Se `A` e `B` são finitos, então `A ∪ B` é finito e `|A ∪ B| ≤ |A| + |B|`.

**Solução.** Sejam `f : Iₐ → A` e `g : I_b → B` bijeções (com `a = |A|`, `b = |B|`). Defina `H : I_{a+b} → A ∪ B`, `H(i) = f(i)` se `i ≤ a` e `H(i) = g(i − a)` se `i > a`. `H` é **sobrejetora**, e pelo Corolário (iii) `A ∪ B` é finito com `|A ∪ B| ≤ a + b`. (`H` pode não ser injetora se `A ∩ B ≠ ∅`. Por isso vale apenas `≤`.)

### Exercício 7 — Hotel de Hilbert com três hóspedes

Exiba uma bijeção de ℕ em `ℕ ∖ {0, 1, 2}`.

**Solução.** `f(n) = n + 3`. Injetora é imediato. Sobrejetora: dado `m ≥ 3`, `f(m − 3) = m`. Os quartos 0, 1 e 2 ficam livres para os novos hóspedes.

### Exercício 8 — verificar a bijeção ℕ → ℤ

Na convenção do professor, verifique que `f(n) = (n+1)/2` (`n` ímpar) e `f(n) = −n/2` (`n` par) é bijetora.

**Solução.** *Injetora:* se `n, m` são ambos ímpares, `(n+1)/2 = (m+1)/2 ⇒ n = m`. Se são ambos pares, `−n/2 = −m/2 ⇒ n = m`. Se um é ímpar e o outro par, as imagens têm sinais diferentes (`> 0` contra `≤ 0`), logo são distintas. *Sobrejetora:* dado `k > 0`, `f(2k − 1) = k`. Dado `k ≤ 0`, `f(−2k) = k`.

### Exercício 9 — a diagonal na prática

Uma lista começa com `x₁ = 0,1111…`, `x₂ = 0,2525…`, `x₃ = 0,3355…`. Calcule os três primeiros dígitos do `b` de Cantor.

**Solução.** A diagonal é `a₁₁ = 1`, `a₂₂ = 5`, `a₃₃ = 5`. Então `b₁ = 5` (porque `1 ≠ 5`), `b₂ = 6` (porque `a₂₂ = 5`), `b₃ = 6`. Logo `b = 0,566…`, que difere de `x₁` na 1ª casa, de `x₂` na 2ª e de `x₃` na 3ª.

### Exercício 10 — casa dos pombos

Mostre que, em qualquer conjunto de 5 pontos com coordenadas inteiras no plano, há dois cujo ponto médio tem coordenadas inteiras.

**Solução.** Classifique cada ponto `(x, y)` pela paridade de `(x, y)`: (par, par), (par, ímpar), (ímpar, par), (ímpar, ímpar). São 4 casas para 5 pontos, então pela seção 4.1 dois pontos têm a mesma paridade nas duas coordenadas. Nesse caso `x₁ + x₂` e `y₁ + y₂` são pares, e o ponto médio `((x₁+x₂)/2, (y₁+y₂)/2)` tem coordenadas inteiras.

---

## 10. O que você precisa fortalecer

### 10.1 Pré-requisitos que não podem falhar (em ordem de prioridade)

1. **Provar injetividade e sobrejetividade** pelos modelos da seção 0.2. Se "suponha `f(x) = f(y)`…" ou "dado `b ∈ B`, tome `a = …`" não sai automaticamente, pare e treine com `n ↦ 2n`, `n ↦ n+1`, `n ↦ ⌊n/2⌋`.
2. **Pré-imagem `g⁻¹(Y)`** como conjunto, e o fato `g(g⁻¹(Y)) = Y` quando `g` é sobrejetora.
3. **Composição e inversa de bijeções.** Quase todas as provas da aula terminam com "a composição … é bijeção".
4. **Indução com hipótese forte o bastante.** Na seção 3, a hipótese vale para **todo** subconjunto de `Iₙ`, não para um `Y` fixo. É isso que permite aplicá-la a `Z`.
5. **Boa ordem** e o cuidado com `a − 1` em ℕ (seção 6.2).

### 10.2 Resultados que você deve saber enunciar e provar sem consulta

- Definição de finito e de `|X|`; por que `|X|` está bem definido (Lema + Teorema).
- Finito ⇒ não há bijeção com um subconjunto próprio (prova com `A = g⁻¹(Y)` e `h = g⁻¹∘f∘g`).
- Subconjunto de finito é finito (indução com os três casos e a troca `n+1 ↔ a`).
- Corolário (i), (ii), (iii).
- ℕ é infinito; por que ℤ, ℚ, ℝ e qualquer corpo ordenado são infinitos.
- `X ⊆ ℕ`: finito ⇔ limitado ⇔ tem máximo (o ciclo completo).
- Infinito ⇒ existe injeção `ℕ → X`.
- (Ponte) ℤ e ℚ enumeráveis; diagonal de Cantor.

### 10.3 Erros comuns

| Erro | Correção |
|---|---|
| Achar que `g⁻¹(Y)` exige `g` invertível | A pré-imagem existe para qualquer função (0.3). |
| Definir `h : Iₙ → A` sem mostrar que `h(i) ∈ A` | Sempre verifique que a função cai no contradomínio anunciado. |
| Confundir `Y ⊆ X` com "`Y` menor que `X`" em infinitos | Pares ⊊ ℕ, mas pares ∼ ℕ. |
| Usar a fórmula da Martha (ℕ começa em 1) com o ℕ do professor | Veja o aviso de convenção e a seção 8.2. |
| Usar `a − 1` sem ter provado `a ≥ 1` | Seção 6.2. |
| Achar que "limitado ⇒ finito" vale em ℤ ou ℝ | Só vale para subconjuntos de ℕ (seção 6.4). |
| Achar que "infinito" significa "muito grande" | Significa "nenhuma bijeção com `Iₙ`". Equivalentemente, contém uma cópia de ℕ. |
| Achar que denso ⇒ não enumerável | ℚ é denso **e** enumerável. |

### 10.4 Plano de repetição (mesmo esquema do Caderno 01)

- **Hoje:** feche as fontes e escreva as definições de finito e infinito, o enunciado do Lema e os três itens do Corolário.
- **Amanhã:** refaça, sem olhar, as provas das seções 2.2 e 6 (o ciclo completo).
- **Em 3 dias:** refaça a indução da seção 3 com o exemplo `Y = {2, 5} ⊆ I₅` (troque 5 por um buraco de `I₄ ∖ Y`).
- **Em uma semana:** explique em voz alta a diagonal de Cantor e por que ela precisa do supremo.
- Se uma prova travar, volte à **hipótese** que deveria ser usada naquele passo, e não apenas à última linha.

---

## 11. Ponte para a Aula 8

**[quadro, IMG_8017–8019]** A Aula 8 começa com *Limites de sequências*:

> **Def.** Uma sequência de números reais é uma função `a : ℕ → ℝ`. Notação: `aₙ := a(n)` (o `n`-ésimo termo). Escrevemos `(a₀, a₁, …)`, `(aₙ)_{n∈ℕ}` ou `(aₙ)`.

Repare como esta aula prepara a próxima:

- Uma sequência é **uma função com domínio ℕ**, o mesmo tipo de objeto da seção 7. A função injetora `f : ℕ → X` construída lá é uma "sequência sem repetições" em `X`.
- A Martha observa (Def. 2.1.7) que um conjunto enumerável é a **imagem de uma sequência de termos distintos**.
- O quadro começa em `a₀`: o professor mantém `0 ∈ ℕ`.
- Na diagonal de Cantor, o número `b` foi obtido como **supremo de uma sequência crescente** de somas parciais `b₁/10 + ⋯ + bₙ/10ⁿ`. Na Aula 8 isso vira teorema: *toda sequência crescente e limitada converge*, e a prova usa o supremo da Aula 4.

O próximo caderno vai explicar a definição de limite (a ordem dos quantificadores `∀ε ∃n₀ ∀n ≥ n₀`), usando as fotos da Aula 8 e as notas *Sequências Numéricas* da Martha.
