-module(imagem).
-import(matrix, [new/2, get/3, set/4, n_rows/1, n_columns/1]).
-export([gera_imagem/2, preenche_retangulo/6]).



n_lins() -> 600.                      % número de linhas da imagem
n_cols() -> 800.                      % número de colunas da imagem
borda_inf() -> n_lins() - 1.          % borda inferior (última linha da imagem) 
margem_inf() -> 20.                   % linhas do eixo base à borda inferior da imagem
base() -> borda_inf() - margem_inf(). % linha do eixo base 

branco() -> 15.                       % valor de maxval
cinza() -> 10.                        % cor da silhueta preenchida
preto() -> 0.                         % cor do eixo base







gera_imagem(_Silhueta, Nome_da_imagem) ->
    {ok, Imagem} = file:open(Nome_da_imagem, write),
    
    
    file:close(Imagem),
    true.

%% Recebe uma silhueta ListaDePares, converte-a para uma imagem no formato PGM, e guarda essa imagem no arquivo cujo nome é String. As imagens geradas por essa função têm tamanho fixo de n_lins() pontos na direção vertical e n_cols() pontos na horizontal, com uma distância de margem_inf() pontos entre o eixo base da silhueta (o eixo horizontal) e a borda horizontal inferior da imagem. A função gera_imagem supõe que as coordenadas horizontais da silhueta s estão no intervalo de 0 a n_cols()-1 e que as alturas dessa silhueta são menores que n_lins()-margem_inf().

%% Essa função trabalha com matrizes bidimensionais de n_lins() linhas e n_cols() colunas. Ela gera uma imagem fazendo uma série de chamadas à função preenche_retangulo/6 para preencher a matriz, e depois grava essa matriz no arquivo String, precedida do cabeçalho adequado. O preenchimento da matriz é feito de modo que os pontos no eixo base da silhueta tenham cor negra, os pontos da silhueta e os compreendidos entre a silhueta e o eixo base tenham cor cinza, e todos os demais pontos tenham cor branca.

preenche_retangulo(Matriz, _Lin1, _Lin2, _Col1, _Col2, _Valor) -> Matriz.

%% Recebe uma Matriz, dois índices de linha tais que 0 ≤ Lin1 ≤ Lin2, dois índices de coluna tais que 0 ≤ Col1 ≤ Col2, e um Valor. A função devolve uma matriz Matriz1, obtida a partir da Matriz original preenchendo-se com o Valor a submatriz retangular de Matriz delimitada por Lin1, Lin2, Col1 e Col2. 
