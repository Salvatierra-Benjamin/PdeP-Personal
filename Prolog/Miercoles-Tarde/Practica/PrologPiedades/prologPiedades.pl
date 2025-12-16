%propiedad(Dueño,   vivienda).
propiedad(juan,     casa(120)).
propiedad(nico,     dept(3, 2)).
propiedad(alf,      dept(3, 1)).
propiedad(julian,   loft(2000)).
propiedad(vale,     dept(4, 1)).
propiedad(fer,      casa(110)).
deseaMudarse(rocio, casa(90)).

% casa(metrosCuadrado).
% dept(cantAmbientes, cantBanio).
% loft(anioConstruido).

%viveEn(Duenio, Barrio)
viveEn(alf,     almagro).
viveEn(juan,    almagro).
viveEn(nico,    almagro).
viveEn(julian,  almagro).
viveEn(vale,    flores).
viveEn(fer,     flores).

barrio(almagro).
barrio(flores).

%* esCopado(Propiedad).

esPropiedadCopada(casa(MetrosCuadrado)):-
    MetrosCuadrado > 100.

esPropiedadCopada(dept(Ambientes, _)):-
    Ambientes > 3.

esPropiedadCopada(dept(_, CantBanio)):-
    CantBanio > 1.

esPropiedadCopada(loft(AnioConstruido)):-
    AnioConstruido > 2015.

esCopado(Barrio):-
    barrio(Barrio),
    %* usar este
    forall( viveEn(Duenio, Barrio),
            (propiedad(Duenio, Propiedad), esPropiedadCopada(Propiedad))).
    
    %! “Para toda persona que vive en el barrio y de la que sabemos su propiedad, esa propiedad es copada”.
    % forall( (viveEn(Duenio, Barrio),propiedad(Duenio, Propiedad)),
    %         esPropiedadCopada(Propiedad)).


%* esCaro(Barrio).
esBarato(loft(AnioConstruido)):-
    AnioConstruido < 2005.
esBarato(casa(MetrosCuadrado)):-
    MetrosCuadrado < 90.
esBarato(dept(1,_)).
esBarato(dept(2,_)).
 

esCaro(Barrio):-
    barrio(Barrio),
    forall( viveEn(Duenio, Barrio), 
            (propiedad(Duenio, Propiedad), not(esBarato(Propiedad)))).



%* Tasa, tasa, tasacion de la cas
tasacion(juan,      150000).
tasacion(nico,      80000).
tasacion(alf,       75000).
tasacion(julian,    140000).
tasacion(vale,      95000).
tasacion(fer,       60000).

sublista([],[]).
sublista([_|Cola], Sublista):-sublista(Cola,Sublista).
sublista([Cabeza|Cola],[Cabeza|Sublista]):-sublista(Cola,Sublista).


comprar(Plata, CasaPosibles, PlataRestante):-
    findall(Propiedades, propiedad(_ , Propiedades), Propiedades),
    propiedadPosible(Propiedades, Plata, CasasPosibles),
    findall(Valor, (member(Casa, CasasPosibles), tasacionDeLa(Casa, Valor)), ListaDeValores),
    sumlist(ListaDeValores, Valores),
    PlataRestante is Plata - Valores.

tasacionDeLa(Casa, Valor):-
    propiedad(Persona, Casa),
    tasacion(Persona, _).




propiedadPosible([], _, []).

propiedadPosible([Propiedad | Propiedades], Plata, [Propiedad | Posibles]):-
    tasacionDeLa(Propiedad, Costo),
    Plata > Costo,
    PlataRestante is Plata - Costo,
    propiedadPosible(Propiedades, PlataRestante, Posibles).


propiedadPosible([_| Propiedades], Plata, Posible):-
    propiedadPosible(Propiedades, Plata, Posibles).
