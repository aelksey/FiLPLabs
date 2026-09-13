% --- Автотест ---

check_test(TestName, Goal) :-
    (   Goal -> 
        format('~w: [OK]~n', [TestName])
    ;   format('~w: [FAIL]~n', [TestName])
    ).

run_test :-
    writeln('--- ЗАПУСК ТЕСТОВ ---'),
    check_test('1. Брат (Дмитрий для Ольги)', brother(dmitriy, olga)),
    check_test('2. Дедушка (Сергей для Николая)', grandfather(sergey, nikolai)),
    check_test('3. Двоюродный брат (Николай для Софьи)', cousin_brother(nikolai, sofya)),
    check_test('4. Тётя (Ольга для Николая)', aunt(olga, nikolai)),
    check_test('5. Тесть (Пётр для Дмитрия)', tiest(petr, dmitriy)),
    check_test('6. Тёща (Анна для Дмитрия)', tescha(anna, dmitriy)),
    writeln('--- ТЕСТИРОВАНИЕ ЗАВЕРШЕНО ---').

% --- Автотест ---

/*
Как запустить автоматический тест:
* Загрузите ваш файл в SWI-Prolog.
* Наберите в консоли команду: run_test.
*/