% pertenece(Gato, Clan)
pertenece(estrellaDeFuego, clanDelTrueno).
pertenece(estrellaAzul, clanDelTrueno).
pertenece(tormentaDeArena, clanDelTrueno).
pertenece(patasNegras, fufu).

% gato(Gato, EdadEnLunas, EnemigosALosQueVenció)
gato(tormentaDeArena, 6, []).

gato(estrellaDeFuego, 6, [estrellaRota, patasNegras, corazonDeRoble]).
gato(estrellaAzul, 6, [tormentaDeArena]).

% esDe(Clan, Zona)
esDe(clanDelTrueno, granSicomoro).
esDe(clanDelTrueno, rocasDeLasSerpientes).
esDe(clanDelTrueno, hondonadaArenosa).
esDe(clanDelViento, cuatroArboles).
esDe(clanDelRio, rocasSoleadas).
esDe(clanDeLaSombra, vertedero).
patrulla(fofo, rocasSoleadas).


% patrulla(Gato, Zona)
patrulla(estrellaDeFuego, rocasSoleadas).
patrulla(fifi, rocasSoleadas).
patrulla(fufu, rocasSoleadas).
patrulla(fafa, rocasSoleadas).
patrulla(fefe, rocasSoleadas).
patrulla(fofo, rocasSoleadas).
patrulla(tormentaDeArena, cuatroArboles).
patrulla(patasNegras, cuatroArboles).


% Posibles presas de los gatos:
% ave(TipoDeAve, AltitudDeVuelo)
% pez(OceanoDondeVive)
% rata(Nombre, Profesión, Altura)

% seEncuentra(Presa, Zona)
seEncuentra(ave(paloma, 5), cuatroArboles).
seEncuentra(ave(quetzal, 15), rocasDeLasSerpientes).
seEncuentra(pez(atlantico), granSicomoro).
seEncuentra(rata(ratatouille, cocinero, 15), cocinaParisina).
seEncuentra(rata(pinky, cientifico, 22), laboratorio).


%* 1. esTraidor(unGato).

delMismoClan(Gato, OtroGato):-
    pertenece(Gato, Clan),
    pertenece(OtroGato, Clan).
    % Gato \= OtroGato.

seEnfrento(Gato, OtroGato):-
    pertenece(OtroGato, _),
    % gato(OtroGato, _, _), %! Porque rompe aca!!!=????
    %* Sin este de arriba, me muestra todos los gatos con que se enfrento 
    %* Este en teoria esta bien, porque queres ver si OtroGato esta dentro de Peleados
    gato(Gato, _, Peleados),
    member(OtroGato, Peleados).



esTraidor(Gato):-
    delMismoClan(Gato, OtroGato),
    seEnfrento(Gato, OtroGato).



%* 2. sePuedenEnfrentar(Gato, OtroGato).

sePuedenEnfrentar(Gato, OtroGato):-
    patrulla(Gato, Zona),
    patrulla(OtroGato, Zona),
    not(delMismoClan(Gato,OtroGato)).
    % Gato \= OtroGato. %!Porque no es necesario el \=

esConcurrido(cuatroArboles).
esConcurrido(Zona):-
    patrulla( _, Zona),
    findall(Gato, patrulla(Gato, Zona), Gatos),
    length(Gatos, CantGatos),
    CantGatos > 5.


%*4. esMiedoso(Gato).
esMiedoso(Gato):-
    pertenece(Gato, Clan),
    forall(patrulla(Gato, Zona),esDe(Clan, Zona)).
    % forall(esDe(Clan, Zona), patrulla(Gato, Zona)).
    %! Creo que en este caso no cambia mucho si patrulla() o 
    %! esDe() vam primero o segundo

%*5. esTravieso(Gato).
esTravieso(Gato):-
    patrulla(Gato, _),
    forall(patrulla(Gato, Zona), esConcurrido(Zona)).

esTravieso(Gato):-
    gato(Gato, Edad, _),
    Edad < 6.

esTravieso(estrellaDeFuego).


%*6. puedeAtrapar(Gato, Presa).


esBuenaPresa(ave(paloma, _)).
esBuenaPresa(ave(_ , AltitudDeVuelo)):-
    AltitudDeVuelo > 10.
esBuenaPresa(rata(ratatouille, cocinera, 15)).
%! Se puede achicar MAS!! y seria polimofirmo como la profe quiere
%* La idea es que el functore sea el argumento
% esBuenaPresa(Presa):-
%     seEncuentra(ave(TipoDeAve, Altitud), _),
%     Altitud < 10.

% esBuenaPresa(Presa):-
%     seEncuentra(ave(_), _).

% esBuenaPresa(Presa):-
%     seEncuentra(rata(ratatouille, _, _), _).

puedeAtrapar(Gato, Presa):-
    gato(Gato, _, _),
    seEncuentra(Presa, _),
    not(esMiedoso(Gato)),
    esBuenaPresa(Presa).


%*7. experiencia(Gato, Experiencia).
experiencia(Gato, Experiencia):-
    gato(Gato, EdadLunares, _),
    cantEnemigosVencidos(Gato, CantVencidos),
    % findall(Enemigo, gato(Gato, _ , Enemigo), Enemigos), %! Repetí logica con el siguiente
    % length(Enemigos, CantEnemigos),
    Experiencia is CantVencidos * EdadLunares.


%*8. ganoUnEnfrentamiento(Gato, OtroGato).

cantEnemigosVencidos(Gato, CantVencidos):-
    findall(Vencido, gato(Gato, _, Vencido), Vencidos),
    length(Vencidos, CantVencidos). 

ganoUnEnfrentamiento(Gato, OtroGato):-
    cantEnemigosVencidos(Gato, CantVencidos),
    cantEnemigosVencidos(OtroGato, OtroCantVencidos),
    CantVencidos > OtroCantVencidos.

%! No es necesario el Gato \= OtroGato porque es un ">" y ese no contempla que sean iguales