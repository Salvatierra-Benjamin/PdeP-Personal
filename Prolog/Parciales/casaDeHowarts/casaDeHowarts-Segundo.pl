% descripcion(mago, tipoDeSangre)
descripcion(harry,      mestiza).
descripcion(draco,      pura).
descripcion(hermione,   impura).

% POR QUE ACA SI FUNCIONA ESTA FORMA DE GENERAR MAGO
% PERO CON CASA Y CRITERIOSELEECCION NO FUNCIONA???

% PORQUE mago solo hay un tipo de sangre de mago, 
% osea no aparecera duplicado, a diferencia de criterioSeleccion
% que tiene diferentes criterios
mago(Mago):-
    descripcion(Mago,_).


% caracteristicas(mago, caracter)
caracteristicas(harry, coraje).
caracteristicas(harry, amistad).
caracteristicas(harry, orgullo).
caracteristicas(harry, inteligencia).

caracteristicas(draco, inteligencia).
caracteristicas(draco, orgullo).
% que no es corajudo ni amistoso no se modela
% por universo cerrado

caracteristicas(hermione, inteligencia).
caracteristicas(hermione, orgullo).
caracteristicas(hermione, responsabilidad).
caracteristicas(hermione, amistad).


% odio(mago, casaQueOdia).
odio(harry,     slytherin).
odio(draco,     hugglepuff).
% odio(hermione,  _). NO SE MODELA 


% criterioSeleccion(casa, loQueBusca).
criterioSeleccion(gryffindor,   coraje).
criterioSeleccion(slytherin,    orgullo).
criterioSeleccion(slytherin,    inteligencia).
criterioSeleccion(ravenClaw,    inteligencia).
criterioSeleccion(ravenClaw,    responsabilidad).
criterioSeleccion(hufflepuff,   amistad).

% casa(Casa):-
%     criterioSeleccion(Casa,_).
% NO USAR PORQUE SALDRÁN CASAS DUPLICADAS
% algunas tiene más de un criterio
% 19 ?- casa(Casa).
% Casa = gryffindor ;
% Casa = slytherin ;
% Casa = slytherin ;
% Casa = ravenClaw ;
% Casa = ravenClaw ;
% Casa = hufflepuff.

casa(gryffindor).
casa(slytherin).
casa(hufflepuff).
casa(ravenClaw).

% Ej 1


puedeEntrar(Mago, Casa):-
    % aca si cambio el orden de casa y mago,
    % sale de otro orden
    casa(Casa),
    mago(Mago),
    Casa \= slytherin.
puedeEntrar(Mago, slytherin):-
    mago(Mago),
    not(descripcion(Mago, impura)).





permiteEntrar(Casa, Mago):-
  casa(Casa),
  mago(Mago),
  Casa \= slytherin.
permiteEntrar(slytherin, Mago):-
  descripcion(Mago, TipoDeSangre),
  TipoDeSangre \= impura.

% 43 ?- permiteEntrar(Casa, Mago).
% Casa = gryffindor,
% Mago = harry ;
% Casa = gryffindor,
% Mago = draco ;
% Casa = gryffindor,
% Mago = hermione ;
% Casa = hufflepuff,
% Mago = harry ;
% Casa = hufflepuff,
% Mago = draco ;
% Casa = hufflepuff,
% Mago = hermione ;
% Casa = ravenclaw,
% Mago = harry ;
% Casa = ravenclaw,
% Mago = draco ;
% Casa = ravenclaw,
% Mago = hermione ;
% Casa = slytherin,
% Mago = harry ;
% Casa = slytherin,
% Mago = draco ;


% 49 ?- puedeEntrar(Mago, Casa).
% Mago = harry,
% Casa = slytherin ;
% Mago = draco,
% Casa = slytherin ;
% Mago = harry,
% Casa = gryffindor ;
% Mago = harry,
% Casa = hufflepuff ;
% Mago = harry,
% Casa = ravenclaw ;
% Mago = draco,
% Casa = gryffindor ;
% Mago = draco,
% Casa = hufflepuff ;
% Mago = draco,
% Casa = ravenclaw ;
% Mago = hermione,
% Casa = gryffindor ;
% Mago = hermione,
% Casa = hufflepuff ;
% Mago = hermione,
% Casa = ravenclaw.





