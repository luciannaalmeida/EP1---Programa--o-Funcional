-module(silhueta).
-import(uniao, [uniao/2]).
-compile(export_all).


silhueta_de_edificio({X_inicial, Altura, X_final}) ->
    [{X_inicial, Altura}, {X_final, 0}].


%uniao(Silhueta_1, Silhueta_2)


