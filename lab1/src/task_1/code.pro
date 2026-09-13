% --- ФАКТЫ ---

% Подавление warning
:- discontiguous man/1.
:- discontiguous woman/1.
:- discontiguous parent/2.
:- discontiguous married/2.
:- discontiguous sibling/2.
:- discontiguous brother/2.
:- discontiguous sister/2.
:- discontiguous brother_or_sister/2.
:- discontiguous grandfather/2.
:- discontiguous grandmother/2.
:- discontiguous grandfather_or_grandmother/2.
:- discontiguous grandson/2.
:- discontiguous granddaughter/2.
:- discontiguous grandson_or_granddaughter/2.
:- discontiguous cousin/2.
:- discontiguous cousin_brother/2.
:- discontiguous cousin_sister/2.
:- discontiguous cousin_brother_or_cousin_sister/2.
:- discontiguous uncle/2.
:- discontiguous aunt/2.
:- discontiguous uncle_or_aunt/2.
:- discontiguous nephew/2.
:- discontiguous niece/2.
:- discontiguous nephew_or_niece/2.
:- discontiguous wife/2.
:- discontiguous tiest/2.
:- discontiguous tescha/2.


% Мужчины (man/1):
man(andrey).   % (предикат man с арностью 1) 1 — в зелёном, крайний слева сверху
man(sergey).   % 2 — в синем костюме
man(petr).     % 4 — с усами, в тёмном
man(viktor).   % 6 — в жёлтой каске
man(dmitriy).  % 8 — в синей рубашке
man(mixail).   % 11 — в сером костюме
man(nikolai).  % 12 — мальчик внизу

% Женщины (woman/1):
woman(maria).  % 3 — синий костюм
woman(anna).   % 5 — в белом халате
woman(olga).  % 7 — розовая кофта
woman(tatyana).% 9 — тёмные волосы, красное
woman(elena).  % 10 — зелёная кофта
woman(sofya).  % 13 — девочка внизу

% --- Старшее поколение → среднее ---
% Сергей-Мария
parent(sergey, olga). % Сергей отец Ольги
parent(sergey, dmitriy). % Сергей отец Дмитрия
parent(maria, olga). % Мария мать Ольги
parent(maria, dmitriy). % Мария мать Дмитрия
% Петр-Анна
parent(petr, tatyana). % Петр отец Татьяны
parent(petr, elena). % Петр отец Елены
parent(anna, tatyana). % Анна мать Татьяны
parent(anna, elena). % Анна мать Елены

% --- Среднее поколение → младшее ---
% Дмитрий-Татьяна
parent(dmitriy, nikolai). % Дмитрий отец Николая
parent(tatyana, nikolai). % Татьяна мать Николая
% Михаил-Елена
parent(mixail, sofya). % Михаил отец Софьи
parent(elena, sofya). % Елена мать Софьи

% Пары жених/невеста + невеста/жених married/2
% Сергей-Мария
married(sergey, maria). % Сергей женат на Марии
married(maria, sergey). % Мария жената на Сергее
% Петр-Анна
married(petr, anna). % Петр женат на Анне
married(anna, petr). % Анна жената на Петре
% Дмитрий-Татьяна
married(dmitriy, tatyana). % Дмитрий женат на Татьяне
married(tatyana, dmitriy). % Татьяна жената на Дмитрии
% Михаил-Елена
married(mixail, elena). % Михаил женат на Елене
married(elena, mixail). % Елена жената на Михаиле

% --- ФАКТЫ ---

% --- ПРАВИЛА ВЫВОДА ---

% родство: родные братья/сестры (общие родители)
sibling(andrey, sergey). % Андрей брат Сергею
sibling(sergey, andrey). % Сергей брат Андрею 

sibling(anna, viktor). % Анна сестра Виктору
sibling(viktor, anna). % Виктор брат Анне

sibling(X, Y) :- parent(P, X), parent(P, Y), X \= Y. % X не равен Y
% Проверка на родство самому себе

% --- ПЕРЕЧЕНЬ I ---

% 1. Брат или Сестра
brother(X, Y) :- man(X), sibling(X, Y). % Брат
sister(X, Y) :- woman(X), sibling(X, Y). % Сестра
brother_or_sister(X, Y) :- brother(X, Y); sister(X, Y). % Брат или Сестра 

