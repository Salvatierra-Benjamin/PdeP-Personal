% Las variables va con mayuscula, todo lo demas con minuscula (ej: socrates) 

%  Definir predicados 
%  Definir base de datos
/*
!hecho:
- Afirmacion indoncional.
- Definicion por extension.

!regla:
- implicacion (si... entonces)
- deficion por comprension
*/
%? humano/1  indica el nombre y su aridad (numero de argumentos)
%* humano/1 es predicado 
humano(socrates). 

%* mortal/1 es predicado y regla
%* tiene dos clausulas, el hecho y la regla
mortal(Alguien):-
    humano(Alguien).

mortal(lassie).


% mortal(socrates). // Consulta
% true.

% Para ser mortal tiene que ser humano pero platon no esta definido como 
% humano, ergo no es mortal (anda saber que será)

% mortal(platon). 
% false.

%  Principio de universo cerrado.
%  Si algo no se puede inferir como verdadero, entonces es falso.

/* 
% lassie es mortal?
1 ?- mortal(lassie). %! Consulta INDIVIDUAL
true. 

% Existe ALGUIEN que sea mortal?
2 ?-mortal(_). %! Consulta EXISTENCIAL
true.

% Quienes son mortales?
3. ?- mortal(Quien). %! Consulta EXISTENCIAL
Quien = socrates;
Quien = lassie.

*/
/*
- Nahuel programa en JS
- Juan programa en Haskell y ruby
- Caro programa en haskell y Scala
- Tito no programa en ningun lenguaje
*/
programaEn(nahuel,  javaScript).

programaEn(juan,    haskell).
programaEn(juan,    ruby).

programaEn(caro,    haskell).
programaEn(caro,    ruby).
%! programaEn(tito, ). // No se modela!!! por universo cerrado

% programaEn(Persona, haskell) quienes programan en haskell

% Persona = juan;
% Persona = caro.

/*
*Sabemos que dos personas son colegas si programan en un mismo lenguaje.

Queremos saber: 
1. Si juan y caro son colegas.
2. quienes son colegas.
*/

esColega(Persona, OtraPersona):-
    programaEn(Persona, Lenguaje),
    programaEn(OtraPersona, Lenguaje),
    OtraPersona \= Persona.

/*
- Individuos: para la clase de ahora son atomos, no strings.
- Predicados : hechos vs reglas.
- Consultas individuales y existenciales.
- Multiplces respuesta y valor de verdad.
- Multiplces respuesta y valor de verdad.
- Conjuncion: ,
- Unificación y backstracking.

*/


/*
A partir de la informacion quien es hijo de quien de una familia:

1. Saber si dos personas son hermanas.
2. Saber si una persona es descendiente de otra.

*/


% hije/2 Se cumple si la segunda persona es padre/madre de la primera
% hije(Hijo, Padre/madre).
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


hermanes(Hije, OtroHije):-
    hije(Hije, Padre),
    hije(OtroHije, Padre),
    Hije \= OtroHije.

descendiente(Descendiente, Persona):-
    hije(Descendiente, Persona).

% !MAL
% descendiente(Descendiente, Persona):-
%     hije(Descendiente, OtraPersona),
%     hije(OtraPersona, Persona).


%* Esto seria recursivo, pues si la base de conocimiento crece esta aun funcionaria.
descendiente(Descendiente, Persona):-
    hije(Descendiente, Padre),
    descendiente(Descendiente, Persona).
