% receta(Plato, Duracion, [Ingredientes]).

receta(empandaDeCarneFrita, 29, [harina, carne, cebolla, picante, aceite]).
receta(empandaDeCarneAlHorno, 20, [harina, carne,cebolla, picante]).
receta(lomoALaWellington, 125, [lomo, hoaldre, huevo, mostaza]).
receta(pastaTrufada, 40, [spaghetti, crema, trufa]).
receta(souffleDeQueso, 35, [harina, manteca, leche, queso]).
receta(tiramisu, 30, [vainilla, cafe, mascarpone]).
receta(rabas, 20, [calamar, harina, sal]).
receta(parrilladaDelMar, 40, [salmon, langostinos, mejillones]).
receta(sushi, 30, [arroz, salmon, sesamo, algaNori]).
receta(hamburguesa, 15, [carne, pan, cheddar, huevo, panceta, trufa]).
receta(padThai, 40, [fideos, langostinos, vegetales]).

% elabora(Chef, Plato).
elabora(guille, empandaDeCarneFrita).
elabora(guille, empandaDeCarneAlHorno).
elabora(vale, rabas).
elabora(vale, tiramisu).
elabora(vale, parilladaDelMar).
elabora(ale, hamburguesa).
elabora(lu, sushi).
elabora(mar, padThai).

% cocinaEn(Restaurante, Chef).
cocinaEn(pinpun, guille).
cocinaEn(laPececita, vale).
cocinaEn(laParolacha, vale).
cocinaEn(sushiRock, lu).
cocinaEn(olakease, lu).
cocinaEn(guendis, ale).
cocinaEn(cantin, mar).

% tieneEstilo(Restaurante, Estilo).
tieneEstilo(pinpun, bodegon(parqueChas, 6000)).
tieneEstilo(laPececita, bodegon(palermo, 20000)).
tieneEstilo(laParolacha, italiano(15)).
tieneEstilo(sushiRock, oriental(japon)).
tieneEstilo(olakease, oriental(japon)).
tieneEstilo(cantin, oriental(tailandia)).
tieneEstilo(cajaTaco, mexicano([habanero, rocoto])).
tieneEstilo(guendis, comidaRapida(5)).

% Posibles estilos
% italiano(CantidadDePastas).
% oriental(Pais).
% bodegon(Barrio, PrecioPromedio).
% mexicano(VariedaDeAjies).
% comidaRapida(cantidaDecombos).


% Ej 1

esCrack(Cheff):-
    cocinaEn(Restaurante, Cheff),
    cocinaEn(OtroRestaurante, Cheff),
    Restaurante \= OtroRestaurante.
esCrack(Cheff):-
    elabora(Cheff, padThai).

% 21 ?- esCrack(Cheff).
% Cheff = vale ;
% Cheff = vale ;
% Cheff = lu ;
% Cheff = lu ;
% Cheff = mar.

% Ej 2

esOtaku(Cheff):-
    cocinaEn(_, Cheff),
    forall(cocinaEn(Restaurante, Cheff), tieneEstilo(Restaurante, oriental(japon))).

% 11 ?- esOtaku(Chef).
% Chef = lu ;
% Chef = lu ;

% Ej 3
esTop(Plato):-
    elabora(_, Plato),
    % cocinaEn(_,Chef),
    forall(elabora(Cheff, Plato), esCrack(Cheff)).
    % forall(esCrack(Chef), elabora(Chef,Plato)).

% 20 ?- esTop(Plato).
% Plato = rabas ;
% Plato = tiramisu ;
% Plato = parilladaDelMar ;
% Plato = sushi ;
% Plato = padThai. %% POR QUE lo cocina mar

% ej 4
esDificil(Plato):-
    receta(Plato, Duracion, _),
    Duracion > 120.
esDificil(Plato):-
    receta(Plato, _, Ingredientes),
    member(trufa, Ingredientes).
esDificil(souffleDeQueso).

% ?- esDificil(Plato).
% Plato = lomoALaWellington ;   % dura mas de 2 horas
% Plato = pastaTrufada ;        % tiene trufa
% Plato = hamburguesa ;         % tiene trufa
% Plato = souffleDeQueso.       % es souffleDeQueso

% EJ 5

seMereceLaMichelin(Restaurante):-
    cocinaEn(Restaurante, Cheff),       % liga un restaurante con un cheff
    esCrack(Cheff),                     % se queda con los restaurantes que tiene un Crack(osea mar)
    tieneEstilo(Restaurante, Estilo),        % del restaurante que tiene un crack saca el estilo
    % tieneEstiloMichelinero(Restaurante).
    estiloMichilinero(Estilo).          % condicion de que el restaurante tenga estilo de michelini

