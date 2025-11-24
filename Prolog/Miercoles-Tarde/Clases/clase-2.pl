hije(herbert, abraham).
hije(homero, abraham).
hije(homero, mona).
hije(marge, clancy).
hije(marge, jacqueline).
hije(patty, clancy).
hije(patty, jacqueline).
hije(selma, clancy).
hije(selma, jacqueline).
hije(bart, homero).
hije(bart, marge).
hije(lisa, homero).
hije(lisa, marge).
hije(maggie, homero).
hije(maggie, marge).
hije(ling, selma).

programaEn(nahuel,  javaScript).
programaEn(juan,    haskell).
programaEn(juan,    ruby).
programaEn(caro,    haskell).
programaEn(caro,    scala).
programaEn(caro,    javascript).


/*
%! Inversibilidad:
Que los argumentos de un predicado pueden usarse como entrada (individuos)
y salida (variable libre)
*/

programaEn(_, c). 
/* 
- Alguien programa en c?
?- programaEn(nahuel, c).
?- true

- lassie programa en c? (Lassie sin estar en nustra base de conocimiento)
?- programaEn(lassie, c)
?- true


- Alguna persona en c?
!Hay una error aca porque programaEn deja de ser inversible en Persona, ya no me dira quienes
! programan en c 
?- programaEn(Persona, c)
?- true


- Podriamos que programaEn/2 dependa de persona/1

programaEn(Persona, c):-
    persona(Persona).

!Predicado generador
persona(nahuel).
persona(juan).
persona(caro).


?- programaEn(lassie, c)
?- false
?- programaEn(Persona, c)
?- Persona = nahuel
?- Persona = juan
?- Persona = caro

*/

%! Negacion.
/*
- Es cierto que nahuel no programa en ruby?
?- not(programaEn(nahuel, ruby)).
true.
  

- Es cierto nadie programa en ruby?
?- not(programaEn(_, ruby)).
true.

*/


/*
%! Nuevo requerimiento
Sabemos que alguein es irremplazable si programa en un lenguaje en el cual
nadie más programa.
*/

programaEn(nahuel,  javaScript).
programaEn(juan,    haskell).
programaEn(juan,    ruby).
programaEn(caro,    haskell).
programaEn(caro,    scala).
programaEn(caro,    javaScript).

irremplazable(Persona):-
    programaEn(Persona, Lenguaje),
    not((programaEn(Alguien, Lenguaje), 
    Alguien\= Persona)).

/*




%! No es inversible, porque llega Alguien sin ligar al \=/2
%! El Alguien \= Persona siempre dará false, entonces el not siempre será true.
irremplazableRoto1(Persona):-
  programaEn(Persona, Lenguaje),
  not((Alguien \= Persona,
     programaEn(Alguien, Lenguaje))).



%! No es inversible, porque llegan Lenguaje y Persona sin ligar al not/1
%! Esto no anda bien ni para consultas individuales, porque no sabemos cuál es el Lenguaje
irremplazableRoto2(Persona):-
  not((programaEn(Alguien, Lenguaje),
          Alguien \= Persona)),
  programaEn(Persona, Lenguaje).



%! Otro error común: consultar Alguien \= Persona después del not/1
%! No tiene sentido porque not/1 no liga variables, y queda una contradicción
%! al consultar que programaEn(Persona, Lenguaje) y luego negar que alguien programe en ese lenguaje.
irremplazableRoto3(Persona):-
  programaEn(Persona, Lenguaje),
  not(programaEn(Alguien, Lenguaje)),
  Alguien \= Persona.

*/

/*
!Resumen : Casos de no inversiblidad
- Hechos con variables
- Comporacion por distinto
- Negación
- >, >= , <, =<
- is/2
*/


/*
Lechuzas
*/

/*
!lechuza/3
Registramos las caracteristicas de las lechuzas de la zona, 
(nombre, sospechosidad y nobleza) con un predicado lechuza/3

necesitamos saber: 
1. Que tan violenta es una lechuza? 
    Se calcula como 5* sospechocidad + 42/nobleza

2. Si una lechuza es vengativa. Lo es si su violencia es mayor a 100.

3. Si una lechuza es mafiosa, que se cumple si no es buena gente o su sospechosidad es al menos 75.
    Decimos que es buena gente si no es vengativa y su nobleza es mayor a 50.
*/

lechuza(swi, 10, 60).
lechuza(duo, 25, 55).
lechuza(blathers, 60, 20).
lechuza(hedwig, 30, 80 ).

esViolenta(Lechuza, GradoDeViolenta):-
    lechuza(Lechuza, Sospechosidad, Nobleza),
    GradoDeViolenta is (5*Sospechosidad + 42/Nobleza).

esVengativa(Lechuza):-
    esViolenta(Lechuza, GradoDeViolenta),
    GradoDeViolenta > 100.

esMafiosa(Lechuza):-
    lechuza(Lechuza, Sospechosidad, _),
    Sospechosidad >= 75.

esMafiosa(Lechuza):-
    lechuza(Lechuza, _, Nobleza),
    not((esVengativa(Lechuza))),
    Nobleza > 50.
