-module(silhueta_tests).
-include_lib("eunit/include/eunit.hrl").

silhueta_de_edificio_test() ->
    ?assertEqual([0, 1, 3, 0], silhueta:silhueta_de_edificio({0, 1, 3})),
    ?assertEqual([1, 2, 4, 0], silhueta:silhueta_de_edificio({1, 2, 4})).

uniao_test() ->
   %caso 1
    ?assertEqual([0, 1, 1, 0, 2, 1, 3, 0], silhueta:uniao([0, 1, 1, 0], [2, 1, 3, 0])),
    ?assertEqual([0, 1, 1, 0, 2, 1, 3, 0], silhueta:uniao([2, 1, 3, 0], [0, 1, 1, 0])),
   %caso 2 
    ?assertEqual([0, 1, 1, 0], silhueta:uniao([0, 1, 1, 0], [0, 1, 1, 0])),
   %caso 3
    ?assertEqual([0, 1, 2, 0], silhueta:uniao([0, 1, 2, 0], [1, 1, 2, 0])),
    ?assertEqual([0, 1, 2, 0], silhueta:uniao([0, 1, 1, 0], [0, 1, 2, 0])),
   %caso 4
    ?assertEqual([0, 1, 3, 0], silhueta:uniao([0, 1, 3, 0], [1, 1, 2, 0])),
   %caso 5
    ?assertEqual([0, 2, 1, 0], silhueta:uniao([0, 1, 1, 0], [0, 2, 1, 0])),
    ?assertEqual([0, 2, 1, 0], silhueta:uniao([0, 2, 1, 0], [0, 1, 1, 0])), 
    ?assertEqual([0, 2, 2, 0], silhueta:uniao([0, 1, 2, 0], [0, 2, 2, 0])),
   %caso 6
    ?assertEqual([0, 2, 3, 0], silhueta:uniao([0, 2, 3, 0], [1, 1, 2, 0])),
    ?assertEqual([0, 2, 3, 0], silhueta:uniao([1, 1, 2, 0], [0, 2, 3, 0])),
   %caso 7
    ?assertEqual([0, 1, 1, 2, 2, 0], silhueta:uniao([0, 1, 1, 0], [1, 2, 2, 0])),
    ?assertEqual([0, 1, 1, 2, 2, 0], silhueta:uniao([1, 2, 2, 0], [0, 1, 1, 0])),
   %caso 8
    ?assertEqual([0, 1, 1, 0, 2, 1, 3, 0, 4, 1, 5, 0], silhueta:uniao([0, 1, 1, 0, 4, 1, 5, 0], [2, 1, 3, 0])),
   %caso 9
    ?assertEqual([0, 1, 3, 0], silhueta:uniao([0, 1, 1, 0, 2, 1, 3, 0], [1, 1, 2, 0])),
   %caso 10
    ?assertEqual([0, 1, 1, 2, 2, 1, 3, 0], silhueta:uniao([0, 1, 1, 0, 2, 1, 3, 0], [1, 2, 2, 0])).

 %   ?assertEqual([0, 2, 1, 1, 2, 0], silhueta:uniao([0, 2, 1, 0], [0, 1, 2, 0])).
