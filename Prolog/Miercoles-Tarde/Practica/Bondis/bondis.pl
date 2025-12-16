% Recorridos en GBA:
recorrido(17, gba(sur), mitre).
recorrido(24, gba(sur), belgrano).
recorrido(247, gba(sur), onsari).
recorrido(60, gba(norte), maipu).
recorrido(152, gba(norte), olivos).


% Recorridos en CABA:
recorrido(17, caba, santaFe).
recorrido(152, caba, santaFe).
recorrido(10, caba, santaFe).
recorrido(160, caba, medrano).
recorrido(24, caba, corrientes).


%*1. 
% Saber si dos líneas pueden combinarse, que se cumple cuando su recorrido pasa por una
% misma calle dentro de la misma zona.

% puedeCombinarse(Linea, OtraLinea).
puedeCombinarse(Linea, OtraLinea):-
    recorrido(Linea, Zona, Calle),
    recorrido(OtraLinea, Zona, Calle),
    Linea \= OtraLinea.

%*2. 
% Conocer cuál es la jurisdicción de una línea, que puede ser o bien nacional, que se cumple
% cuando la misma cruza la General Paz, o bien provincial, cuando no la cruza. Cuando la
% jurisdicción es provincial nos interesa conocer de qué provincia se trata, si es de
% buenosAires (cualquier parte de GBA se considera de esta provincia) o si es de caba.
% Se considera que una línea cruza la General Paz cuando parte de su recorrido pasa por una
% calle de CABA y otra parte por una calle del Gran Buenos Aires (sin importar de qué zona
% se trate)
% jurisdiccion(Linea, Jurisdiccion).

cruzaGralPaz(Linea):-
    recorrido(Linea, gba(_),_),
    recorrido(Linea, _, _).

perteneceA(caba, caba).
perteneceA(gba(_), buenosAires).

jurisdiccion(Linea, nacional):-
    cruzaGralPaz(Linea).

jurisdiccion(Linea, provincial(Provincia)):-
    recorrido(Linea, Zona, _),
    perteneceA(Zona, Provincia),
    not(cruzaGralPaz(Linea)).


%* 3. Saber cuál es la calle más transitada de una zona, que es por la que pasen mayor cantidad
%* de líneas.

cantBondisPorCalle(Calle, Zona, CantBondis):-
    recorrido(_, Zona, Calle),
    findall(Linea, recorrido(Linea, Zona, Calle), ListLineas),
    length(ListLineas, CantBondis).


%! Queres que se generen todas las calles, por eso es que se genera dentro del forall
masTransitada(Calle):-
    cantBondisPorCalle(Calle, Zona, CantBondis),
    forall((recorrido(_, Zona, OtraCalle), Calle \= OtraCalle), 
    (cantBondisPorCalle(OtraCalle, Zona, CantidadMenor), Cantidad > CantidadMenor)).
    
    

% recorrido(_,Zona, OtraCalle),
% forall(cantBondisPorCalle(OtraCalle, Zona, OtraCantBondis), OtraCantBondis > CantBondis).



%*4. Saber cuáles son las calles de transbordos en una zona, que son aquellas por las que pasan
%* al menos 3 líneas de colectivos, y todas son de jurisdicción nacional.
 
% todasSonNacional(Lineas):-
%     forall() 
 
% transbordos(Calle, Zona):-
%     findall(Linea, recorrido(Linea, Zona, Calle), ListLineas),
%     todasSonNacional(ListLineas),
%     length(ListLineas, CantLineas),
%     CantLineas > 3.


calleDeTrasbordo(CalleTrasbordo, Zona):-
    recorrido(_, Zona, CalleTrasbordo),
    forall(recorrido(Linea, Zona, CalleTrasbordo), jurisdiccion(Linea, nacional)),
    cantBondisPorCalle(CalleTrasbordo, Zona, CantidadLineasCalleTrasbordo),
    CantidadLineasCalleTrasbordo >= 3.
