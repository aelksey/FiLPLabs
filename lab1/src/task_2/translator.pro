% ============================================================
% Лабораторная работа №1, вариант 3. Словарь.
% ============================================================

% --- Факты словаря ---
word('дом', ['house', 'home', 'building']).
word('кот', ['cat', 'tomcat']).
word('собака', ['dog', 'hound']).
word('книга', ['book', 'volume']).
word('стол', ['table', 'desk']).
word('окно', ['window', 'opening']).
word('машина', ['car', 'automobile', 'machine']).
word('город', ['city', 'town']).
word('вода', ['water']).
word('небо', ['sky', 'heaven']).

% --- Встроенный member (если не определён) ---
member(X, [X|_]).
member(X, [_|T]) :- member(X, T).

% --- Вывод всего словаря ---
print_dictionary :-
    word(Ru, EnList),
    write(Ru), write(' -> '), write(EnList), nl,
    fail.
print_dictionary.

% --- Перевод с русского на английский ---
translate_ru_en(Ru, EnList) :-
    word(Ru, EnList).

% --- Перевод с английского на русский ---
translate_en_ru(En, Ru) :-
    word(Ru, EnList),
    member(En, EnList).

% --- Главное меню ---
main_menu :-
    nl,
    write('===== СЛОВАРЬ ====='), nl,
    write('1. Вывести весь словарь'), nl,
    write('2. Перевод с русского на английский'), nl,
    write('3. Перевод с английского на русский'), nl,
    write('0. Выход'), nl,
    write('Выберите пункт: '),
    read(Choice),
    handle_choice(Choice).

% --- Обработка выбора ---
handle_choice(1) :-
    print_dictionary,
    main_menu.

handle_choice(2) :-
    write('Введите русское слово: '),
    read(Ru),
    (   translate_ru_en(Ru, EnList)
    ->  write('Перевод: '), write(EnList), nl
    ;   write('Слово не найдено.'), nl
    ),
    main_menu.

handle_choice(3) :-
    write('Введите английское слово: '),
    read(En),
    (   translate_en_ru(En, Ru)
    ->  write('Перевод: '), write(Ru), nl
    ;   write('Слово не найдено.'), nl
    ),
    main_menu.

handle_choice(0) :-
    write('До свидания!'), nl.

handle_choice(_) :-
    write('Неверный пункт меню. Попробуйте снова.'), nl,
    main_menu.