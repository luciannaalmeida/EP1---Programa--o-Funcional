-module(uniao_tests).
-include_lib("eunit/include/eunit.hrl").


uniao_caso_1_test() ->
    ?assertEqual([{0, 1}, {1, 0}, {2, 1}, {3, 0}], uniao:uniao([{0, 1}, {1, 0}], [{2, 1}, {3, 0}])),
    ?assertEqual([{0, 1}, {1, 0}, {2, 1}, {3, 0}], uniao:uniao([{2, 1}, {3, 0}], [{0, 1}, {1, 0}])).

uniao_caso_2_test() -> 
    ?assertEqual([{0, 1}, {1, 0}], uniao:uniao([{0, 1}, {1, 0}], [{0, 1}, {1, 0}])).

uniao_caso_3_test() ->
    ?assertEqual([{0, 1}, {2, 0}], uniao:uniao([{0, 1}, {2, 0}], [{1, 1}, {2, 0}])),
    ?assertEqual([{0, 1}, {2, 0}], uniao:uniao([{0, 1}, {1, 0}], [{0, 1}, {2, 0}])).

uniao_caso_4_test() ->
    ?assertEqual([{0, 1}, {3, 0}], uniao:uniao([{0, 1}, {3, 0}], [{1, 1}, {2, 0}])),
    ?assertEqual([{0, 1}, {3, 0}], uniao:uniao([{1, 1}, {2, 0}], [{0, 1}, {3, 0}])).

uniao_caso_5_test() ->
    ?assertEqual([{0, 2}, {1, 0}], uniao:uniao([{0, 1}, {1, 0}], [{0, 2}, {1, 0}])),
    ?assertEqual([{0, 2}, {1, 0}], uniao:uniao([{0, 2}, {1, 0}], [{0, 1}, {1, 0}])), 
    ?assertEqual([{0, 2}, {2, 0}], uniao:uniao([{0, 1}, {2, 0}], [{0, 2}, {2, 0}])).

uniao_caso_6_test() ->
    ?assertEqual([{0, 2}, {3, 0}], uniao:uniao([{0, 2}, {3, 0}], [{1, 1}, {2, 0}])),
    ?assertEqual([{0, 2}, {3, 0}], uniao:uniao([{1, 1}, {2, 0}], [{0, 2}, {3, 0}])).

uniao_caso_7_test() ->
    ?assertEqual([{0, 1}, {1, 2}, {2, 0}], uniao:uniao([{0, 1}, {1, 0}], [{1, 2}, {2, 0}])),
    ?assertEqual([{0, 1}, {1, 2}, {2, 0}], uniao:uniao([{1, 2}, {2, 0}], [{0, 1}, {1, 0}])).

uniao_caso_8_test() ->
    ?assertEqual([{0, 1}, {1, 0}, {2, 1}, {3, 0}, {4, 1}, {5, 0}], uniao:uniao([{0, 1}, {1, 0}, {4, 1}, {5, 0}], [{2, 1}, {3, 0}])),
    ?assertEqual([{0, 1}, {1, 0}, {2, 1}, {3, 0}, {4, 1}, {5, 0}], uniao:uniao([{2, 1}, {3, 0}], [{0, 1}, {1, 0}, {4, 1}, {5, 0}])).

uniao_caso_9_test() ->
    ?assertEqual([{0, 1}, {3, 0}], uniao:uniao([{0, 1}, {1, 0}, {2, 1}, {3, 0}], [{1, 1}, {2, 0}])),
    ?assertEqual([{0, 1}, {3, 0}], uniao:uniao([{1, 1}, {2, 0}], [{0, 1}, {1, 0}, {2, 1}, {3, 0}])).

uniao_caso_10_test() ->
    ?assertEqual([{0, 1}, {1, 2}, {2, 1}, {3, 0}], uniao:uniao([{0, 1}, {1, 0}, {2, 1}, {3, 0}], [{1, 2}, {2, 0}])),
    ?assertEqual([{0, 1}, {1, 2}, {2, 1}, {3, 0}], uniao:uniao([{1, 2}, {2, 0}], [{0, 1}, {1, 0}, {2, 1}, {3, 0}])).

