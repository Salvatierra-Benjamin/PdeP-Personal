%% PARTE 1

% descripcionMago(mago, caracteristicasDeMago, statusSangre, odiaEstaCasa).

descripcionMago(harry, sangreMestiza, caracteristicas(corajudo, amistoso, orgulloso, inteligente), slytherin).
descripcionMago(draco, sangrePura, caracteristicas(inteligente, orgullo, noCorajudo, noAmistoso), hugglepuff).
descripcionMago(hermione, sangrePura, caracteristicas(inteligente, orgullosa, responsable), _).

caracteristicas(harry, [coraje, amistoso, orgullo, inteligencia]).
caracteristicas(draco, [inteligencia, orgullo, noCorajudo, noAmistoso]).
caracteristicas(hermione, [inteligencia, orgullosa, responsable]).
caracteristicas(harry, coraje).
caracteristicas(harry, amistoso).
caracteristicas(harry, orgullo).
caracteristicas(harry, inteligencia).
caracteristicas(draco, inteligencia).
caracteristicas(draco, orgullo).
caracteristicas(draco, noCorajudo).
caracteristicas(harry, noAmistoso).
caracteristicas(hermione, inteligencia).
caracteristicas(hermione, orgullosa).
caracteristicas(hermione, responsable).
caracteristicas(harry, coraje).


criterioSeleccion(gryffindor, coraje).
criterioSeleccion(slytherin, orgullo).
criterioSeleccion(slytherin, inteligencia).
criterioSeleccion(ravenclaw, inteligencia).
criterioSeleccion(ravenclaw, inteligencia).
criterioSeleccion(hufflepuff, amistoso).

casa(gryffindor).
casa(slytherin).
casa(hufflepuff).
casa(ravenclaw).

sangre(harry, mestiza).
sangre(draco, pura).
sangre(hermione, impura).

mago(Mago):-
    sangre(Mago,_).

% 

% EJ 1 

permiteEntrar(Casa, _):-
    casa(Casa),
    Casa \= slytherin.


permiteEntrar(slytherin, Mago):-
    sangre(Mago, Sangre),
    Sangre \= impura.


% EJ 2
num(1).
num(2).
num(3).
num(6).

% tieneCaracterApropiado(Maga, Casa):-

% tieneCaracterApropiado(Mago, Casa):-
%     casa(Casa),
%     caracteristicas(Mago, Caracteristicas),
%     forall(criterioSeleccion(Casa, Caracteristica), 
%             member(Caracteristica, Caracteristicas)).


tieneCaracterApropiado(Mago, Caracteristicas):-
    caracteristicas(Mago, Caracteristica),
    member(Caracteristicas, Caracteristica).


tieneCaracteristicas(Mago, Caracteristicas):-
    findall(caracteristicas(Mago, Caracteristicas), tieneCaracterApropiado(Mago, Caracteristicas), Caracteristicas).
        



% PARTE 2



