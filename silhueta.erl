-module(silhueta).
-compile(export_all).

cmp(A, B) ->
    case A =< B of
	true ->
	    primeiro_menor_ou_iguais;
	false ->
	    segundo_menor
    end.



alterna_status(desceu) ->
    subiu;
alterna_status(subiu) ->
    desceu.


atualiza_status(Status_1, Status_2, lista_1) ->
    {alterna_status(Status_1), Status_2};
atualiza_status(Status_1, Status_2, lista_2) ->
    {Status_1, alterna_status(Status_2)};
atualiza_status(Status_1, Status_2, ambos) ->
    {alterna_status(Status_1), alterna_status(Status_2)}.



ponto_na_mesma_coluna_do_resultado(X_novo, X_resultado) ->
    X_novo =:= X_resultado.


ponto_na_mesma_coluna_e_mais_baixo_que_o_da_outra_lista(X_novo, H_novo, X_outra_lista, H_outra_lista) ->
    (X_novo =:= X_outra_lista) and (H_novo =< H_outra_lista).


existe_outro_ponto_mais_alto_na_mesma_coluna(X_novo, H_novo, X_outra_lista, H_outra_lista, X_resultado) ->
    (ponto_na_mesma_coluna_do_resultado(X_novo, X_resultado)
     or ponto_na_mesma_coluna_e_mais_baixo_que_o_da_outra_lista(X_novo, H_novo, X_outra_lista, H_outra_lista)).


ponto_eh_redundante(H_novo, H_resultado) ->
    H_novo =:= H_resultado.


ponto_precisa_ser_elevado(X_novo, H_novo, X_outra_lista, H_outra_lista, Status_1 ,Status_2) ->
    (Status_1 =:= subiu) and (Status_2 =:= subiu) and (H_novo =< H_outra_lista) and (X_novo =/= X_outra_lista).


meu_status(Status_1, _Status_2, lista_1) ->
    Status_1;
meu_status(_Status_1, Status_2, lista_2) ->
    Status_2.

outro_status(Status_1, Status_2, Remetente) ->
    meu_status(Status_2, Status_1, Remetente).


ponto_sera_envolvido_pelo_resultado(X_novo, H_novo, X_outra_lista, H_resultado, Status_1, Status_2, Remetente) ->
    ((meu_status(Status_1, Status_2, Remetente) =:= desceu) 
     and (outro_status(Status_1, Status_2, Remetente) =:= subiu) 
     and (H_novo < H_resultado) and (X_novo =/= X_outra_lista)).


ponto_esta_obstruido(X_novo, H_novo, X_outra_lista, H_outra_lista, X_resultado, H_resultado, Status_1, Status_2, Remetente) ->
    (existe_outro_ponto_mais_alto_na_mesma_coluna(X_novo, H_novo, X_outra_lista, H_outra_lista, X_resultado)
     or ponto_eh_redundante(H_novo, H_resultado)
     or ponto_precisa_ser_elevado(X_novo, H_novo, X_outra_lista, H_outra_lista, Status_1 ,Status_2)
     or ponto_sera_envolvido_pelo_resultado(X_novo, H_novo, X_outra_lista, H_resultado, Status_1, Status_2, Remetente)).


	    
atualiza_resultado(X_novo, H_novo, X_outra_lista, H_outra_lista, Resultado = [{X_resultado, H_resultado} | _Resto], Status_1, Status_2, Remetente) ->
    case ponto_esta_obstruido(X_novo, H_novo, X_outra_lista, H_outra_lista, X_resultado, H_resultado, Status_1, Status_2, Remetente) of
	true ->
	    {Resultado, atualiza_status(Status_1, Status_2, Remetente)};
	false ->
	    Resultado_final = [{X_novo, H_novo} | Resultado],
	    {Resultado_final, atualiza_status(Status_1, Status_2, Remetente)}
    end.



silhueta_de_edificio({X_inicial, Altura, X_final}) ->
    [{X_inicial, Altura}, {X_final, 0}].


une_silhueta_se_nao_houver_redundancia([], {Resultado, _}) ->
    [{-1, -1} | Resultado_final] = lists:reverse(Resultado),
    Resultado_final;

une_silhueta_se_nao_houver_redundancia([{X_novo, H_novo} | Resto], {Resultado = [{_, H_resultado} | _], {Status_1, Status_2}}) ->
    case ponto_eh_redundante(H_novo, H_resultado) of
	true ->
	    une_silhueta_se_nao_houver_redundancia(Resto, {Resultado, {Status_1, Status_2}});
	false ->
	    une_silhueta_se_nao_houver_redundancia(Resto, {[{X_novo, H_novo} | Resultado], {Status_1, Status_2}})
    end.


uniao(Silhueta_1, Silhueta_2) ->
    uniao(Silhueta_1, Silhueta_2, {[{-1, -1}], {desceu, desceu}}).




uniao([], [], Resultado_e_status) ->
    une_silhueta_se_nao_houver_redundancia([], Resultado_e_status);
    
uniao(Lista_1, [], Resultado_e_status) ->
    une_silhueta_se_nao_houver_redundancia(Lista_1, Resultado_e_status); 

uniao([], Lista_2, Resultado_e_status) ->
    une_silhueta_se_nao_houver_redundancia(Lista_2, Resultado_e_status); 

uniao(Lista_1 = [{X_1, H_1} | Resto_1], Lista_2 = [{X_2, H_2} | Resto_2], {Resultado,  {Status_1, Status_2}}) ->
    case cmp(X_1, X_2) of
	primeiro_menor_ou_iguais ->
	    uniao(Resto_1, Lista_2, atualiza_resultado(X_1, H_1, X_2, H_2, Resultado, Status_1, Status_2, lista_1));
	segundo_menor ->
	    uniao(Lista_1, Resto_2, atualiza_resultado(X_2, H_2, X_1, H_1, Resultado, Status_1, Status_2, lista_2))
    end.


