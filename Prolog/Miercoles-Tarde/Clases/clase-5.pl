%! Listas:

/*
A partir de una lista con alimentos para comprar queremos

1. saber cuantas cosas hay que comprar.
2. saber si un alimento está en la lista.
*/

/*
!Predicados utiles/ para listas
lenght([pera, banana, manzana], Cantidad).
Cantidad = 3.

member(banana, [pera, banana, manzana]).
true.

member(Alimento, [pera, banana, manzana]).
Alimento = pera;
Alimento = banana;
Alimento = manzana.

- sum_list/2 que relaciona una lista de numeros con su sumatoria.
- nath1/3 que relaciona un indice, una lista y un individuo 
si se encuentra en esa posicion (con indices base). 
- Tambien hay una variante con base 0: nath0/3

?- sum_list([6,8,4,7], X).
X = 25

?- nth1(2, [pera, banana, manzana], Alimento).
Alimento = banana.

?- nth1(N, [pera, banana, manzana, banana], banana).
N = 2;
N = 4.

!Si la posicion no importa, es mas adecuado usar el member/2.

?last/2 saca el ultimo de la lista.


% Modelo sin listas

nota(pepito, parcial, funcional, 2).
nota(pepito, parcial, logico, 10).
nota(pepito, parcial, objetos, 9).
nota(pepito, recu(1), funcional, 9).

nota(juanita, parcial, funcional, 10).
nota(juanita, parcial, objetos, 8).
nota(juanita, recu(1), logico, 10).

nota(tito, parcial, funcional, 2).
nota(tito, recu(1), funcional, 6).
nota(tito, recu(1), logico, 4).
nota(tito, recu(2), logico, 8).

posterior(recu(_), parcial).
posterior(recu(X), recu(Y)):- X > Y.

paradigma(funcional).
paradigma(logico).
paradigma(objetos).

aprobo(Estudiante):-
  nota(Estudiante, _,_,_),
  forall(paradigma(Paradigma),
         aproboTema(Estudiante, Paradigma)).

aproboTema(Estudiante, Tema):-
  ultimaNota(Estudiante, Tema, Nota),
  Nota >= 6.

ultimaNota(Estudiante, Tema, Nota):-
  nota(Estudiante, Examen, Tema, Nota),
  not((nota(Estudiante, Examen2, Tema, _),
       posterior(Examen2, Examen))).

vecesQueRindio(Estudiante, Tema, Veces):-
  nota(Estudiante, _, Tema, _),
  findall(Nota, nota(Estudiante,_,Tema,Nota), Notas),
  length(Notas, Veces).

% Modelo alternativo, con listas


notas(pepito, funcional, [2, 9]).
notas(pepito, logico, [10]).
notas(pepito, objetos, [9]).

notas(juanita, funcional, [10]).
notas(juanita, logico, [8]).
notas(juanita, objetos, [10]).

notas(tito, funcional, [2, 6]).
notas(tito, logico, [4, 8]).

ultimaNota(Estudiante, Tema, Nota):-
  notas(Estudiante, Tema, Notas),
  last(Notas, Nota).

vecesQueRindio(Estudiante, Tema, Veces):-
  notas(Estudiante, Tema, Notas),
  length(Notas, Veces).



*/

/*
! findall/

?- findall(Nota, nota(pepito, _ , funcional, Nota), Notas).
Notas = [2, 9];

?- findall(Examen, nota(pepito, Examen, funcional, _), Examenes).

Examenes = [parcial, recu(1)].

*Inversibilidad
?- findall(Nota, nota(Estudiante, _ , funcional, Nota), Notas).
Notas = [2, 9, 10, 2, 6] %* Me trae todas las notas de funcional, sin importa que estudiante sea
*habria que ligar estudiantes si queremos de un estudiante en particular.

?- nota(Estudiante, _, _, Nota), finall(Nota, nota(Estudiante, _, funcional, Nota), Notas).
Estudiante = pepito, Nota = 2, Notas = [2];
Estudiante = pepito, Nota = 10, Notas = []... 
!Error: no deberia de ligar Nota antes de entrar al findall


*?- nota(Estudiante, _, _, _), finall(Nota, nota(Estudiante, _, funcional, Nota), Notas).
Estudiante = pepito,    Notas = [2, 9];
Estudiante = juanita ,  Notas = [10];
Estudiante = tito ,     Notas = [2, 6];

*/

/*
*¨Buenos usos: :D

- Quiero saber cuantas respuestas tiene una determinada consulta. 
- Quiero armar una lista de numeros para poder hacr una sumatoria.
- Mi objetivo final es obtener una lista recolectando elementos de otro lado.
? tener cuidado si realmente se desea esto.
*/

/*
! MALOS USOS D:
1. findall y length > 0

Quiero saber si hay almenos un individuo para el cual se verifique la consulta...
?- findall(X, consulta(X), Lista), length(Lista, Cantidad), Cantidad > 0
%!NO ES NECESARIO UNA LISTA. Se puede con un simple ?- consulta(X)


2. findall y length = 0

Quiero saber si no hay un individuo para el cual se verifique la consulta...
?- findall(X, consulta(X), Lista), length(Lista, 0).
%! NO HACER. Es lo mismo que hacer una verificación de no existencia
%! es lo mismo que ?- not(consulta(X)).


3. findall y member

Quiero saber quiénes cumplen una determinada consulta...
?- findall(X, consulta(X), Lista), member(Elem, Lista).

O si todos los que cumplen una consulta tambien cumplen otra...
?- findall(X, c1(X), Xs), findall(Y, c2(Y), Ys), forall(member(E, Xs), member(E, Ys)).

%! No se hace falta usar lista!
%! findall/3 y member/2 son OPERACIONES INVERSAS.

*El primer caso hace lo mismo que ?- consulta(X).

*El segundo caso hace lo mismo que ?- forall(c1(X), c2(X)).


*/