% OPCION ANALIZAR LOS ESTILOS COMO INDIVIDUOS
estiloMichilinero(oriental(tailandia)).
estiloMichilinero(bodegon(palermo, _)).
estiloMichilinero(italiano(CantidadDePastas)):-
    CantidadDePastas > 5.
estiloMichilinero(mexicano(VariedadDeAjies)):-
    member(habanero, VariedadDeAjies),
    member(rocoto, VariedadDeAjies).

% ?- seMereceLaMichelin(Restaurante).
% Restaurante = laPececita ;
% Restaurante = laPececita ;
% Restaurante = laParolacha ;
% Restaurante = laParolacha ;
% Restaurante = cantin.
    
% OPCION ANALIZAR LOS RESTAURANTES

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESTA HORRIBLEE
% porque es 1. repetir demasiado logica, 2. se puede hacer con los functores
% pero no son inversibles, pero si la funciones principal
% tieneEstiloMichelinero(Restaurante):-
%     tieneEstilo(Restaurante, oriental(tailandia)).
% tieneEstiloMichelinero(Restaurante):-
%     tieneEstilo(Restaurante, bodegon(palermo, _)).
% tieneEstiloMichelinero(Restaurante):-
%     tieneEstilo(Restaurante, italiano(CantidadDePastas)),
%     CantidadDePastas > 5.
% tieneEstiloMichelinero(Restaurante):-
%     tieneEstilo(Restaurante, mexicano(VariedadDeAjies)),
%     member(habanero, VariedadDeAjies),
%     member(rocoto, VariedadDeAjies).




% EJ 6 

tieneMayorRepertorio(UnRestaurante, OtroRestaurante):-
    cantidadDePlatos(UnRestaurante, CantUnRestauranatePlatos),  %suponiendo que un restaurante solo tiene un Cheff
    cantidadDePlatos(OtroRestaurante, CantOtroRestaurantePlatos),
    CantUnRestauranatePlatos > CantOtroRestaurantePlatos.


% 38 ?- tieneMayorRepertorio(UnRestaurante, OtroRestaurante).
% UnRestaurante = pinpun,
% OtroRestaurante = sushiRock ;
% UnRestaurante = pinpun,
% OtroRestaurante = olakease ;
% UnRestaurante = pinpun,
% OtroRestaurante = guendis ;
% UnRestaurante = pinpun,
% OtroRestaurante = cantin ;
% UnRestaurante = laPececita,
% OtroRestaurante = pinpun ;
% UnRestaurante = laPececita,
% OtroRestaurante = sushiRock ;
% UnRestaurante = laPececita,
% OtroRestaurante = olakease ;
% UnRestaurante = laPececita,
% OtroRestaurante = guendis ;
% UnRestaurante = laPececita,
% OtroRestaurante = cantin ;
% UnRestaurante = laParolacha,
% OtroRestaurante = pinpun ;
% UnRestaurante = laParolacha,
% OtroRestaurante = sushiRock ;
% UnRestaurante = laParolacha,
% OtroRestaurante = olakease ;
% UnRestaurante = laParolacha,
% OtroRestaurante = guendis ;
% UnRestaurante = laParolacha,
% OtroRestaurante = cantin ;


cantidadDePlatos(Restaurante, CantPlatos):-
    % elabora(Cheff, _),
    cocinaEn(Restaurante, Cheff),
    findall(Platos, 
            (elabora(Cheff, Platos)), 
            ListaDePlatos),
    length(ListaDePlatos, CantPlatos).

% 40 ?- cantidadDePlatos(Restaurante, Cant).
% Restaurante = pinpun,
% Cant = 2 ;
% Restaurante = laPececita,
% Cant = 3 ;
% Restaurante = laParolacha,
% Cant = 3 ;
% Restaurante = sushiRock,
% Cant = 1 ;
% Restaurante = olakease,
% Cant = 1 ;
% Restaurante = guendis,
% Cant = 1 ;
% Restaurante = cantin,
% Cant = 1.



% EJ 7 
restaurante(Restaurante):-
    tieneEstilo(Restaurante, _).

calificacionGastronomica(Restaurante, Calificacion):-
    cantidadDePlatos(Restaurante, CantidadDeplatos),
    % restaurante(Restaurante),
    Calificacion is CantidadDeplatos * 5.

% ?- calificacionGastronomica(Restaurante, Calificacion).
% Restaurante = pinpun,
% Calificacion = 10 ;
% Restaurante = laPececita,
% Calificacion = 15 ;
% Restaurante = laParolacha,
% Calificacion = 15 ;
% Restaurante = sushiRock,
% Calificacion = 5 ;
% Restaurante = olakease,
% Calificacion = 5 ;
% Restaurante = guendis,
% Calificacion = 5 ;
% Restaurante = cantin,
% Calificacion = 5.