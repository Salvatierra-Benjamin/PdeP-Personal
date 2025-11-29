% guardia(Nombre) 
guardia(bennett). 
guardia(mendez). 
guardia(george). 
 
% prisionero(Nombre, Crimen) 
prisionero(piper,       narcotrafico([metanfetaminas])). 
prisionero(alex,        narcotrafico([heroina])). 
prisionero(alex,        homicidio(george)). 
prisionero(red,         homicidio(rusoMafioso)). 
prisionero(suzanne,     robo(450000)). 
prisionero(suzanne,     robo(250000)). 
prisionero(suzanne,     robo(2500)). 
prisionero(dayanara,    narcotrafico([heroina, opio])). 
prisionero(dayanara,    narcotrafico([metanfetaminas])).

%*1. Es inversible?
%! No es inversible por Guarda. Este no esta ligado a nada 
%! antes de entrar al not.
% controla(Controlador, Controlado).
controla(piper, alex).
controla(bennett, dayanara).
% controla(Guardia, Otro):-
%     prisionero(Otro, _),
%     not(controla(Otro, Guardia)).
controla(Guardia, Otro):-
    guardia(Guardia),
    prisionero(Otro, _),
    not(controla(Otro, Guardia)).
  

%*2. conflictoDeInteres(Persona, OtraPersona).

% Genero persona para que me llegen ligadas en el 
% conflictoDeInteres/2

%! No es necesario, puedo poner Persona y ya se encarga el motor de que 
%! sea prisionero o persona
% esPersona(Persona):- 
%     guardia(Persona).
% esPersona(Persona):-
%     prisionero(Persona,_).

% conflictoDeInteres(Persona, OtraPersona):-
%     esPersona(Persona),
%     esPersona(OtraPersona),
%     not(controla(Persona, OtraPersona)),
%     controla(Persona, Tercero),
%     controla(OtraPersona, Tercero),
%     Persona \= Tercero,
%     Tercero \= OtraPersona,
%     Persona \= OtraPersona.

%? Puedo simplemente mover los controla(), es una forma de arreglarlo y no tener
%? que crear el predicado esPersona()
%? No es tan declarativo como el lenguaje coloquial, no importa que va primero.
conflictoDeInteres(Persona, OtraPersona):-
    controla(Persona, Tercero),
    controla(OtraPersona, Tercero),
    not(controla(Persona, OtraPersona)),
    not(controla(OtraPersona, Persona)),   
    % Persona \= Tercero,
    % Tercero \= OtraPersona,
    Persona \= OtraPersona. %? CUIDADO. Siempre poner el distinto al final 
    %? porque no es inversible.


%*3. peligroso(Preso).

%! HORRIBLEEE. No se aprovecha el polimorfismo
% drogasQueVendio(Preso, Drogas):-
%     prisionero(Preso, narcotrafico([Drogas])).
l% peligroso(Preso):-
%     prisionero(Preso, _),
%     drogasQueVendio(Preso, Drogas),
%     length(Drogas, cantDrogas),
%     cantDrgoas =< 5.

peligroso(Preso):-
    prisionero(Preso, _),
    forall(prisionero(Preso, Crimen), esGrave(Crimen)).

%? esGrave no es inversible pero tampoco necesito que lo sea
esGrave(homicidio(_)).
esGrave(narcotrafico(Drogas)):-
    length(Drogas, CantDrogas),
    CantDrogas >= 5. 
esGrave(narcotrafico(Drogas)):-
    member(metanfetaminas, Drogas).




%*4. ladronDeGuanteBlanco(Preso).
% ladronDeGuanteBlanco(Preso):-
%     prisionero(Preso, _),
%     forall(prisionero(Preso, robo(CantRobado)), CantRobado >100000).

%! No le gusta al pelado porque checkeo de solo los robos, pero deberia de ver 
%! de todos los crimenes. 

