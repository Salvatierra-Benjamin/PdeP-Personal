problematico(bart).

padre(homero, bart).
% padre(homero, lisa).

estaComplicado(Persona):-
    padre(Persona, Hijo),
    problematico(Hijo).

% PARA VER QUE TODOOOS LOS HIJOS DE UN PADRE SON PROBLEMATICO
% PODEMOS USAR EL FORALL 
estaHarto(Persona):-
    padre(Persona, _),
    forall(padre(Persona, Hijo), problematico(Hijo)).