% EJ 2
% gryffindor y harry
% slytherin y harry
% hufflepuff y harry
% slytherin y draco 
% ravenClaw y hermione

% Generar Casa con criterioSelecicon(Casa, _)
% Agrega la condicion que ESA casa pida almenos un criterio (agrega condiciones)

caracterApropiado(Mago, Casa):-
    % caracteristicas(Mago, Caracter),
    % usar caracteristicas para generar mago esta mal,
    % usarlo implica agregarle condiciones a mago, 
    % genera un mago que ALMENOS tenga una caracteristicas, 
    % lo mismo pasa al generar casa 
    mago(Mago),
    casa(Casa),
    % en el forall, lo que se cuantifica es el Criterios, 
    % entonces dice algo como "toda casa que tenga estos criterios
    % debe haber un mago que lo tenga"
    forall((criterioSeleccion(Casa, Criterios)),(caracteristicas(Mago, Criterios))).
   
% 15 ?- caracterApropiado(Mago, Casa).
% Mago = harry,
% Casa = gryffindor ;
% Mago = harry,
% Casa = slytherin ;
% Mago = harry,
% Casa = hufflepuff ;
% Mago = draco,
% Casa = slytherin ;
% Mago = hermione,
% Casa = slytherin ;
% Mago = hermione,
% Casa = ravenClaw.



% EJ 3
podriaQuedarse(hermione, gryffindor).

podriaQuedarse(Mago, Casa):-
  caracterApropiado(Mago, Casa),
  puedeEntrar(Mago, Casa),
  odio(Mago, Casa).
  % Casa \= OtraCasa.

/* 
4 ?- podriaQuedarse(Mago, Casa).
Mago = hermione,
Casa = gryffindor ;
Mago = harry,
Casa = slytherin ;
Mago = harry,
Casa = slytherin ;
Mago = harry,
Casa = slytherin ;
false.

*/


% EJ 4

% NO TIENE QUE SER RECURSIVO
% n1 mago tiene que compartir casa con (n1 + 1).
cadenaDeamistades(ListaDeMagos):-
  todosAmistosos(ListaDeMagos),     
  % Asegura que todos los magos de la lista sean amistosos
  cadenaDeCasas(ListaDeMagos).
  % Verifica que todos (consecutivos) magos puedan quedar
  % en la misma casa


todosAmistosos(ListaDeMagos):-
  forall((member(Mago, ListaDeMagos)), (caracteristicas(Mago, amistad))).
/* 
que sea amistoso se podria haber puesto como lo siguiente y quedabaa mas expresivo
amistoso(Mago):-
    caracteristica(Mago, amistad)

*/


cadenaDeCasas(ListaDeMagos):-
  forall(consecutivos(Mago1, Mago2, ListaDeMagos),
  % Recorre ListaDeMagos, ligando Mago1 y Mago2 juntos, para despues utilizarlo
         puedenQuedarEnLaMismaCasa(Mago1, Mago2, _)).
  % Se verifica que Mago1 y Mago2 puedan pertenecer a la misma casa


puedenQuedarEnLaMismaCasa(Mago1, Mago2, Casa):-
  permiteEntrar(Mago1, Casa),
  permiteEntrar(Mago2, Casa),
  Mago1 \= Mago2.

consecutivos(Anterior, Siguiente, Lista):-
  nth1(IndiceAnterior, Lista, Anterior),
  % prolog al pasarle el primer y tercer argumento como variables,
  % le agrega un 1 por defecto
  
% 22 ?- nth1(X, [a,b,c,d], Y).
% X = 1,
% Y = a ;
% X = 2,
% Y = b ;
  IndiceSiguiente is IndiceAnterior + 1,
  nth1(IndiceSiguiente, Lista, Siguiente).



% 17 ?- nth0(3, [a,b,c,d], X).
% X = d.