montoCrimen(robo(Monto), Monto). % Con esto aseguro que solo sean robos "polimofirsmo"
ladronDeGuanteBlanco(Preso):-
    prisionero(Preso, _),
    forall(prisionero(Preso, Crimen), (montoCrimen(Crimen, Monto), Monto >100000)).


%*5. condena(Preso, Condena).

%! Nuevamente, no se esta usando la poderosa herramienta de polimorfismo.
% condenaPorCrimen(robo, Condena):-
%     prisionero(_ , robo(CantRobado)),
%     Condena is CantRobado/100.

% condenaPorCrimen(homicidio, Condena):-
%     prisionero(Preso, _),
%     findall(Victima, prisionero(Preso, homicidio(Victima)), Victimas),
%     length(Victimas, CantVictimas),
%     Condena is CantVictimas * 7.

% condenaPorCrimen(homicidio, Condena):-
%     prisionero(Preso, _),
%     findall(Victima, (prisionero(Preso, homicidio(Victima)), guardia(Victima)), Victimas),
%     length(Victimas, CantVictimas),
%     Condena is (CantVictimas * 7) + 2.

% condenaPorCrimen(robo, Condena):-
%     prisionero(Preso, _),
%     findall(Drogas, drogasQueVendio(Preso, Drogas), TotalDrogas),
%     length(TotalDrogas, CantDrogas),
%     Condena is CantDrogas * 2.


% condena(Preso, Condena):-
%     prisionero(Preso, _),
%     findall(Condenas, condenaPorCrimen(_, CondenaPorCrimen), TodasCondenas),
%     sum_list(TodasCondenas, Condena).


pena(robo(Monto), Pena):-
    Pena is Monto/1000.

pena(homicidio(Victima), 9):-
    guardia(Victima). 

%? Este segundo tengo que meterle el not(guardia()) para que sea
%? excluyente al anterior de 7.
pena(homicidio(Victima), 7):-
    not(guardia(Victima)).

pena(narcotrafico(Drogas), Pena):-
    length(Drogas, CantDrogas),
    Pena is CantDrogas*2.

condena(Prisionero, Condena):-
    prisionero(Prisionero,_),
    %? Con pena es donde utilizo polimorfismo. Le llegara crimen 
    %? y pena/2 sobra como responder
    findall(Pena, (prisionero(Prisionero, Crimen), pena(Crimen, Pena)), Penas),
    sumlist(Penas, Condena).


%*6. capoDiTutiLiCapi(Preso).
% capoDiTutiLiCapi(Preso):-
%     prisionero(Preso,_),
%     not(controla(_, Preso)),
%     esPersona(Controlado),
%     controla(Preso, Controlado).
%!falta el "o por alguien a quien el controla"

esPersona(Persona):- guardia(Persona).
esPersona(Persona):- prisionero(Persona, _).

% es la forma "directa", ya estaba usadao
controlaDirectamenteOIndirectamente(Uno, Otro):- controla(Uno, Otro). 

% % Forma indirecta. Es la relacion transitiva. 
% controlaDirectamenteOIndirectamente(Uno, Otro):- 
%     controla(Uno, Tercero),
%     controla(Tercero, Otro). %!ESTA MAL. Solo se cumplira para un par de niveles
%     %! pero se desea que sea "recursivo" o de niveles infinitos.  

%? Forma indirecta. Es la relacion transitiva. 
controlaDirectamenteOIndirectamente(Uno, Otro):- 
    controla(Uno, Tercero),
    controlaDirectamenteOIndirectamente(Tercero, Otro).
%? este si se cumplirá para varios de niveles.


capo(Capo):-
    prisionero(Capo,_),
    not(controla(_, Capo)),
    forall((esPersona(Persona), Persona \= Capo), controlaDirectamenteOIndirectamente(Capo, Persona)).


asdnasdjkbajsbdajkbsd asdasdaSdAsdadas
as
d
asd
asd
a
sda
sd
asd
as
das

asda
sdas
d