-module(silhueta_tests).
-include_lib("eunit/include/eunit.hrl").

silhueta_de_edificio_test() ->
    ?assertEqual([{0, 1}, {3, 0}], silhueta:silhueta_de_edificio({0, 1, 3})),
    ?assertEqual([{1, 2}, {4, 0}], silhueta:silhueta_de_edificio({1, 2, 4})).
