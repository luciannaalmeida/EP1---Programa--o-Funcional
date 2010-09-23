-module(silhueta).
-import(uniao, [uniao/2]).
-compile(export_all).


silhueta_do_edificio({X_inicial, Altura, X_final}) ->
    [{X_inicial, Altura}, {X_final, 0}].


algoritmo1(Lista_de_edificios) ->
    algoritmo1(Lista_de_edificios, []).

algoritmo1([], Resultado) ->
    Resultado;
algoritmo1([Edificio | Resto], Resultado) ->
    algoritmo1(Resto, uniao:uniao(silhueta_do_edificio(Edificio), Resultado)).
