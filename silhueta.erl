-module(silhueta).
-compile(export_all).

cmp(A, B) ->
    case A < B of
	true ->
	    primeiro_menor;
	false ->
	    case A > B of
		true ->
		    segundo_menor;
		false ->
		    iguais
	    end
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


resultado_com_mesma_altura_do_novo_trecho(H_novo, H_resultado) ->
    H_novo =:= H_resultado.
    

silhuetas_com_mesma_altura_e_abertas(X_novo, H_novo, X_outra_lista, H_outra_lista, Status_1, Status_2) ->
    (((Status_1 =:= subiu) and (Status_2 =:= subiu))
     and (H_novo =:= H_outra_lista)
     and (X_novo =/= X_outra_lista)).


novo_trecho_mais_baixo_e_com_ambas_silhuetas_abertas(H_novo, H_resultado, Status_1, Status_2, Remetente) ->
    case Remetente of
	lista_1 ->
	    (Status_2 =:= subiu) and (H_resultado > H_novo);
	lista_2 ->
	    (Status_1 =:= subiu) and (H_resultado > H_novo);
	ambos ->
	    false
    end.


ponto_deve_ser_ignorado(X_novo, H_novo, X_outra_lista, H_outra_lista, H_resultado, Status_1, Status_2, Remetente) ->
    (resultado_com_mesma_altura_do_novo_trecho(H_novo, H_resultado)
     or silhuetas_com_mesma_altura_e_abertas(X_novo, H_novo, X_outra_lista, H_outra_lista, Status_1, Status_2)
     or novo_trecho_mais_baixo_e_com_ambas_silhuetas_abertas(H_novo, H_resultado, Status_1, Status_2, Remetente)).

	    
atualiza_resultado(X_novo, H_novo, X_outra_lista, H_outra_lista, Resultado = [{_, H_resultado} | _Resto], Status_1, Status_2, Remetente) ->
    case ponto_deve_ser_ignorado(X_novo, H_novo, X_outra_lista, H_outra_lista, H_resultado, Status_1, Status_2, Remetente) of
	true ->
	    {Resultado, atualiza_status(Status_1, Status_2, Remetente)};
	false ->
	    Resultado_final = [{X_novo, H_novo} | Resultado],
	    {Resultado_final, atualiza_status(Status_1, Status_2, Remetente)}
    end.




silhueta_de_edificio({X_inicial, Altura, X_final}) ->
    [{X_inicial, Altura}, {X_final, 0}].



uniao(Silhueta_1, Silhueta_2) ->
    uniao(Silhueta_1, Silhueta_2, {[{-1, -1}], {desceu, desceu}}).




uniao([], [], {Resultado, {_, _}}) ->
    [{-1, -1} | Resultado_final] = lists:reverse(Resultado),
    Resultado_final;

uniao([{X_1, H_1} | Resto_1], [], {Resultado, {Status_1, Status_2}}) ->
    uniao(Resto_1, [], {[{X_1, H_1} | Resultado], {Status_1, Status_2}});

uniao([], [{X_2, H_2} | Resto_2], {Resultado, {Status_1, Status_2}}) ->
    uniao([], Resto_2, {[{X_2, H_2} | Resultado], {Status_1, Status_2}});

uniao(Lista_1 = [{X_1, H_1} | Resto_1], Lista_2 = [{X_2, H_2} | Resto_2], {Resultado,  {Status_1, Status_2}}) ->
    case cmp(X_1, X_2) of
	primeiro_menor ->
	    uniao(Resto_1, Lista_2, atualiza_resultado(X_1, H_1, X_2, H_2, Resultado, Status_1, Status_2, lista_1));
	segundo_menor ->
	    uniao(Lista_1, Resto_2, atualiza_resultado(X_2, H_2, X_1, H_1, Resultado, Status_1, Status_2, lista_2));
	iguais ->
	    case H_1 > H_2 of
		true ->
		    uniao(Resto_1, Resto_2, atualiza_resultado(X_1, H_1, X_2, H_2, Resultado, Status_1, Status_2, ambos));
		false ->
		    uniao(Resto_1, Resto_2, atualiza_resultado(X_2, H_2, X_1, H_1, Resultado, Status_1, Status_2, ambos))
	    end
    end.


