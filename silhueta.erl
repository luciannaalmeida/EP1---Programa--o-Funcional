-module(silhueta).
-import(uniao, [uniao/2]).
-import(imagem, [gera_imagem/2, preenche_retangulo/6]).

-compile(export_all).

main() ->
    main([]).    

main([]) ->
    main(['2']);
main([Nome_algoritmo]) ->
    main([Nome_algoritmo, stdin]);
main([Nome_algoritmo, Nome_arquivo_de_entrada]) ->
    main([Nome_algoritmo, Nome_arquivo_de_entrada, stdout, nil]);
main([Nome_algoritmo, Nome_arquivo_de_entrada, Nome_arquivo_de_saida]) ->
    main([Nome_algoritmo, Nome_arquivo_de_entrada, Nome_arquivo_de_saida, nil]);
main([Nome_algoritmo, Nome_arquivo_de_entrada, Nome_arquivo_de_saida, Nome_da_imagem]) ->
    Arquivo_de_entrada = abre_arquivo(Nome_arquivo_de_entrada, read),
    Arquivo_de_saida = abre_arquivo(Nome_arquivo_de_saida, write),
    Silhueta = ep(Nome_algoritmo, leitor_para(Arquivo_de_entrada), escritor_para(Arquivo_de_saida)),
    imagem:gera_imagem(Silhueta, Nome_da_imagem),
    file:close(Arquivo_de_entrada),
    file:close(Arquivo_de_saida),
    init:stop().


ep(Nome_algoritmo, Leitor, Escritor) ->
    Algoritmo = algoritmo(Nome_algoritmo),
    Lista_de_edificios = le_arquivo_e_transforma_em_edificios(Leitor),
    Silhueta = Algoritmo(Lista_de_edificios),
    escreve_silhueta_no_arquivo(Escritor, Silhueta),
    Silhueta.

abre_arquivo(Nome_arquivo, Tipo) ->
    case file:open(Nome_arquivo, Tipo) of
	{ok, Arquivo} ->  Arquivo;
	_ -> Nome_arquivo
    end.

leitor_para(stdin) ->
    fun(Formato) -> 
	    io:fread("", Formato) 
    end;
leitor_para(Arquivo_de_entrada) ->
    fun(Formato) -> 
	    io:fread(Arquivo_de_entrada, "", Formato) 
    end.

escritor_para(stdout) ->
    fun(Formato, Dados) -> 
	    io:format(Formato, Dados) 
    end;
escritor_para(Arquivo_de_saida) ->
    fun(Formato, Dados) -> 
	    io:format(Arquivo_de_saida, Formato, Dados) 
    end.

algoritmo('1') ->
    fun algoritmo1/1;
algoritmo('2') ->
    fun algoritmo2/1;
algoritmo('L') ->
    fun silhueta_com_foldl/1;
algoritmo('R') ->
    fun silhueta_com_foldr/1.

le_arquivo_e_transforma_em_edificios(Leitor) ->
    {ok, [Numero_de_linhas]} = Leitor("~d"),
    lists:map(fun (_) -> 
		      {ok, Edificio} = Leitor("~d ~d ~d"),
		      list_to_tuple(Edificio)
	      end,
	      lists:seq(1, Numero_de_linhas)).

escreve_silhueta_no_arquivo(Escritor, Silhueta) ->
    Escritor("~p~n", [length(Silhueta)]),
    escreve_silhueta_de_fato(Escritor, Silhueta).

escreve_silhueta_de_fato(_Escritor, []) ->
    ok;
escreve_silhueta_de_fato(Escritor, [{X, H} | Resto]) ->
    Escritor("~p ~p~n", [X, H]),
    escreve_silhueta_de_fato(Escritor, Resto).


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
