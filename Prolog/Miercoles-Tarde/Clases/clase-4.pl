:- use_module(clase-4).

/*

!Truco!
- Queremos modelar un juego de truco, y nos interesa
saber si una carta mata a otra. 
Por ejemplo: deberia ser cierto que el 1 de basto mata al 7 de espada, pero
NO al 1 de espada, un 4 de cualquier palo mata a ninguna carta, etc.
*/

%?  "carta(1, espada)" y "carta(1, basto)" son functores!!!!
% No hay necesidad de declararlos previamente
%! carta/2 no es es un predicado, es una regla.  
valeMas(carta(1, espada), carta(1, basto)).
valeMas(carta(1, basto), carta(7, espada)).
valeMas(carta(7, espada), carta(7, oro)).

valeMas(carta(7, oro), carta(3, _)). % El 7 de oro valeMas a cualquier 3, sin importar su palo
valeMas(carta(3, _), carta(2, _)). % Igual, el 3 de cualquiera valeMas al 2 de cualquiera.

valeMas(carta(2, _), As):- falsoAs(As).

falsoAs(carta(1,oro)).
falsoAS(carta(1, copa)).



% ?- mata(carta(2, espada), CartaMenor).
% CartaMenor = carta(1, oro).

% ?- mata(carta(3, oro), CartaMenor).
% CartaMenor = carta(2, _ZARAZA).
%! Los hechos con variables con problematicos

%* Hacer que mata/2 sea inversible y transitivo

% Me genera una carta que complua que tenga un palo y un numero valido.
cartaDeTruco(carta(Numero, Palo)):-
    palo(Palo),
    numeroValido(Numero).

palo(basto).
palo(copa).
palo(oro).
palo(espada).

% between/3 relaciona un minimo y un maximo con un numero que se encuentra entre
% ellos. Es inversible para el 3er parametro.       
numeroValido(Numero):-
    between(1, 12, Numero),
    not(between(8, 9, Numero)).


mata(MasValiosa, MenosValiosa):-
    cartaDeTruco(MasValiosa), %Con la carta generada me aseguro que mata/2 sea inversible. 
    cartaDeTruco(MenosValiosa),
    valeMas(MasValiosa, MenosValiosa).



% Esto lo hago para no tener que hacer valeMas de todas, sino de la padre y del hijo.
mata(MasValiosa, MenosValiosa):-
    cartaDeTruco(MasValiosa), %Con la carta generada me aseguro que mata/2 sea inversible. 
    cartaDeTruco(MenosValiosa),
    valeMas(MasValiosa, OtraCarta),
    mata(OtraCarta, MenosValiosa).
/*
!Pattern matching
valeMas(carta(7, oro), carta(3, _)).

valeMas(carta(2, _), As):- falsoAs(As).
valeMas(As, carta(12, _)):- falsoAs(As).

valeMas(carta(Figura1, _), carta(Figura2, _)):-
    between(11, 12, Figura1),
    Figura2 is Figura1 - 1.
*/

/*
1 ?- mata(carta(7, Palo), carta(2,_ )).
Palo = oro;
Palo = espada.

2 ?- not(mata(carta(4, _), _)).
true. 
*/


/*
!POLIMORFISMO

Necesitamos agregar a nuestro juego la capacidad de ganarlo(detalle)..

Un jugador gana el juego si logró cumplir todos sus objetivos. De momento
queremos representar los siguientes:
- Destruir al jugador de un color particular.
- Ocupar un continente indicado.
- Ocupar 3 paises limitrofes entre si en cualquier parte del mapa.
*/

%? objetivos(Jugador, Objetivo).

%* El negro tiene que destruir al rojo.
objetivo(negro, destruirAlRojo).
%* El verde tiene que destruir al magenta.
objetivo(verde, destruirAlMagenta).
%* El amarillo tiene que ocupar africa.
objetivo(amarillo, ocuparAfrica).
%* El amarillo tiene que ocupar americaDelNorte.
objetivo(amarillo, ocuparAmericaDelNorte).
%* El azul tiene que ocupar 3 paises limitrofes.
objetivo(azul, ocuparTresPaisesLimitrofesEntreSi).
%* El azul tiene que ocupar los contienentes de oceania.
objetivo(azul, ocuparOceania).
%* El azul tiene que ocupar los contienentes de americaDelSur.
objetivo(azul, ocuparAmericaDelSur).
%%%%%% Agregado! %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% El magenta tiene que ocupar asia y dos países de americaDelSur
% El rojo tiene que ocupar dos países en todos los continentes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

objetivo(magenta, ocupar(asia)).
objetivo(magenta, ocuparDosPaisesDe(americaDelSur)).

objetivo(rojo, ocuparDosPaisesDe(Continente)):-
  continente(Continente).

% cumplioObjetivo(Jugador, Objetivo)
cumplioObjetivo(Jugador, ocuparDosPaisesDe(Continente)):-
  ocupa(Jugador, Pais1, _),
  ocupa(Jugador, Pais2, _),
  estaEn(Pais1, Continente),
  estaEn(Pais2, Continente),
  Pais1 \= Pais2.


% Se cumple si ocupa todos los países del continente
cumplioObjetivo(Jugador, ocupar(Continente)):-
  jugador(Jugador), continente(Continente),
  forall(estaEn(Pais, Continente),
         ocupa(Jugador, Pais, _)).

% Se cumple si el rival no ocupa ningún país
cumplioObjetivo(Jugador, destruirAl(Rival)):-
  jugador(Jugador), jugador(Rival),
  not(ocupa(Rival, _, _)).

% Se cumple si ocupa 3 países limítrofes entre sí en cualqiuer parte del mapa
cumplioObjetivo(Jugador,
         ocuparTresPaisesLimitrofesEntreSi):-
  ocupaLimitrofes(Jugador, Pais1, Pais2),
  ocupaLimitrofes(Jugador, Pais2, Pais3),
  ocupaLimitrofes(Jugador, Pais1, Pais3).

% ocupaLimitrofes/3 se cumple si el jugador ocupa
% ambos países y son limítrofes entre ellos
ocupaLimitrofes(Jugador, Pais1, Pais2):-
  ocupa(Jugador, Pais1, _),
  ocupa(Jugador, Pais2, _),
  limitrofes(Pais1, Pais2). % Simétrico e irreflexivo


/*
!ERRORES COMUNES:

! No se puede usar una variable para conocer el tipo de objetivo.
?- objetivo(amarillo, CosaParaHacer(africa)).
error.

!No se puede consultar un objetivo, porque !no es un predicado!
ocupar(Continente).
error.


*/