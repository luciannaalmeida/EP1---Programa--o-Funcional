-module(uniao).
-compile(export_all).

cmp(A, B) ->
    case A =< B of
	true ->
	    primeiro_menor_ou_iguais;
	false ->
	    segundo_menor
    end.



verifica_e_atualiza_fechamento_de_silhueta(0) ->
    fechada;
verifica_e_atualiza_fechamento_de_silhueta(_) ->
    aberta.


atualiza_status(H_novo, _Status_1, Status_2, lista_1) ->
    {verifica_e_atualiza_fechamento_de_silhueta(H_novo), Status_2};
atualiza_status(H_novo, Status_1, _Status_2, lista_2) ->
    {Status_1, verifica_e_atualiza_fechamento_de_silhueta(H_novo)}.


meu_status(Status_1, _Status_2, lista_1) ->
    Status_1;
meu_status(_Status_1, Status_2, lista_2) ->
    Status_2.

outro_status(Status_1, Status_2, Remetente) ->
    meu_status(Status_2, Status_1, Remetente).


ponto_na_mesma_coluna_e_mais_baixo_que_o_da_outra_lista(X_novo, H_novo, X_outra_lista, H_outra_lista) ->
    (X_novo =:= X_outra_lista) and (H_novo =< H_outra_lista).


ponto_na_mesma_coluna_do_resultado(X_novo, X_resultado) ->
    X_novo =:= X_resultado.


ponto_sera_envolvido_pelo_resultado(X_novo, H_novo, X_outra_lista, H_resultado, Ultimo_H_outra_lista, Status_1, Status_2, Remetente) ->
    ((outro_status(Status_1, Status_2, Remetente) =:= aberta) 
     and (H_novo < H_resultado) and (X_novo < X_outra_lista) and (H_novo < Ultimo_H_outra_lista)).


ponto_eh_redundante(H_novo, H_resultado) ->
    H_novo =:= H_resultado.


existe_outro_ponto_mais_alto_na_mesma_coluna(X_novo, H_novo, X_outra_lista, H_outra_lista, X_resultado) ->
    (ponto_na_mesma_coluna_do_resultado(X_novo, X_resultado)
     or ponto_na_mesma_coluna_e_mais_baixo_que_o_da_outra_lista(X_novo, H_novo, X_outra_lista, H_outra_lista)).

ponto_esta_obstruido(X_novo, H_novo, X_outra_lista, H_outra_lista, X_resultado, H_resultado, Ultimo_H_outra_lista, Status_1, Status_2, Remetente) ->
    (existe_outro_ponto_mais_alto_na_mesma_coluna(X_novo, H_novo, X_outra_lista, H_outra_lista, X_resultado)
     or ponto_eh_redundante(H_novo, H_resultado)
     or ponto_sera_envolvido_pelo_resultado(X_novo, H_novo, X_outra_lista, H_resultado, Ultimo_H_outra_lista, Status_1, Status_2, Remetente)).


silhuetas_se_cruzaram(Ultimo_H_1, Ultimo_H_2, Remetente) ->
    define_ultimo_H_da_lista(Ultimo_H_1, Ultimo_H_2, Remetente) >= define_ultimo_H_da_outra_lista(Ultimo_H_1, Ultimo_H_2, Remetente).

ponto_precisa_ser_elevado(X_novo, H_novo, X_outra_lista, Ultimo_H_1, Ultimo_H_2, Status_1 ,Status_2, H_candidato, Remetente) ->
    ((Status_1 =:= aberta) and (Status_2 =:= aberta) 
     and silhuetas_se_cruzaram(Ultimo_H_1, Ultimo_H_2, Remetente)
     and (X_novo =/= X_outra_lista)
     and (H_novo < H_candidato)).


eleva_ponto_se_necessario(X_novo, H_novo, X_outra_lista, Ultimo_H_1, Ultimo_H_2, Status_1 ,Status_2, H_candidato, Remetente) ->
    case ponto_precisa_ser_elevado(X_novo, H_novo, X_outra_lista, Ultimo_H_1, Ultimo_H_2, Status_1 ,Status_2, H_candidato, Remetente) of
	true ->
	    H_candidato;
	false ->
	    H_novo
    end.


define_ultimo_H_da_lista(Ultimo_H_1, _Ultimo_H_2, lista_1) ->
    Ultimo_H_1;