uniao_caso_11_test() ->
    ?assertEqual([{0, 1}, {2, 0}], uniao:uniao([{0, 1}, {1, 0}], [{1, 1}, {2, 0}])).

uniao_caso_12_test() ->
    ?assertEqual([{0, 2}, {1, 1}, {2, 0}], uniao:uniao([{0, 2}, {1, 0}], [{0, 1}, {2, 0}])),
    ?assertEqual([{0, 2}, {1, 1}, {2, 0}], uniao:uniao([{0, 1}, {2, 0}], [{0, 2}, {1, 0}])).

uniao_caso_13_test() ->
    ?assertEqual([{0, 1}, {1, 2}, {2, 0}], uniao:uniao([{0, 1}, {2, 0}], [{1, 2}, {2, 0}])),
    ?assertEqual([{0, 1}, {1, 2}, {2, 0}], uniao:uniao([{0, 1}, {2, 0}], [{1, 2}, {2, 0}])).

uniao_caso_14_test() ->
    ?assertEqual([{0, 1}, {1, 2}, {2, 1}, {3, 0}], uniao:uniao([{1, 2}, {2, 0}], [{0, 1}, {3, 0}])),
    ?assertEqual([{0, 1}, {1, 2}, {2, 1}, {3, 0}], uniao:uniao([{0, 1}, {3, 0}], [{1, 2}, {2, 0}])).

uniao_caso_15_test() ->
    ?assertEqual([{0, 1}, {1, 2}, {3, 0}], uniao:uniao([{0, 1}, {2, 0}], [{1, 2}, {3, 0}])),
    ?assertEqual([{0, 1}, {1, 2}, {3, 0}], uniao:uniao([{1, 2}, {3, 0}], [{0, 1}, {2, 0}])).

uniao_caso_16_test() ->
    ?assertEqual([{0, 2}, {2, 1}, {3, 0}], uniao:uniao([{0, 2}, {2, 0}], [{1, 1}, {3, 0}])),
    ?assertEqual([{0, 2}, {2, 1}, {3, 0}], uniao:uniao([{1, 1}, {3, 0}], [{0, 2}, {2, 0}])).

uniao_caso_17_test() ->
    ?assertEqual([{0, 2}, {2, 0}], uniao:uniao([{0, 2}, {2, 0}], [{0, 1}, {1, 0}])),
    ?assertEqual([{0, 2}, {2, 0}], uniao:uniao([{0, 1}, {1, 0}], [{0, 2}, {2, 0}])).

uniao_caso_18_test() ->
    ?assertEqual([{0, 1}, {1, 2}, {2, 1}, {3, 0}], uniao:uniao([{0, 1}, {1, 2}, {2, 0}], [{1, 1}, {3, 0}])),
    ?assertEqual([{0, 1}, {1, 2}, {2, 1}, {3, 0}], uniao:uniao([{1, 1}, {3, 0}], [{0, 1}, {1, 2}, {2, 0}])).

uniao_caso_19_test() ->
    ?assertEqual([{0, 1}, {1, 2}, {2, 0}], uniao:uniao([{1, 1}, {2, 0}], [{0, 1}, {1, 2}, {2, 0}])),
    ?assertEqual([{0, 1}, {1, 2}, {2, 0}], uniao:uniao([{0, 1}, {1, 2}, {2, 0}], [{1, 1}, {2, 0}])).

uniao_caso_20_test() ->
    ?assertEqual([{0, 2}, {1, 1}, {2, 0}], uniao:uniao([{0, 1}, {1, 0}], [{0, 2}, {1, 1}, {2, 0}])),
    ?assertEqual([{0, 2}, {1, 1}, {2, 0}], uniao:uniao([{0, 2}, {1, 1}, {2, 0}], [{0, 1}, {1, 0}])).

