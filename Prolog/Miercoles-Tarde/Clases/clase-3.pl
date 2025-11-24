%Clase 3. Existencia, No Existencia, Para todo (forall)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% T.E.G.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Descripción del mapa

% estaEn(Pais, Continente).
estaEn(argentina, americaDelSur).
estaEn(uruguay, americaDelSur).
estaEn(brasil, americaDelSur).
estaEn(chile, americaDelSur).
estaEn(peru, americaDelSur).
estaEn(colombia, americaDelSur).

estaEn(mexico, americaDelNorte).
estaEn(california, americaDelNorte).
estaEn(nuevaYork, americaDelNorte).
estaEn(oregon, americaDelNorte).
estaEn(alaska, americaDelNorte).

estaEn(alemania, europa).
estaEn(espania, europa).
estaEn(francia, europa).
estaEn(granBretania, europa).
estaEn(rusia, europa).
estaEn(polonia, europa).
estaEn(italia, europa).
estaEn(islandia, europa).

estaEn(sahara, africa).
estaEn(egipto, africa).
estaEn(etiopia, africa).

estaEn(aral, asia).
estaEn(china, asia).
estaEn(gobi, asia).
estaEn(mongolia, asia).
estaEn(siberia, asia).
estaEn(india, asia).
estaEn(iran, asia).
estaEn(kamchatka, asia).
estaEn(turquia, asia).
estaEn(israel, asia).
estaEn(arabia, asia).

estaEn(australia, oceania).
estaEn(sumatra, oceania).
estaEn(borneo, oceania).
estaEn(java, oceania).

% Como limitaCon/2 pero simétrico
limitrofes(Pais, Limitrofe):- 
    limitaCon(Pais, Limitrofe).
limitrofes(Pais, Limitrofe):- 
    limitaCon(Limitrofe, Pais).

% Antisimétrico, irreflexivo y no transitivo
% Predicado auxiliar. Usar limitrofes/2.
limitaCon(argentina,brasil).
limitaCon(uruguay,brasil).
limitaCon(uruguay,argentina).
limitaCon(argentina,chile).
limitaCon(argentina,peru).
limitaCon(brasil,peru).
limitaCon(chile,peru).
limitaCon(brasil,colombia).
limitaCon(colombia,peru).

limitaCon(mexico, colombia).
limitaCon(california, mexico).
limitaCon(nuevaYork, california).
limitaCon(oregon, california).
limitaCon(oregon, nuevaYork).
limitaCon(alaska, oregon).

limitaCon(espania,francia).
limitaCon(espania,granBretania).
limitaCon(alemania,francia).
limitaCon(alemania,granBretania).
limitaCon(polonia, alemania).
limitaCon(polonia, rusia).
limitaCon(italia,francia).
limitaCon(alemania,italia).
limitaCon(granBretania, islandia).

limitaCon(china,india).
limitaCon(iran,india).
limitaCon(china,iran).
limitaCon(gobi,china).
limitaCon(aral, iran).
limitaCon(gobi, iran).
limitaCon(china, kamchatka).
limitaCon(mongolia, gobi).
limitaCon(mongolia, china).
limitaCon(mongolia, iran).
limitaCon(mongolia, aral).
limitaCon(siberia, mongolia).
limitaCon(siberia, aral).
limitaCon(siberia, kamchatka).
limitaCon(siberia, china).
limitaCon(turquia, iran).
limitaCon(israel, turquia).
limitaCon(arabia, israel).
limitaCon(arabia, turquia).

limitaCon(australia, sumatra).
limitaCon(australia, borneo).
limitaCon(australia, java).

limitaCon(sahara, egipto).
limitaCon(etiopia, sahara).
limitaCon(etiopia, egipto).

limitaCon(australia, chile).
limitaCon(aral, rusia).
limitaCon(iran, rusia).
limitaCon(india, sumatra).
limitaCon(alaska, kamchatka).
limitaCon(sahara, brasil).
limitaCon(sahara, espania).
limitaCon(egipto, polonia).
limitaCon(turquia, polonia).
limitaCon(turquia, rusia).
limitaCon(turquia, egipto).
limitaCon(israel, egipto).

%% Estado actual de la partida

% ocupa(Jugador, Pais, Ejercitos)
ocupa(azul, argentina, 5).
ocupa(azul, uruguay, 3).
ocupa(verde, brasil, 7).
ocupa(azul, chile, 8).
ocupa(verde, peru, 1).
ocupa(verde, colombia, 1).

ocupa(rojo, alemania, 2).
ocupa(rojo, espania, 1).
ocupa(rojo, francia, 6).
ocupa(rojo, granBretania, 1).
ocupa(amarillo, rusia, 6).
ocupa(amarillo, polonia, 1).
ocupa(verde, italia, 1).
ocupa(amarillo, islandia, 1).

