%* Punto 1.

% jockey(Nombre, Altura, Peso).
jockey(valdivieso,  155, 52).
jockey(leguisamo,   161, 49).
jockey(lezcano,     149, 50).
jockey(baratucci,   153, 55).
jockey(falero,      157, 52).

% representa(Jockey, Representados/Stud/Caballeriza).
representa(valdivieso,  elTute).
representa(falero,      elTute).
representa(lezcano,     lasHormigas).
representa(baratucci,   elCharabon).
representa(leguisamo,   elCharabon).


caballo(botafogo).
caballo(oldMan).
caballo(energica).
caballo(matBoy).
caballo(yatasto).



prefiere(botafogo, baratucci).
prefiere(botafogo, Jockey):-
    jockey(Jockey, _, Peso),
    Peso < 52.

prefiere(oldMan, Jockey):-
    jockey(Jockey, _ , _),
    atom_length(Jockey, CantLetrasNombre),
    CantLetrasNombre > 7.

%! Este no se MODELA. Universo Cerrado.
% prefiere(energica, Jockey):-
%     jockey(Jockey, _ ,_),
%     not(prefiere(botafogo, Jockey)).

prefiere(matBoy, Jockey):-
    jockey(Jockey, Altura, _),
    Altura > 170.

%* No se modela el utlimo por universo cerrado

% premios(CaballoGanador, Premio).
premios(botafogo,   granPremioNacional).
premios(botafogo,   granPremioRepublica).
premios(oldMan,     granPremioRepublica).
premios(oldMan,     campeonatoPalermoDeOro).
premios(matBoy,     granPremioCriadores).
%* No se modela energia y yatasto por universo cerrado



%* Punto 2.

caballoAmigable(Caballo):-
    prefiere(Caballo, Jockey),
    prefiere(Caballo, OtroJockey),
    OtroJockey \= Jockey.
%? Checkear si es inversible

%* Punto 3.

% botafogo(baratucci, lezcano, leguisamo).
% oldMan(valdivieso, leguisamo, lezcano, baratucci, falero).
% matBoy(nadie)

noEsAmor(Caballo):-
    stud(Caballerisa),    % representa(_, Caballerisa),
    caballo(Caballo),
    not((prefiere(Caballo, Jockey), representa(Jockey, Caballerisa))).

stud(Stud):-
  distinct(Stud, representa(_, Stud)).



%* 4. piolin(Jockey).

piolin(Jockey):-
    jockey(Jockey, _, _).
    forall(prefiere(Jockey, Caballo),
            ganoUnPremioImportante(Caballo)).


ganoUnPremioImportante(Caballo):-
    premios(Caballo, Premio),
    premioImportante(Premio).

premioImportante(granPremioNacional).
premioImportante(granPremioRepublica).

%* 5. 



ganadora(ganador(Caballo), Resultado):-salioPrimero(Caballo, Resultado).
ganadora(segundo(Caballo), Resultado):-salioPrimero(Caballo, Resultado).
ganadora(segundo(Caballo), Resultado):-salioSegundo(Caballo, Resultado).
ganadora(exacta(Caballo1, Caballo2),Resultado):-salioPrimero(Caballo1, Resultado), salioSegundo(Caballo2, Resultado).
ganadora(imperfecta(Caballo1, Caballo2),Resultado):-salioPrimero(Caballo1, Resultado), salioSegundo(Caballo2, Resultado).
ganadora(imperfecta(Caballo1, Caballo2),Resultado):-salioPrimero(Caballo2, Resultado), salioSegundo(Caballo1, Resultado).

salioPrimero(Caballo, [Caballo|_]).
salioSegundo(Caballo, [_|[Caballo|_]]).

% Punto 6: Los colores
% Sabiendo que cada caballo tiene un color de crin:
% - Botafogo es tordo (negro)
% - Old Man es alazán (marrón)
% - Enérgica es ratonero (gris y negro) 
% - Mat Boy es palomino (marrón y blanco)
% - Yatasto es pinto (blanco y marrón)
% queremos saber qué caballos podría comprar una persona que tiene preferencia
% por caballos de un color específico. Tiene que poder comprar por lo menos un caballo para que
% la solución sea válida.
%
% Esperamos que no haya una única solución, sino que se pueda conocer todas las alternativas válidas posibles.
crin(botafogo, tordo).
crin(oldMan, alazan).
crin(energica, ratonero).
crin(matBoy, palomino).
crin(yatasto, pinto).

color(tordo, negro).
color(alazan, marron).
color(ratonero, gris).
color(ratonero, negro).
color(palomino, marron).
color(palomino, blanco).
color(pinto, blanco).
color(pinto, marron).

comprar(Color, Caballos):-
  findall(Caballo, (crin(Caballo, Crin), color(Crin, Color)), CaballosPosibles),
  combinar(CaballosPosibles, Caballos),
  Caballos \= [].

combinar([], []).
combinar([Caballo|CaballosPosibles], [Caballo|Caballos]):-combinar(CaballosPosibles, Caballos).
combinar([_|CaballosPosibles], Caballos):-combinar(CaballosPosibles, Caballos).