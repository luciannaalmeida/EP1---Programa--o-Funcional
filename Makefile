test: compile
	erl -noshell -s uniao_tests test -s init stop
	erl -noshell -s silhueta_tests test -s init stop

compile: silhueta.beam silhueta_tests.beam uniao.beam uniao_tests.beam matrix.beam imagem.beam

silhueta.beam: silhueta.erl
	erlc silhueta.erl

silhueta_tests.beam: silhueta_tests.erl
	erlc silhueta_tests.erl

uniao.beam: uniao.erl
	erlc uniao.erl

uniao_tests.beam: uniao_tests.erl
	erlc uniao_tests.erl

matrix.beam: matrix.erl
	erlc matrix.erl

imagem.beam: imagem.erl
	erlc imagem.erl

clean:
	rm -f *.beam