ocupa(magenta, aral, 1).
ocupa(azul, china, 1).
ocupa(azul, gobi, 1).
ocupa(azul, india, 1).
ocupa(azul, iran,8).
ocupa(verde, mongolia, 1).
ocupa(verde, siberia, 2).
ocupa(verde, kamchatka, 2).
ocupa(amarillo, turquia, 10).
ocupa(negro, israel, 1).
ocupa(negro, arabia, 3).

ocupa(azul, australia, 1).
ocupa(azul, sumatra, 1).
ocupa(azul, borneo, 1).
ocupa(azul, java, 1).

ocupa(amarillo, mexico, 1).
ocupa(amarillo, california, 1).
ocupa(amarillo, nuevaYork, 3).
ocupa(amarillo, oregon, 1).
ocupa(amarillo, alaska, 4).

ocupa(amarillo, sahara, 1).
ocupa(amarillo, egipto, 5).
ocupa(amarillo, etiopia, 1).

% Generadores por si hacen falta
jugador(Jugador):- ocupa(Jugador, _,_).
continente(Continente):- estaEn(_, Continente).


/*
!TEG: Punto de partida
- Queremos armar un programa que nos permita analizar le estados actual de una partida
de TEG. Disponemos de una base de conocimientos con los siguientes 
predicados inversibles:

- limitrofes/2 ,    relaciona paises que son limitrofes, es simetrico.
- estaEn/2,         relaaciona un pais con el contienente en el que se encuentra.
- ocupa/3           relaciona un jugador con un pais y cuantos ejecitos tiene.

?- limitrofes(peru, chile).
?- estaEn(francia, europa).
?- ocupa(verde, brasil, 7).
*/

% limitrofes(Pais, OtroPaisLimitrofe).
% estaEn(Pais, Continente).
% ocupa(Jugador, Pais, Ejecitos).

/*
!Definir lo siguiente:

- puedeEntrar/2 que se cumple para un jugador y un continente si no ocupa
ningun pais del mismo, pero si alguno que es limitrofe de al menos uno de ellos.

- seVanAPelear/2 que se cumple para 2 jugadores si son los unicos que ocupan paises 
en un contienente, y tienen alli algun pais fuerte (con mas de 4 ejercitos).

*/

% limitrofes(Pais, OtroPaisLimitrofe).
% estaEn(Pais, Continente).
% ocupa(Jugador, Pais, Ejecitos).

ocupaPaisEn(Jugador, Continente):-
    ocupa(Jugador, Pais,_),
    estaEn(Pais, Continente).


puedeEntrar(Jugador, Contienente):-
    estaEn(OtroPais, Contienente),
    ocupa(Jugador, Pais, _),
    not(ocupaPaisEn(Jugador, Contienente)),
    limitrofes(Pais, OtroPais).

% - seVanAPelear/2 que se cumple para 2 jugadores si son los unicos que ocupan paises 
% en un contienente, y tienen alli algun pais fuerte (con mas de 4 ejercitos).

seVanAPelear(Jugador, Rival):-
    ocupaPaisPaisFuerteEn(Jugador, Continente),
    ocupaPaisPaisFuerteEn(Rival, Continente),
    Jugador \= Rival,
    %? "Jugador y Rival son los unicos en ese continente"
    not((ocupaPaisEn(Tercero, Continente), Tercero \= Jugador, Tercero \= Rival)).

ocupaPaisPaisFuerteEn(Jugador, Continente):-
    ocupa(Jugador, Pais,_),
    estaEn(Pais, Continente),
    fuerte(Pais).

fuerte(Pais):-
    ocupa(_, Pais, Ejercitos),
    Ejercitos > 4.


/*
!Nuevo requerimiento:

- Necesitamos agregar a nuestro programa un predicado estaRodeado/1
que se cumple para un país si todos sus limitrofes estan ocupados por rivales.
Se espera que sea inversible.
*/



/*
!PREDICADO FORALL

- Para verificar si todos los que cumplen una consulta,
tambien cumplen con otras usamos forall/2.

- Como recibe consultas, es de orden superior.

- A la primer consulta que recibe le llamamos antecedente, y a la
segunda le decimos consecuente.

- El antecedente y el consecuente deben vincularse adecuadamente.
forall(limitrofes(Pais, Otro), ocupadoPorRival(Otro, Jugador))
* Aca lo que vincula el antecedente y el consecuente es la variable Otro

?Importante:
- Siempre debe haber alguna variable libre en el antecedente, para decir
"para todo X, tal que X..."
*/


