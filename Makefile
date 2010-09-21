test: compile
	erl -noshell -s silhueta_tests test -s init stop

compile: silhueta.beam silhueta_tests.beam

silhueta.beam: silhueta.erl
	erlc silhueta.erl

silhueta_tests.beam: silhueta_tests.erl
	erlc silhueta_tests.erl

clean:
	rm -f *.beam