uniao_caso_21_test() ->
    ?assertEqual([{0, 2}, {1, 3}, {2, 0}], uniao:uniao([{0, 1}, {1, 3}, {2, 0}], [{0, 2}, {1, 0}])),
    ?assertEqual([{0, 2}, {1, 3}, {2, 0}], uniao:uniao([{0, 2}, {1, 0}], [{0, 1}, {1, 3}, {2, 0}])).

uniao_caso_22_test() ->
    ?assertEqual([{0, 1}, {1, 2}, {2, 3}, {3, 2}, {4, 1}, {5, 0}], uniao:uniao([{0, 1}, {1, 2}, {2, 3}, {3, 2}, {4, 1}, {5, 0}], [{1, 1}, {2, 2}, {3, 1}, {4, 0}])).

uniao_caso_23_test() ->
    ?assertEqual([{0, 2}, {1, 3}, {2, 2}, {3, 3}, {4, 2}, {5, 1}, {6, 3}, {7, 2}, {8, 3}, {9, 1}, {10, 0}], uniao:uniao([{0, 2}, {5, 1}, {10, 0}], [{1, 3}, {2, 1}, {3, 3}, {4, 0}, {6, 3}, {7, 2}, {8, 3}, {9, 0}])).

uniao_caso_24_test() ->
    ?assertEqual([{0, 2}, {1, 1}, {2, 2}, {5, 1}, {6, 2}, {7, 0}], uniao:uniao([{0, 2}, {1, 1}, {3, 2}, {4, 1}, {6, 2}, {7, 0}], [{2, 2}, {5, 0}])).

uniao_caso_25_test() ->
    ?assertEqual([{0, 1}, {1, 2}, {4, 1}, {5, 0}], uniao:uniao([{0, 1}, {2, 2}, {3, 1}, {5, 0}], [{1, 2}, {4, 0}])).

uniao_caso_26_test() ->
    ?assertEqual([{0, 2}, {3, 1}, {4, 0}], uniao:uniao([{1, 2}, {2, 1}, {4, 0}], [{0, 2}, {3, 0}])).

uniao_caso_27_test() ->
    ?assertEqual([{0, 2}, {2, 1}, {3, 0}], uniao:uniao([{0, 2}, {1, 1}, {3, 0}], [{0, 2}, {2, 0}])).

uniao_caso_28_test() ->
    ?assertEqual([{0, 3}, {2, 2}, {3, 0}], uniao:uniao([{0, 3}, {2, 0}], [{0, 1}, {1, 2}, {3, 0}])).

uniao_caso_29_test() ->
    ?assertEqual([{0, 1}, {1, 2}, {2, 1}, {3, 2}, {4, 1}, {5, 0}], uniao:uniao([{0, 1}, {5, 0}], [{1, 2}, {2, 0}, {3, 2}, {4, 0}])).

uniao_caso_30_test() ->
    ?assertEqual([{0, 1}, {1, 2}, {2, 1}, {3, 3}, {6, 0}], uniao:uniao([{0, 1}, {3, 3}, {6, 0}], [{1, 2}, {2, 0}, {4, 2}, {5, 0
}])).

exemplo_do_enunciado_test() ->
    ?assertEqual([{3, 6}, {7, 4}, {8, 9}, {9, 13}, {14, 6}, {16, 17}, {19, 16}, {20, 14}, {22, 11}, {23, 9}, {27,0}],
		 uniao:uniao([{3, 6}, {7, 2}, {8, 9}, {12, 4}, {16, 17}, {19, 14}, {22, 9}, {27, 0}], 
			     [{5, 4}, {9, 13}, {14, 6}, {18, 16}, {20, 11}, {23, 5}, {25, 0}])).

exemplo_do_enunciado_caso_1_test() ->
    ?assertEqual([{3, 6}, {7, 4}, {8, 9}, {9, 13}, {14, 0}],
		 uniao:uniao([{3, 6}, {7, 2}, {8, 9}, {12, 0}],
			     [{5, 4}, {9, 13}, {14, 0}])).
