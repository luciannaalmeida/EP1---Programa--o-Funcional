-module(imagem).
-import(matrix, [new/2, get/3, set/4, n_rows/1, n_columns/1]).
-export([gera_imagem/2, preenche_retangulo/6]).



n_lins() -> 600.                      % número de linhas da imagem
n_cols() -> 800.                      % número de colunas da imagem
borda_inf() -> n_lins() - 1.          % borda inferior (última linha da imagem) 
margem_inf() -> 20.                   % linhas do eixo base à borda inferior da imagem
base() -> borda_inf() - margem_inf(). % linha do eixo base 

espessura_da_base() -> 1.

branco() -> 15.                       % valor de maxval
cinza() -> 10.                        % cor da silhueta preenchida
preto() -> 0.                         % cor do eixo base






gera_imagem(_, nil) -> 
    nil;
gera_imagem(Silhueta, Nome_da_imagem) ->
    {ok, Imagem} = file:open(Nome_da_imagem, write),
    escreve_cabecalho(Imagem),
    Matriz_inicial = matrix:new(n_lins(), n_cols()),
    Matriz_branca = preenche_retangulo(Matriz_inicial, 0, n_lins()-1, 0, n_cols()-1, branco()),
    Matriz_resultado = pinta_silhueta_na_matriz(Silhueta, Matriz_branca),
    escreve_matriz_na_imagem(Imagem, Matriz_resultado),
    file:close(Imagem),
    true.

escreve_cabecalho(Imagem) ->
    io:format(Imagem, "P2~n~p ~p~n~p~n", [n_cols(), n_lins(), branco()]).

pinta_silhueta_na_matriz([], Matriz) ->
    Matriz;
pinta_silhueta_na_matriz([{Primeiro_X, Primeiro_H} | Resto_da_Silhueta], Matriz) ->
    pinta_silhueta_na_matriz(Resto_da_Silhueta, Matriz, Primeiro_X, Primeiro_H).

pinta_silhueta_na_matriz([], Matriz_sem_eixo_base, _, _) ->
    preenche_retangulo(Matriz_sem_eixo_base, base(), base()+espessura_da_base(), 0, n_cols()-1, preto());
pinta_silhueta_na_matriz([{Novo_X, Novo_H} | Resto_da_Silhueta], Matriz, Ultimo_X, Ultimo_H) ->
    Nova_matriz = preenche_retangulo(Matriz, n_lins() - (Ultimo_H+margem_inf()) -1, n_lins() - margem_inf() -1, Ultimo_X, Novo_X, cinza()),
    pinta_silhueta_na_matriz(Resto_da_Silhueta, Nova_matriz, Novo_X, Novo_H).

escreve_matriz_na_imagem(Imagem, Matriz) ->
    for(0, n_lins()-1, fun(I) ->
			     for(0, n_cols()-1, fun(J) ->
						      io:format(Imagem, "~p ", [matrix:get(I, J, Matriz)])
					      end),
			     io:format(Imagem, "~n", [])
		     end).

for(Inicio, Fim, Func) ->
    lists:map(Func, lists:seq(Inicio, Fim)).

%% Recebe uma silhueta ListaDePares, converte-a para uma imagem no formato PGM, e guarda essa imagem no arquivo cujo nome é String. As imagens geradas por essa função têm tamanho fixo de n_lins() pontos na direção vertical e n_cols() pontos na horizontal, com uma distância de margem_inf() pontos entre o eixo base da silhueta (o eixo horizontal) e a borda horizontal inferior da imagem. A função gera_imagem supõe que as coordenadas horizontais da silhueta s estão no intervalo de 0 a n_cols()-1 e que as alturas dessa silhueta são menores que n_lins()-margem_inf().

%% Essa função trabalha com matrizes bidimensionais de n_lins() linhas e n_cols() colunas. Ela gera uma imagem fazendo uma série de chamadas à função preenche_retangulo/6 para preencher a matriz, e depois grava essa matriz no arquivo String, precedida do cabeçalho adequado. O preenchimento da matriz é feito de modo que os pontos no eixo base da silhueta tenham cor negra, os pontos da silhueta e os compreendidos entre a silhueta e o eixo base tenham cor cinza, e todos os demais pontos tenham cor branca.

preenche_retangulo(Matriz, Lin1, Lin2, Col1, Col2, Valor) -> 
    Lista_de_linhas = lists:seq(Lin1, Lin2),
    Lista_de_colunas = lists:seq(Col1, Col2),
    preenche_retangulo(Matriz, Lista_de_linhas, Lista_de_colunas, Valor).

preenche_retangulo(Matriz, Lista_de_linhas, Lista_de_colunas, Valor) ->
    lists:foldl(fun(I, Matriz_para_linha) ->
			lists:foldl(fun(J, Matriz_para_pintar) ->
					    matrix:set(I, J, Valor, Matriz_para_pintar)
				    end,
				    Matriz_para_linha,
			 	    Lista_de_colunas)
		end,
		Matriz,
		Lista_de_linhas).

%% Recebe uma Matriz, dois índices de linha tais que 0 ≤ Lin1 ≤ Lin2, dois índices de coluna tais que 0 ≤ Col1 ≤ Col2, e um Valor. A função devolve uma matriz Matriz1, obtida a partir da Matriz original preenchendo-se com o Valor a submatriz retangular de Matriz delimitada por Lin1, Lin2, Col1 e Col2. 
