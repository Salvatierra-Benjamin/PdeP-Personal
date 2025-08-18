% Recorridos en GBA:
recorrido(17, gba(sur), mitre).
recorrido(24, gba(sur), belgrano).
recorrido(152, gba(norte), olivos).
recorrido(247, gba(sur), onsari).
recorrido(60, gba(norte), maipu).


% Recorridos en CABA:
recorrido(17, caba, santaFe).
recorrido(24, caba, corrientes).
recorrido(152, caba, santaFe).
recorrido(10, caba, santaFe).
recorrido(160, caba, medrano).

% ---- 1

% 
combinacion(UnColectivo, OtroColectivo):-
    recorrido(UnColectivo, Zona, Calle),
    recorrido(OtroColectivo, Zona, Calle),
    UnColectivo \= OtroColectivo.



% ---- 2

% jurisdiccion nacional: cruza la gral paz
% jurisdiccion provincial: NO cruza gral paz
% saber que es de GBA
% 

cruzaGralPaz(Linea):-
    recorrido(Linea, caba, UnaCalle),
    recorrido(Linea, gba(_),OtraCalle),
    UnaCalle \= OtraCalle.

% jurisdiccion(Linea, Jurisdiccion):-
%     recorrido(Linea, Zona, Calle),
%     recorrido(Linea, ).

jurisdiccion(Linea, nacional):- 
    cruzaGralPaz(Linea).

% Ej 3

cuantasLineasPasan(Calle, Zona, Cantidad):-
    recorrido(_, Zona, Calle),
    findall(Calle, recorrido(_, Zona, Calle), ListaCalles),
    length(ListaCalles, Cantidad).



% calleMasTransitada(Calle, ListaDeCantidades):-
%     recorrido(_, Zona, Calle),
%     findall(Cantidad, cuantasLineasPasan(Calle, Zona, Cantidad), ListaDeCantidades ).

calleMasTransitada(Calle, Zona):-
    cuantasLineasPasan(Calle, Zona, Cantidad),
    forall((recorrido(_, Zona, OtraCalle), Calle \= OtraCalle), (cuantasLineasPasan(OtraCalle, Zona, CantidadMenor), Cantidad > CantidadMenor)).
    