% 2. Бабушка или Дедушка
grandfather(X, Y) :- man(X), parent(X, P), parent(P, Y). % Дедушка
grandmother(X, Y) :- woman(X), parent(X, P), parent(P, Y). % Бабушка
grandfather_or_grandmother(X, Y) :- grandfather(X, Y); grandmother(X, Y). % Бабушка или Дедушка

% 3. Внук или Внучка
grandson(X, Y) :- man(X), grandfather_or_grandmother(Y, X). % Внук
granddaughter(X, Y) :- woman(X), grandfather_or_grandmother(Y, X). % Внучка
grandson_or_granddaughter(X, Y) :- grandson(X, Y); granddaughter(X, Y). % Внук или Внучка   

% 4. Двоюродный брат или Двоюродная сестра
% Правило для двоюродных братьев и сестер
cousin(X, Y) :- parent(P1, X), parent(P2, Y), sibling(P1, P2), X \= Y. 
% Проверка, что человек не является двоюродным братом самому себе
cousin_brother(X, Y) :- man(X), cousin(X, Y). % Двоюродный брат
cousin_sister(X, Y) :- woman(X), cousin(X, Y). % Двоюродная сестра
cousin_brother_or_cousin_sister(X, Y) :- cousin_brother(X, Y); cousin_sister(X, Y). 
% Двоюродный брат или Двоюродная сестра

% --- ПЕРЕЧЕНЬ I ---

% --- ПЕРЕЧЕНЬ II ---

% 1. Дядя или Тетя
% X - мужчина и у племянника(цы) есть родитель-родственник X 
uncle(X, Y) :- man(X), parent(P, Y), sibling(X, P). % Дядя 
% X - женщина и у племянника(цы) есть родитель-родственник X
aunt(X, Y) :- woman(X), parent(P, Y), sibling(X, P). % Тетя

uncle_or_aunt(X, Y) :- uncle(X, Y); aunt(X, Y). % Дядя или Тетя 

% 2. Племянник или Племянница
nephew(X, Y) :- man(X), uncle_or_aunt(Y, X). % Племянник
niece(X, Y) :- woman(X),  uncle_or_aunt(Y, X). % Племяннца
nephew_or_niece(X, Y) :- nephew(X, Y); niece(X, Y). % Племянник или Племянница

% 3. Теща или Тесть
% Вспомогательное правило: W является женой для M
wife(W, M) :- woman(W), man(M), married(M, W).
% Тесть (X — мужчина, являющийся родителем жены Y)
tiest(X, Y) :- man(X), man(Y), wife(Wife, Y), parent(X, Wife).
% Тёща (X — женщина, являющаяся родителем жены Y)
tescha(X, Y) :- woman(X), man(Y), wife(Wife, Y), parent(X, Wife).
tescha_or_test(X, Y) :- test(X, Y); tescha(X, Y). % Тёща или Тесть

% --- ПЕРЕЧЕНЬ II ---

% --- ПРАВИЛА ВЫВОДА ---

% --- Автотест ---

% --- ФАКТЫ ---

% Мужчины (man/1):
man(andrey).   % (предикат man с арностью 1) 1 — в зелёном, крайний слева сверху
man(sergey).   % 2 — в синем костюме
man(petr).     % 4 — с усами, в тёмном
man(viktor).   % 6 — в жёлтой каске
man(dmitriy).  % 8 — в синей рубашке
man(mixail).   % 11 — в сером костюме
man(nikolai).  % 12 — мальчик внизу

% Женщины (woman/1):
woman(maria).  % 3 — синий костюм
woman(anna).   % 5 — в белом халате
woman(olga).  % 7 — розовая кофта
woman(tatyana).% 9 — тёмные волосы, красное
woman(elena).  % 10 — зелёная кофта
woman(sofya).  % 13 — девочка внизу

% --- Старшее поколение → среднее ---
% Сергей-Мария
parent(sergey, olga). % Сергей отец Ольги
parent(sergey, dmitriy). % Сергей отец Дмитрия
parent(maria, olga). % Мария мать Ольги
parent(maria, dmitriy). % Мария мать Дмитрия
% Петр-Анна
parent(petr, tatyana). % Петр отец Татьяны
parent(petr, elena). % Петр отец Елены
parent(anna, tatyana). % Анна мать Татьяны
parent(anna, elena). % Анна мать Елены

% --- Среднее поколение → младшее ---
% Дмитрий-Татьяна
parent(dmitriy, nikolai). % Дмитрий отец Николая
parent(tatyana, nikolai). % Татьяна мать Николая
% Михаил-Елена
parent(mixail, sofya). % Михаил отец Софьи
parent(elena, sofya). % Елена мать Софьи

