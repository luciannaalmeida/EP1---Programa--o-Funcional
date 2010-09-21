-module(silhueta_tests).
-include_lib("eunit/include/eunit.hrl").

silhueta_de_edificio_test() ->
    ?assertEqual([{0, 1}, {3, 0}], silhueta:silhueta_de_edificio({0, 1, 3})),
    ?assertEqual([{1, 2}, {4, 0}], silhueta:silhueta_de_edificio({1, 2, 4})).

% uniao_test
uniao_caso_1_test() ->
    ?assertEqual([{0, 1}, {1, 0}, {2, 1}, {3, 0}], silhueta:uniao([{0, 1}, {1, 0}], [{2, 1}, {3, 0}])),
    ?assertEqual([{0, 1}, {1, 0}, {2, 1}, {3, 0}], silhueta:uniao([{2, 1}, {3, 0}], [{0, 1}, {1, 0}])).

uniao_caso_2_test() -> 
    ?assertEqual([{0, 1}, {1, 0}], silhueta:uniao([{0, 1}, {1, 0}], [{0, 1}, {1, 0}])).

uniao_caso_3_test() ->
    ?assertEqual([{0, 1}, {2, 0}], silhueta:uniao([{0, 1}, {2, 0}], [{1, 1}, {2, 0}])),
    ?assertEqual([{0, 1}, {2, 0}], silhueta:uniao([{0, 1}, {1, 0}], [{0, 1}, {2, 0}])).

uniao_caso_4_test() ->
    ?assertEqual([{0, 1}, {3, 0}], silhueta:uniao([{0, 1}, {3, 0}], [{1, 1}, {2, 0}])).

uniao_caso_5_test() ->
    ?assertEqual([{0, 2}, {1, 0}], silhueta:uniao([{0, 1}, {1, 0}], [{0, 2}, {1, 0}])),
    ?assertEqual([{0, 2}, {1, 0}], silhueta:uniao([{0, 2}, {1, 0}], [{0, 1}, {1, 0}])), 
    ?assertEqual([{0, 2}, {2, 0}], silhueta:uniao([{0, 1}, {2, 0}], [{0, 2}, {2, 0}])).

uniao_caso_6_test() ->
    ?assertEqual([{0, 2}, {3, 0}], silhueta:uniao([{0, 2}, {3, 0}], [{1, 1}, {2, 0}])),
    ?assertEqual([{0, 2}, {3, 0}], silhueta:uniao([{1, 1}, {2, 0}], [{0, 2}, {3, 0}])).

uniao_caso_7_test() ->
    ?assertEqual([{0, 1}, {1, 2}, {2, 0}], silhueta:uniao([{0, 1}, {1, 0}], [{1, 2}, {2, 0}])),
    ?assertEqual([{0, 1}, {1, 2}, {2, 0}], silhueta:uniao([{1, 2}, {2, 0}], [{0, 1}, {1, 0}])).

uniao_caso_8_test() ->
    ?assertEqual([{0, 1}, {1, 0}, {2, 1}, {3, 0}, {4, 1}, {5, 0}], silhueta:uniao([{0, 1}, {1, 0}, {4, 1}, {5, 0}], [{2, 1}, {3, 0}])).

uniao_caso_9_test() ->
    ?assertEqual([{0, 1}, {3, 0}], silhueta:uniao([{0, 1}, {1, 0}, {2, 1}, {3, 0}], [{1, 1}, {2, 0}])).

uniao_caso_10_test() ->
    ?assertEqual([{0, 1}, {1, 2}, {2, 1}, {3, 0}], silhueta:uniao([{0, 1}, {1, 0}, {2, 1}, {3, 0}], [{1, 2}, {2, 0}])).

uniao_caso_11_test() ->
    ?assertEqual([{0, 1}, {2, 0}], silhueta:uniao([{0, 1}, {1, 0}], [{1, 1}, {2, 0}])).

%uniao_caso_12_test() ->
%    ?assertEqual([{0, 2}, {1, 1}, {2, 0}], silhueta:uniao([{0, 2}, {1, 0}], [{0, 1}, {2, 0}])).
