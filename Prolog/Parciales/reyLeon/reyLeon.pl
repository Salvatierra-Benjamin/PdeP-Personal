%comio(Personaje, Bicho)
comio(pumba, vaquitaSanAntonio(gervasia,3)).
comio(pumba, hormiga(federica)).
comio(pumba, hormiga(tuNoEresLaReina)).
comio(pumba, cucaracha(ginger,15,6)).
comio(pumba, cucaracha(erikElRojo,25,70)).

comio(timon, vaquitaSanAntonio(romualda,4)).
comio(timon, cucaracha(gimeno,12,8)).
% comio(timon, cucaracha(lucas,2,8)).       % para probar la funcion jugosita
comio(timon, cucaracha(cucurucha,12,5)).

comio(simba, vaquitaSanAntonio(remeditos,4)).
comio(simba, hormiga(schwartzenegger)).
comio(simba, hormiga(niato)).
comio(simba, hormiga(lula)).
% MALVADAS
comio(shenzi, hormiga(conCaraDeSimba)).

pesoHormiga(2).




%peso(Personaje, Peso)
peso(pumba, 100).
peso(timon, 50).
peso(simba, 200).
peso(scar, 300).
peso(shenzi, 400).
peso(banzai, 500).


personaje(Personaje):-
    peso(Personaje,_).

% Caracteristicas de los bichos
% vaquitasDeSanAntonio(Nombre, Peso).
% cucaracha(Nombre, Peso, Tamanio).
% hormiga(Nombre)



% EJ 1a

% pesoDeUnaCucaracha(Cucaracha, Peso):-
%     comio(_, cucaracha(Cucaracha, Peso, _)).

% jugosita(Cucaracha):-  %% NO tiene en cuenta el mismo tamanio
%     pesoDeUnaCucaracha(Cucaracha),
%     pesoDeUnaCucaracha(OtraCucaracha),
%     Cucaracha \= OtraCucaracha



jugosita(cucaracha(Nombre, Peso, Tamanio)):-
    comio(_, cucaracha(Nombre, Peso, Tamanio)),
    comio(_, cucaracha(OtraCucaracha, OtroPeso,Tamanio)),
    Nombre \= OtraCucaracha,
    Peso > OtroPeso.

% 13 ?- jugosita(cucaracha(Nombre, Peso, Tamanio)).
% Nombre = gimeno,
% Peso = 12,
% Tamanio = 8 ;
% false.

% EJ 1B

hormigofilico(Personaje):-
    comio(Personaje, hormiga(UnaHormiga)),
    comio(Personaje, hormiga(OtraHormiga)),
    UnaHormiga \= OtraHormiga.

% ?- hormigofilico(Personaje).
% Personaje = pumba ;
% Personaje = pumba ;
% Personaje = simba ;
% Personaje = simba ;
% Personaje = simba ;
% Personaje = simba ;
% Personaje = simba ;
% Personaje = simba ;

% EJ 1C

% personaje(Personaje):-
%     peso(Personaje,_).

cucarachofobico(Personaje):-
    personaje(Personaje),
    not(comio(Personaje, cucaracha(_,_,_))).

% ?- cucarachofobico(Personaje).
% Personaje = simba.

% EJ 1D

picarones(pumba).
picarones(Personaje):-
    comio(Personaje, cucaracha(Nombre, Peso, Tamanio)),
    jugosita(cucaracha(Nombre, Peso, Tamanio)).
picarones(Personaje):-
    comio(Personaje, vaquitaSanAntonio(remeditos,_)).


% ?- picarones(Personajes).
% Personajes = pumba ;
% Personajes = simba.
% se agrega timon si hay alguna jugosita en la base de conocimientos original


%%%% PARTE 2

persigue(scar, timon).
persigue(scar, pumba).
persigue(shenzi, simba).
persigue(shenzi, scar).
persigue(banzai, timon).

% peso(pumba, 100).
% peso(timon, 50).
% peso(simba, 200).
% peso(scar, 300).
% peso(shenzi, 400).
% peso(banzai, 500).

% comio(shenzi,hormiga(conCaraDeSimba)).

% pesoDeLaComida(Personaje, Peso)

pesoBicho(cucaracha(_, Peso, _), Peso).
pesoBicho(hormiga(_),Peso):- pesoHormiga(Peso).
pesoBicho(vaquitaSanAntonio(_, Peso), Peso).


% cuantoEngorda(Personaje, Peso):-
cuantoEngordaLaComidaQueComen(Personaje, Peso):-
    % personaje(Personaje),      
    % si saco personaje(Personaje), por alguna razón desaparece 
    % Personaje de las consultas
    findall(PesoBichos, 
        (comio(Personaje, Bicho), pesoBicho(Bicho,PesoBichos)),
        ListaDeBichos),
    sumlist(ListaDeBichos, Peso).


cuantoEngordaLoQuePersiguen(Personaje, PesoPerseguir):-
    % personaje(Personaje),
    % al igual que en la otra funcion, este no es inversible, 
    % pero al usarlo a en la principal si lo es
    findall(PesoSeguido, (persigue(Personaje, Seguido), peso(Seguido, PesoSeguido)), ListaDeSeguidos),
    sumlist(ListaDeSeguidos, PesoPerseguir).


cuantoEngorda(Personaje, Peso):-
    personaje(Personaje),
    % persigue(Personaje, Seguido),
    cuantoEngordaLaComidaQueComen(Personaje, PesoComiendo),
    cuantoEngordaLoQuePersiguen(Personaje, PesoPerseguir),
    Peso is PesoComiendo + PesoPerseguir.




% ?- cuantoEngorda(Personaje, Peso).
% Personaje = pumba,
% Peso = 47 ;
% Personaje = timon,
% Peso = 28 ;
% Personaje = simba,
% Peso = 10 ;
% Personaje = scar,
% Peso = 0 ;
% Personaje = shenzi,
% Peso = 2 ;
% Personaje = banzai,
% Peso = 0.



% PARTE B

% ?- cuantoEngorda(Personaje, Peso).
% Personaje = pumba,
% Peso = 47 ;
% Personaje = timon,
% Peso = 28 ;
% Personaje = simba,
% Peso = 10 ;
% Personaje = scar,
% Peso = 150 ;
% Personaje = shenzi,
% Peso = 502 ;
% Personaje = banzai,
% Peso = 50.

