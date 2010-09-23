-module(uniao).
-export([uniao/2]).

uniao(Silhueta_1, Silhueta_2) ->
    uniao(Silhueta_1, Silhueta_2, {[{-1, -1}], {-1, -1}}).

uniao([], [], Resultado_e_ultimas_Hs) ->
    une_silhueta_se_nao_houver_redundancia([], Resultado_e_ultimas_Hs);
uniao(Lista_1, [], Resultado_e_ultimas_Hs) ->
    une_silhueta_se_nao_houver_redundancia(Lista_1, Resultado_e_ultimas_Hs); 
uniao([], Lista_2, Resultado_e_ultimas_Hs) ->
    une_silhueta_se_nao_houver_redundancia(Lista_2, Resultado_e_ultimas_Hs); 
uniao(Lista_1 = [{X_1, H_1} | Resto_1], Lista_2 = [{X_2, H_2} | Resto_2], Resultado_e_ultimas_Hs) ->
    case X_1 =< X_2 of
	true ->
	    uniao(Resto_1, Lista_2, atualiza_resultado(X_1, H_1, X_2, H_2, Resultado_e_ultimas_Hs, lista_1));
	false ->
	    uniao(Lista_1, Resto_2, atualiza_resultado(X_2, H_2, X_1, H_1, Resultado_e_ultimas_Hs, lista_2))
    end.



une_silhueta_se_nao_houver_redundancia([], {Resultado, _}) ->
    [{-1, -1} | Resultado_final] = lists:reverse(Resultado),
    Resultado_final;
une_silhueta_se_nao_houver_redundancia([{X_novo, H_novo} | Resto], {Resultado = [{_, H_resultado} | _], Ultimas_Hs}) ->
    case ponto_eh_redundante(H_novo, H_resultado) of
	true ->
	    une_silhueta_se_nao_houver_redundancia(Resto, {Resultado, Ultimas_Hs});
	false ->
	    une_silhueta_se_nao_houver_redundancia(Resto, {[{X_novo, H_novo} | Resultado], Ultimas_Hs})
    end.



atualiza_resultado(X_novo, H_novo, X_outra_lista, H_outra_lista, Resultado_e_ultimas_Hs, Remetente) ->
    {Resultado, {Ultimo_H_1, Ultimo_H_2}} = Resultado_e_ultimas_Hs,
    [{X_resultado, H_resultado} | _Resto] = Resultado,
    Ultimo_H_outra_lista = ultimo_H_da_outra_lista(Ultimo_H_1, Ultimo_H_2, Remetente),
    H_definitivo = eleva_ponto_se_necessario(X_novo, H_novo, X_outra_lista, Ultimo_H_1, Ultimo_H_2, Remetente, Ultimo_H_outra_lista),
    case ponto_esta_obstruido(X_novo, H_definitivo, X_outra_lista, H_outra_lista, X_resultado, H_resultado, Ultimo_H_outra_lista) of
	true ->
	    Resultado_final = Resultado;
	false ->
	    Resultado_final = [{X_novo, H_definitivo} | Resultado]
    end,
    Ultimos_Hs_atualizadas = atualiza_ultimas_alturas(Ultimo_H_1, Ultimo_H_2, H_novo, Remetente),
    {Resultado_final, Ultimos_Hs_atualizadas}.



ultimo_H_da_lista(Ultimo_H_1, _Ultimo_H_2, lista_1) ->
    Ultimo_H_1;
ultimo_H_da_lista(_Ultimo_H_1, Ultimo_H_2, lista_2) ->
    Ultimo_H_2.
ultimo_H_da_outra_lista(Ultimo_H_1, Ultimo_H_2, Remetente) ->
    ultimo_H_da_lista(Ultimo_H_2, Ultimo_H_1, Remetente).


atualiza_ultimas_alturas(_Ultimo_H_1, Ultimo_H_2, H_definitivo, lista_1) ->
    {H_definitivo, Ultimo_H_2};
atualiza_ultimas_alturas(Ultimo_H_1, _Ultimo_H_2, H_definitivo, lista_2) ->
    {Ultimo_H_1, H_definitivo}.




eleva_ponto_se_necessario(X_novo, H_novo, X_outra_lista, Ultimo_H_1, Ultimo_H_2, Remetente, H_candidato) ->
    case ponto_precisa_ser_elevado(X_novo, H_novo, X_outra_lista, Ultimo_H_1, Ultimo_H_2, Remetente, H_candidato) of
	true ->
	    H_candidato;
	false ->
	    H_novo
    end.

ponto_precisa_ser_elevado(X_novo, H_novo, X_outra_lista, Ultimo_H_1, Ultimo_H_2, Remetente, H_candidato) ->
    (silhuetas_se_cruzaram(Ultimo_H_1, Ultimo_H_2, Remetente)
     and (X_novo =/= X_outra_lista)
     and (H_novo < H_candidato)).

silhuetas_se_cruzaram(Ultimo_H_1, Ultimo_H_2, Remetente) ->
    ultimo_H_da_lista(Ultimo_H_1, Ultimo_H_2, Remetente) >= ultimo_H_da_outra_lista(Ultimo_H_1, Ultimo_H_2, Remetente).



ponto_esta_obstruido(X_novo, H_novo, X_outra_lista, H_outra_lista, X_resultado, H_resultado, Ultimo_H_outra_lista) ->
    (existe_outro_ponto_mais_alto_na_mesma_coluna(X_novo, H_novo, X_outra_lista, H_outra_lista, X_resultado)
     or ponto_eh_redundante(H_novo, H_resultado)
     or ponto_sera_envolvido_pelo_resultado(X_novo, H_novo, X_outra_lista, H_resultado, Ultimo_H_outra_lista)).

existe_outro_ponto_mais_alto_na_mesma_coluna(X_novo, H_novo, X_outra_lista, H_outra_lista, X_resultado) ->
    (ponto_na_mesma_coluna_do_resultado(X_novo, X_resultado)
     or ponto_na_mesma_coluna_e_mais_baixo_que_o_da_outra_lista(X_novo, H_novo, X_outra_lista, H_outra_lista)).

ponto_eh_redundante(H_novo, H_resultado) ->
    H_novo =:= H_resultado.

ponto_sera_envolvido_pelo_resultado(X_novo, H_novo, X_outra_lista, H_resultado, Ultimo_H_outra_lista) ->
    ((H_novo < H_resultado) and (X_novo < X_outra_lista) and (H_novo < Ultimo_H_outra_lista)).

ponto_na_mesma_coluna_do_resultado(X_novo, X_resultado) ->
    X_novo =:= X_resultado.

ponto_na_mesma_coluna_e_mais_baixo_que_o_da_outra_lista(X_novo, H_novo, X_outra_lista, H_outra_lista) ->
    (X_novo =:= X_outra_lista) and (H_novo =< H_outra_lista).
