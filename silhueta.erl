-module(silhueta).
-import(uniao, [uniao/2]).
-import(imagem, [gera_imagem/2, preenche_retangulo/6]).

-compile(export_all).

main([]) ->
    ep("2", stdin, stdout);

main([Nome_algoritmo]) ->
    ep(Nome_algoritmo, stdin, stdout);
    
main([Nome_algoritmo, Nome_arquivo_de_entrada]) ->
    {ok, Arquivo_de_entrada} = file:open(Nome_arquivo_de_entrada, read),
    Silhueta = ep(Nome_algoritmo, Arquivo_de_entrada, stdou),
    file:close(Arquivo_de_entrada),
    Silhueta;

main([Nome_algoritmo, Nome_arquivo_de_entrada, Nome_arquivo_de_saida]) ->
    {ok, Arquivo_de_entrada} = file:open(Nome_arquivo_de_entrada, read),
    {ok, Arquivo_de_saida} = file:open(Nome_arquivo_de_saida, write),
    Silhueta = ep(Nome_algoritmo, Arquivo_de_entrada, Arquivo_de_saida),
    file:close(Arquivo_de_entrada),
    file:close(Arquivo_de_saida),
    Silhueta;

main([Nome_algoritmo, Nome_arquivo_de_entrada, Nome_arquivo_de_saida, Nome_da_imagem]) ->
    Silhueta = main([Nome_algoritmo, Nome_arquivo_de_entrada, Nome_arquivo_de_saida]),
    imagem:gera_imagem(Silhueta, Nome_da_imagem),
    Silhueta.


ep(Nome_algoritmo, Arquivo_de_entrada, Arquivo_de_saida) ->
    Algoritmo = algoritmo(Nome_algoritmo),
    Lista_de_edificios = le_arquivo_e_transforma_em_edificios(Arquivo_de_entrada),
    Silhueta = Algoritmo(Lista_de_edificios),
    escreve_silhueta_no_arquivo(Arquivo_de_saida, Silhueta),
    Silhueta.
    
algoritmo("1") ->
    fun algoritmo1/1;
algoritmo("2") ->
    fun algoritmo2/1;
algoritmo("L") ->
    fun silhueta_com_foldl/1;
algoritmo("R") ->
    fun silhueta_com_foldr/1.

le_arquivo_e_transforma_em_edificios(Arquivo_de_entrada) ->
    [{1,1,1}].

escreve_silhueta_no_arquivo(Arquivo_de_saida, Silhueta) ->
    true.


silhueta_do_edificio({X_inicial, Altura, X_final}) ->
    [{X_inicial, Altura}, {X_final, 0}].


algoritmo1(Lista_de_edificios) ->
    algoritmo1(Lista_de_edificios, []).

algoritmo1([], Resultado) ->
    Resultado;
algoritmo1([Edificio | Resto], Resultado) ->
    algoritmo1(Resto, uniao:uniao(silhueta_do_edificio(Edificio), Resultado)).


algoritmo2([Edificio]) ->
    silhueta_do_edificio(Edificio);
algoritmo2(Lista_de_edificios) -> 
    {Primeira_metade, Segunda_metade} = divide_lista_ao_meio(Lista_de_edificios),
    uniao:uniao(algoritmo2(Primeira_metade), algoritmo2(Segunda_metade)).
     


divide_lista_ao_meio(Lista) ->
    divide_lista_ao_meio(Lista, Lista, []).

divide_lista_ao_meio([], Segunda_metade, Primeira_metade) ->
    {lists:reverse(Primeira_metade) , Segunda_metade};
divide_lista_ao_meio([_], Segunda_metade, Primeira_metade) ->
    {lists:reverse(Primeira_metade) , Segunda_metade};
divide_lista_ao_meio([_,_|Resto], [Elemento_1 | Segunda_metade], Primeira_metade) ->
    divide_lista_ao_meio(Resto, Segunda_metade, [Elemento_1 | Primeira_metade]).




silhueta_com_foldl(Lista_de_edificios) -> 
    lists:foldl(fun uniao_esperta/2, [], Lista_de_edificios).

silhueta_com_foldr(Lista_de_edificios) -> 
    lists:foldr(fun uniao_esperta/2, [], Lista_de_edificios).

uniao_esperta(Edificio, Silhueta) ->
    uniao:uniao(silhueta_do_edificio(Edificio), Silhueta).
