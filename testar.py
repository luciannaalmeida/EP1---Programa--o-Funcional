import os
import sys

def get_result(f):
    res = ''
    lines = f.readlines()
    for l in range(len(lines)-1, -1, -1):
        res = lines[l] + res
        if len(lines[l].split()) == 1:
            break;
    return res

alg = '1'
if len(sys.argv) > 1:
    alg = sys.argv[1]

testes = os.listdir('testes')
testes.sort()

for f in testes:
    os.system(r'erl -noshell -s silhueta main ' + alg + ' testes/' + f + ' ttt.test > /dev/null')
    #print f
    with open('testes/' + f) as in_file:
        with open('ttt.test') as test_result_file:
            test_result = get_result(test_result_file)
            correct_answer = get_result(in_file)
            if test_result == correct_answer: print f, ':OK'
            else: print f, ':FALHA!!!!!\n', test_result, correct_answer
            
            os.system('rm ttt.test')