% Пары жених/невеста + невеста/жених married/2
% Сергей-Мария
married(sergey, maria). % Сергей женат на Марии
married(maria, sergey). % Мария жената на Сергее
% Петр-Анна
married(petr, anna). % Петр женат на Анне
married(anna, petr). % Анна жената на Петре
% Дмитрий-Татьяна
married(dmitriy, tatyana). % Дмитрий женат на Татьяне
married(tatyana, dmitriy). % Татьяна жената на Дмитрии
% Михаил-Елена
married(mixail, elena). % Михаил женат на Елене
married(elena, mixail). % Елена жената на Михаиле

% --- ФАКТЫ ---

% --- ПРАВИЛА ВЫВОДА ---

% родство: родные братья/сестры (общие родители)
sibling(andrey, sergey). % Андрей брат Сергею
sibling(sergey, andrey). % Сергей брат Андрею 

sibling(anna, viktor). % Анна сестра Виктору
sibling(viktor, anna). % Виктор брат Анне

sibling(X, Y) :- parent(P, X), parent(P, Y), X \= Y. % X не равен Y
% Проверка на родство самому себе

% --- ПЕРЕЧЕНЬ I ---

% 1. Брат или Сестра
brother(X, Y) :- man(X), sibling(X, Y). % Брат
sister(X, Y) :- woman(X), sibling(X, Y). % Сестра
brother_or_sister(X, Y) :- brother(X, Y); sister(X, Y). % Брат или Сестра 

% 2. Бабушка или Дедушка
grandfather(X, Y) :- man(X), parent(X, P), parent(P, Y). % Дедушка
grandmother(X, Y) :- woman(X), parent(X, P), parent(P, Y). % Бабушка
grandfather_or_grandmother(X, Y) :- grandfather(X, Y); grandmother(X, Y). % Бабушка или Дедушка

% 3. Внук или Внучка
grandson(X, Y) :- man(X), grandfather_or_grandmother(Y, X). % Внук
granddaughter(X, Y) :- woman(X), grandfather_or_grandmother(Y, X). % Внучка
grandson_or_granddaughter(X, Y) :- grandson(X, Y); granddaughter(X, Y). % Внук или Внучка   

% 4. Двоюродный брат или Двоюродная сестра
% Правило для двоюродных братьев и сестер
cousin(X, Y) :- parent(P1, X), parent(P2, Y), sibling(P1, P2), X \= Y. 
% Проверка, что человек не является двоюродным братом самому себе
cousin_brother(X, Y) :- man(X), cousin(X, Y). % Двоюродный брат
cousin_sister(X, Y) :- woman(X), cousin(X, Y). % Двоюродная сестра
cousin_brother_or_cousin_sister(X, Y) :- cousin_brother(X, Y); cousin_sister(X, Y). 
% Двоюродный брат или Двоюродная сестра

% --- ПЕРЕЧЕНЬ I ---

% --- ПЕРЕЧЕНЬ II ---

% 1. Дядя или Тетя
% X - мужчина и у племянника(цы) есть родитель-родственник X 
uncle(X, Y) :- man(X), parent(P, Y), sibling(X, P). % Дядя 
% X - женщина и у племянника(цы) есть родитель-родственник X
aunt(X, Y) :- woman(X), parent(P, Y), sibling(X, P). % Тетя

uncle_or_aunt(X, Y) :- uncle(X, Y); aunt(X, Y). % Дядя или Тетя 

% 2. Племянник или Племянница
nephew(X, Y) :- man(X), uncle_or_aunt(Y, X). % Племянник
niece(X, Y) :- woman(X),  uncle_or_aunt(Y, X). % Племяннца
nephew_or_niece(X, Y) :- nephew(X, Y); niece(X, Y). % Племянник или Племянница

% 3. Теща или Тесть
% Вспомогательное правило: W является женой для M
wife(W, M) :- woman(W), man(M), married(M, W).
% Тесть (X — мужчина, являющийся родителем жены Y)
tiest(X, Y) :- man(X), man(Y), wife(Wife, Y), parent(X, Wife).
% Тёща (X — женщина, являющаяся родителем жены Y)
tescha(X, Y) :- woman(X), man(Y), wife(Wife, Y), parent(X, Wife).
tescha_or_tiest(X, Y) :- tiest(X, Y); tescha(X, Y). % Тёща или Тесть

% --- ПЕРЕЧЕНЬ II ---

% --- ПРАВИЛА ВЫВОДА ---