% 18 ?- nth0(4, [a,b,c,d], X).
% false.

% 19 ?- nth1(3, [a,b,c,d], X).
% X = c.

% 20 ?- nth1(4, [a,b,c,d], X).
% X = d.


% 22 ?- nth1(X, [a,b,c,d], Y).
% X = 1,
% Y = a ;
% X = 2,
% Y = b ;
% X = 3,
% Y = c ;
% X = 4,
% Y = d.










% PARTE 2 - La Copa de las Casas


% accionBuena(ron,      ganarPartidaAjedrez, 50).
% accionBuena(hermione, salvarAmigos, 50).
% accionBuena(harry,    garleAVoldemort, 60).

% lugarProhibido(bosque, 50).
% lugarProhibido(seccionBiblioteca, 10).
% lugarProhibido(tercerPiso, 75).



% % hizoUnaAccion(Mago, Accion).
% hizoUnaAccion(harry, respirar).
% accionMala(harry, tercerPiso).


% esBuenaAlumno(Mago):-
%   hizoUnaAccion(Mago, Accion),
%   not(accionMala(Mago, Accion)).

% hizoAlgoMalo(Mago):-


% % EJ 1A
% % esBuenAlumno(Mago):-
% %   accionBuena(Mago, _, _),
% %   not(accionMala(Mago, _ , _)).

% % EJ 1B
% accionRecurrente(Accion):-
%   accionMala(Mago, Accion, _),
%   accionMala(OtroMago, Accion,_),
%   Mago \= OtroMago.









% PARTE 2 - La Copa de las Casas
/*
- Esta solucion compliado DEMASIADO al ejercicio siguiente
- poner fueraDeCama(Mago) donde  la accion esta afuera (osea el predicado).
- Lo que se hará es poner hizo(Mago, Accion). y que Accion sea
- el individuo para despues usarlo.


% fueraDeCama(harry).

% fueA(hermione,  tercerPiso).
% fueA(hermione,  seccionRestringida).
% fueA(draco,     mazmorras).

% buenaAccion(harry, 60, ganarAVoldemort).

% %%%%%%%%%%%%%%%%%%%%%%%%%%
% % PODRIA SER VALIDO, y funcionaria, pero el enunciado de punto 
% % pide aquellas acciones que dan puntaje negativo. 

% hizoAlgoMalo(Mago):-
%   fueraDeCama(Mago).
% hizoAlgoMalo(Mago):-
%   fueA(Mago, Lugar),
%   lugarProhibido(Lugar, _).

% lugarProhibido(bosque, 50).  
% %%%%%%%%%%%%%%%%%%%%%%%%%

% hizoAlgoMalo(Mago):-
%   hizoAlgoQueDioPuntos(Mago, Puntos),
%   Puntos < 0.

% % MALAS ACCIONES - PUNTOS
% hizoAlgoQueDioPuntos(Mago, 50):-
%   fueraDeCama(Mago).
% hizoAlgoQueDioPuntos(Mago, PuntosQueResta):-
%   fueA(Mago, Lugar),
%   lugarProhibido(Lugar, PuntosPorLugar),
%   PuntosQueResta is PuntosPorLugar * (-1).

% % BUENAS ACCIONES - PUNTOS
% hizoAlgoQueDioPuntos(Mago, Puntos):-
%   buenaAccion(Mago, Puntos, _).
% % no me interesa cual fue la accion per se 


% lugarProhibido(bosque, 50).
% lugarProhibido(tercerPiso, 75).
% lugarProhibido(seccionRestringida, 10).

% hizoUnaAccion(Mago):-
%   fueraDeCama(Mago).

% hizoUnaAccion(Mago):-
%   fueA(Mago,_).
% hizoUnaAccion(Mago):-
%   buenaAccion(Mago,_,_).

% esBuenAlumno(Mago):-
%   hizoUnaAccion(Mago),
%   not(hizoAlgoMalo(Mago)).
*/


% EJ 1A