define_ultimo_H_da_lista(_Ultimo_H_1, Ultimo_H_2, lista_2) ->
    Ultimo_H_2.

define_ultimo_H_da_outra_lista(Ultimo_H_1, Ultimo_H_2, Remetente) ->
    define_ultimo_H_da_lista(Ultimo_H_2, Ultimo_H_1, Remetente).

define_H_candidato(Ultimo_H_1, Ultimo_H_2, Remetente) ->
    define_ultimo_H_da_outra_lista(Ultimo_H_1, Ultimo_H_2, Remetente).


atualiza_ultimas_alturas(_Ultimo_H_1, Ultimo_H_2, H_definitivo, lista_1) ->
    {H_definitivo, Ultimo_H_2};
atualiza_ultimas_alturas(Ultimo_H_1, _Ultimo_H_2, H_definitivo, lista_2) ->
    {Ultimo_H_1, H_definitivo}.

	    
atualiza_resultado(X_novo, H_novo, X_outra_lista, H_outra_lista, Resultado_e_status, Remetente) ->
    {Resultado, {Status_1, Status_2}, {Ultimo_H_1, Ultimo_H_2}} = Resultado_e_status,
    [{X_resultado, H_resultado} | _Resto] = Resultado,
    Status_atualizados = atualiza_status(H_novo, Status_1, Status_2, Remetente),
    H_candidato = define_H_candidato(Ultimo_H_1, Ultimo_H_2, Remetente),
    H_definitivo = eleva_ponto_se_necessario(X_novo, H_novo, X_outra_lista, Ultimo_H_1, Ultimo_H_2, Status_1 ,Status_2, H_candidato, Remetente),
    Ultimo_H_outra_lista = define_ultimo_H_da_outra_lista(Ultimo_H_1, Ultimo_H_2, Remetente),
    Ultimos_Hs_atualizadas = atualiza_ultimas_alturas(Ultimo_H_1, Ultimo_H_2, H_novo, Remetente),
    case ponto_esta_obstruido(X_novo, H_definitivo, X_outra_lista, H_outra_lista, X_resultado, H_resultado, Ultimo_H_outra_lista, Status_1, Status_2, Remetente) of
	true ->
	    {Resultado, Status_atualizados, Ultimos_Hs_atualizadas};
	false ->
	    Resultado_final = [{X_novo, H_definitivo} | Resultado],
	    {Resultado_final, Status_atualizados, Ultimos_Hs_atualizadas}
    end.


une_silhueta_se_nao_houver_redundancia([], {Resultado, _, _}) ->
    [{-1, -1} | Resultado_final] = lists:reverse(Resultado),
    Resultado_final;

une_silhueta_se_nao_houver_redundancia([{X_novo, H_novo} | Resto], {Resultado = [{_, H_resultado} | _], Status, Ultimas_Hs}) ->
    case ponto_eh_redundante(H_novo, H_resultado) of
	true ->
	    une_silhueta_se_nao_houver_redundancia(Resto, {Resultado, Status, Ultimas_Hs});
	false ->
	    une_silhueta_se_nao_houver_redundancia(Resto, {[{X_novo, H_novo} | Resultado], Status, Ultimas_Hs})
    end.


uniao(Silhueta_1, Silhueta_2) ->
    uniao(Silhueta_1, Silhueta_2, {[{-1, -1}], {fechada, fechada}, {-1, -1}}).


uniao([], [], Resultado_e_status) ->
    une_silhueta_se_nao_houver_redundancia([], Resultado_e_status);
    
uniao(Lista_1, [], Resultado_e_status) ->
    une_silhueta_se_nao_houver_redundancia(Lista_1, Resultado_e_status); 

uniao([], Lista_2, Resultado_e_status) ->
    une_silhueta_se_nao_houver_redundancia(Lista_2, Resultado_e_status); 

uniao(Lista_1 = [{X_1, H_1} | Resto_1], Lista_2 = [{X_2, H_2} | Resto_2], Resultado_e_status) ->
    case cmp(X_1, X_2) of
	primeiro_menor_ou_iguais ->
	    uniao(Resto_1, Lista_2, atualiza_resultado(X_1, H_1, X_2, H_2, Resultado_e_status, lista_1));
	segundo_menor ->
	    uniao(Lista_1, Resto_2, atualiza_resultado(X_2, H_2, X_1, H_1, Resultado_e_status, lista_2))
    end.


