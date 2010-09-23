-module(silhueta_tests).
-include_lib("eunit/include/eunit.hrl").

silhueta_do_edificio_test() ->
    ?assertEqual([{0, 1}, {3, 0}], silhueta:silhueta_do_edificio({0, 1, 3})),
    ?assertEqual([{1, 2}, {4, 0}], silhueta:silhueta_do_edificio({1, 2, 4})).


algoritmo_1_caso_1_test() ->
    ?assertEqual([{0, 1}, {1, 0}, {2, 1}, {3, 0}], 
		 silhueta:algoritmo1([{0, 1, 1},
				       {2, 1, 3}])).

algoritimo_1_caso_8_test() ->
    ?assertEqual([{0, 1}, {1, 0}, {2, 1}, {3, 0}, {4, 1}, {5, 0}],
		 silhueta:algoritmo1([{0, 1, 1},
				       {4, 1, 5},
				       {2, 1, 3}])).
    


algoritmo_2_caso_1_test() ->
    ?assertEqual([{0, 1}, {1, 0}, {2, 1}, {3, 0}], 
		 silhueta:algoritmo2([{0, 1, 1},
				       {2, 1, 3}])).

algoritimo_2_caso_8_test() ->
    ?assertEqual([{0, 1}, {1, 0}, {2, 1}, {3, 0}, {4, 1}, {5, 0}],
		 silhueta:algoritmo2([{0, 1, 1},
				       {4, 1, 5},
				       {2, 1, 3}])).