hizo(harry,     fueraDeCama).
% se pone el lugar, pero no en el punto porque 
% ya esta decidido, y despues se podrá poner el puntaje que resta
% cada lugar?? a diferencia de buenas acciones que cada accion 
% varia en el momento y no esta PRE establecido.
hizo(hermione,  irA(tercerPiso)).
hizo(hermione,  irA(seccionRestringida)).
hizo(harry,     irA(bosque)).
hizo(harry,     irA(tercerPiso)).
hizo(draco,     irA(mazmorras)).

hizo(ron,       buenasAccion(50, ganarAlAjedrezMagico)).
hizo(hermione,  buenasAccion(50, salvarASusAmigos)).
hizo(harry,     buenasAccion(60, ganarAVoldemort)).

hizo(hermione, responderPregunta(dondeSeEncuentraUnBezoar, 20, snape)).
hizo(hermione, responderPregunta(comoHacerLevitarUnaPluma, 25, flitwick)).

% Lo ideal seria poner (por el enunciado), que las cosas malas
% son aquellas que dan puntaje malo, y no volcarlo directamente como 
% una base de conocimiento.
hizoAlgoMalo(Mago):-
  hizo(Mago, Accion),
  puntajeQueGenera(Accion, Puntaje),
  Puntaje < 0.

puntajeQueGenera(fueraDeCama, -50).
puntajeQueGenera(irA(Lugar), PuntajeQueResta):-
  lugarProhibido(Lugar, Puntos),
  PuntajeQueResta is Puntos * -1.
puntajeQueGenera(buenasAccion(Puntaje, _), Puntaje).
puntajeQueGenera(responderPregunta(_, Dificultad, snape), Puntos):-
  Puntos is Dificultad // 2.
% tiene que ser autoexcluyente, o se generará por doble la respuesta del profesor Snape
puntajeQueGenera(responderPregunta(_, Dificultad, Profesor), Dificultad):- 
  Profesor \= snape.

lugarProhibido(bosque, 50).
lugarProhibido(seccionRestringida, 10).
lugarProhibido(tercerPiso, 75).

hizoUnaAccion(Mago):-
  hizo(Mago, _).

esBuenAlumno(Mago):-
  hizoUnaAccion(Mago),
  not(hizoAlgoMalo(Mago)).


% EJ 1B

% accionEsRecurrente(Accion):-
%   hizoUnaAccion(Mago),
%   hizoUnaAccion(OtroMago),
%   Mago \= OtroMago.

esRecurrente(Accion):-
  hizo(Mago, Accion),
  hizo(OtroMago, Accion),
  Mago \= OtroMago.


%% PUNTO 2


% casa(gryffindor).
% casa(slytherin).
% casa(hufflepuff).
% casa(ravenClaw).


esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenClaw).

puntajeTotal(Casa, Puntos):-
  casa(Casa),
  findall(Puntos, 
      (esDe(Mago, Casa), puntosQueObtuvo(Mago, _, Puntos)), 
      ListaDePuntajes),
  sum_list(ListaDePuntajes, Puntos).
  

puntosQueObtuvo(Mago, Accion, Puntaje):-
  hizo(Mago, Accion),
  puntajeQueGenera(Accion, Puntaje).


% EJ 3

% Hacer una lista para después ver el mayor es romperse la cabeza.
casaGanadora(Casa):-
  % casa(Casa),
  puntajeTotal(Casa, PuntajeMayor),
  % casa(OtraCasa),
  forall((puntajeTotal(OtraCasa, PuntajeMenor), Casa \= OtraCasa), 
          PuntajeMayor >= PuntajeMenor).

% es importante en este caso el = pues como hay varias casa que tienen puntaje 0,
% no hay una casa que tenga mayor que las otras, hay un "empate".

% 72 ?- casaGanadora(Casa).
% Casa = slytherin ;
% Casa = hufflepuff ;
% Casa = ravenClaw.



% EJ 4 

% hizo(hermione, responderPregunta(dondeSeEncuentraUnBezoar, 20, snape)).
% hizo(hermione, responderPregunta(comoHacerLevitarUnaPluma, 25, flitwick)).



