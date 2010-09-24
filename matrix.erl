%% Modulo que implementa matrizes bidimensionais imutaveis.
%%
%% Uma matriz e' representada por uma tripla {M, N, A}, 
%% onde M e' o numero de linhas da matriz,
%%      N e' o numero de colunas da matriz,
%% e    A e' um array unidimensional de M * N elementos, contendo a
%%        linearizacao da matriz.

-module(matrix).
-export([new/2, get/3, set/4, n_rows/1, n_columns/1]).

%% Cria uma nova matriz com M linhas e N colunas.
new(M, N) -> 
    {M, N, array:new(M * N)}.

%% Devolve o valor na linha I e coluna J da matriz.
get(I, J, {_M, N, A}) ->
    array:get(N * I + J, A).

%% Devolve uma nova matriz que e' igual `a matriz {M, N, A} exceto pelo valor
%% na linha I e coluna J, o qual e' Value.
set(I, J, Value, {M, N, A}) ->
    {M, N, array:set(N * I + J, Value, A)}.

%% Recebe uma matriz e devolve o numero de linhas dessa matriz.
n_rows({M, _N, _A}) ->
    M.

%% Recebe uma matriz e devolve o numero de colunas dessa matriz.
n_columns({_M, N, _A}) ->
    N.
