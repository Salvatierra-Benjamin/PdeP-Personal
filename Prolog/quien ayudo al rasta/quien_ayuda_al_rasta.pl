% BASE DE CONOCIMIENTOS

persona(rasta).
persona(polito).
persona(santi).

/*
lo quiere y tengo más suerte => Ayudo

Polito = Rasta
Rasta -> Santi (todos menos Polito)
Polito -> Santi
Santi -> Polito (todos quienes no quieran el Rasta)

Suerte:
(Santi = Rasta) > Polito

- Rasta ayuda a: Polito y Santi
- Polito ayda a: nadie
- Santi ayuda a: Polito

*/

% a quien ayudo?

quiere(rasta,Companiero):-
    persona(Companiero),
    Companiero \= polito,
    Companiero \= rasta.

quiere(polito, Companiero):-
    persona(Companiero),
    Companiero \= polito,
    Companiero \= rasta.

quiere(santi, Companiero):-
    persona(Companiero),
    not(quiere(rasta,Companiero)).

% SUERTE

masSuerte(rasta, Companiero):-
    persona(Companiero),
    Companiero \= polito. 

masSuerte(santi, Companiero):-
    persona(Companiero),
    Companiero \= polito. 
masSuerte(polito, Companiero):-
    Companiero \= santi,
    Companiero \= polito,
    Companiero \= rasta.
    

% ayuda(Ayudador, ayudado)

ayuda(Ayudador, Ayudado):-
    quiere(Ayudador, Ayudado),
    masSuerte(Ayudador, Ayudado).