ocupadoPorRival(Pais, Jugador):-
    ocupa(Rival, Pais,_),
    Rival \= Jugador.

estaRodeado(Pais):-
    ocupa(Jugador, Pais,_),
    forall(limitrofes(Pais, Otro), ocupadoPorRival(Otro,Jugador)).

/*
?Otro requerimiento:
1. ¿Es cierto que todos los paises de oceania estan ocupados por el azul?
1. ?- forall(estaEn(Pais, Oceania), ocupa(Azul, Pais, _)).
true
*Porque todo oceania esta ocupado por el azul.

2. ¿Es cierto que todos los paises ocupados por el azul estan en oceania?
2. ?- forall(ocupa(Azul, Pais, _), estaEn(Pais, Oceania)).
false

*Porque el azul no solamente estan en oceania. El azul tambien esta en argentina y oceania. 
*ergo, falso

3. ¿Es cierto que todos los paises que ocupa el verde en oceania estan rodeados?
3. ?- forall((estaEn(Pais, oceania), ocupa(verde, Pais, _)), 
                estaRodeado(Pais)).
true

%* estaEn() y ocupa() son en conjunto el antecedente
%* estaRodeado() es el consecuente

!Importante
*Si en la base de conocimientos no hay individuos que cumplan el ANTECEDENTE el forall/2 da TRUE.
*(se entender al ver tambien por la tabla de verdad del implica) 
*/

/*
!Inversibilidad y el forall/2
1. ¿Qué jugador ocupa todos los paises de oceania?
1 ?- forall(estaEn(Pais, oceania), ocupa(Jugador, Pais, _)).
true 


2. ¿Que continente esta ocupado completamente por el azul?
2 ?- forall(estaEn(Pais, Continente), ocupa(azul, Pais, _)).
false.

?Ambos casos debe ligarse previamente el predicado Jugador y Continente para que 
?sean inversibles. 

jugador(Jugador):-
    ocupa(Jugador,_ ,_).

continente(Continente):-
    estaEn(_, Continente).

Ej: 
1 ?- jugador(Jugador), forall(estaEn(Pais, oceania), ocupa(Jugador, Pais, _))
Jugador = azul,

2 ?- continente(Continente), forall(estaEn(Pais, Continente), ocupa(azul, Pais, _)).
Continente = oceania.

*/

/*
!Practica y nuevos requerimientos
Definir los siguientes predicados asegurando que sean inversibles:

1. protegido/1 se cumple para un pais si ninguno de sus limitrofes estan
ocupados por un rival o si es fuerte(tiene más de 4 ejercitos).

2. complicado/2 se cumple para un jugador y un continente si todos los paises 
que ocupa en ese continente estan rodeados.
*/

% limitrofes(Pais, OtroPaisLimitrofe).
% estaEn(Pais, Continente).
% ocupa(Jugador, Pais, Ejecitos).

protegido(Pais):-
    fuerte(Pais).

% ocupadoPorRival(Pais, Jugador):-
%   ocupa(Rival, Pais, _),
%   Rival \= Jugador.

% Version con un forall
protegido(Pais):-
    ocupa(Jugador, Pais,_),
    forall(limitrofes(Pais, Limitrofe), not(ocupadoPorRival(Limitrofe, Jugador))).
    % Jugador \= OtroJugador. // Ya esta implementado en el ocupadoPorRival


% Version con el not
protegidoConNot(Pais):-
    ocupa(Jugador, Pais,_),
    not((limitrofes(Pais, Limitrofe), ocupadoPorRival(Limitrofe, Jugador))).



%  Generadores por si hacen falta
% jugador(Jugador):- ocupa(Jugador, _,_).
% continente(Continente):- estaEn(_, Continente).

complicado(Jugador, Continente):-
    % jugador(Jugador),
    % continente(Continente),
    ocupaPaisEn(Jugador, Continente),
    forall((ocupa(Jugador, Pais, _), estaEn(Pais, Continente)), estaRodeado(Pais)).


/*
!Nuevo requerimiento
- Para terminar, queremos saber cual es el pais mas fuerte
de un jugador mediante un predicado masFuerte/2.

Esta relacion se cumple si el pais en cuestion es fuerte y ademas
es el que mas ejercitos tiene de los que ocupa ese jugador.

En caso de haber varios con esa misma cantidad, puede tener más de 
una respuesta para cada jugador
*/

masFuerte(Pais, Jugador):-
    fuerte(Pais),
    ocupa(Jugador, Pais, MuchosEjercitos),
    forall((ocupa(Jugador, OtroPais, Ejercitos), OtroPais \= Pais), Ejercitos =< MuchosEjercitos).
