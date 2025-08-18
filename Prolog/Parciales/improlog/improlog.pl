% integrande(grupo, integranteDeGrupo, instrumento)
integrante(sophieTrio,      sophie,     violin).
integrante(sophieTrio,      santi,      guitarra).
integrante(sophieTrio,      luis,       contrabajo).
integrante(vientosDelEste,  lisa,       saxo).
integrante(vientosDelEste,  lore,       saxo).
integrante(vientosDelEste,  sophie,     trompeta).
integrante(vientosDelEste,  santi,      saxo).
integrante(vientosDelEste,  benja,      pandereta).
integrante(vientosDelEste,  tomas,      bajo).
integrante(vientosDelEste,  santi,      guitarra).
integrante(jazzmin,         santi,      bateria).

% integrante(jazzmin,         lisa,       contrabajo). 
% integrante(jazzmin,         lisa,       bateria). 


% nivelQueTiene(persona, instrumento, rangoDe)
nivelQueTiene(sophie,   violin, 5).
nivelQueTiene(santi,    guitarra, 2).
nivelQueTiene(santi,    voz, 3).
nivelQueTiene(santi,    bateria, 4).
nivelQueTiene(lisa,     saxo, 4).
nivelQueTiene(lore,     violin, 4).
nivelQueTiene(luis,     trompeta, 1).
nivelQueTiene(luis,     contrabajo, 4).

% instrmento(persona, rol)
instrumento(violin,     melodico(cuerdas)).
instrumento(guitarra,   armonico).
instrumento(bateria,    ritmico).
instrumento(saxo,       melodico(viento)).
instrumento(trompeta,   melodico(viento)).
instrumento(contrabajo, armonico).
instrumento(bajo,       armonico).
instrumento(piano,      armonico).
instrumento(pandereta,  ritmico).
instrumento(voz,        melodico(vocal)).


%% unaBuenaBase(Grupo)

%% ritmico y armonico
% tocaArmonico(Artista):-
%     integrante(_, Artista, Instrumento),
%     instrumento(Instrumento, armonico).

% tocaRitmico(Artista):-
%     integrante(_, Artista, Instrumento),
%     instrumento(Instrumento, ritmico).

cumpleRolEnBanda(Grupo, Artista, Rol):-
    integrante(Grupo, Artista, Instrumento),
    instrumento(Instrumento, Rol).


% tocaArmonico(Artistia):-
    
unaBuenaBase(Grupo):-
    cumpleRolEnBanda(Grupo, UnArtista, ritmico),    
    cumpleRolEnBanda(Grupo, OtroArtista, armonico),
    UnArtista \= OtroArtista.

% EJ 2

% Artista, tiene 

nivelEnElGrupo(Artista, Grupo, Nivel):-
    integrante(Grupo, Artista, Instrumento), 
    % no se puede poner _ en instrmento pues se va a ligar santi con 
    % su bateria(6) y fallara con sophie
    nivelQueTiene(Artista, Instrumento , Nivel).

seDestaca(Artista, Grupo):-
    nivelEnElGrupo(Artista, Grupo, Nivel),
    forall((nivelEnElGrupo(OtroArtista, Grupo, OtroNivel), Artista \= OtroArtista), 
            Nivel > OtroNivel +2 ).



% grupo(grupo, tipoDeGrupo).
grupo(vientosDelEste,   bigBand).
grupo(sophieTrio,       formacion([contrabajo, guitarra, violin])).
grupo(jazzmin,          formacion([bateria, bajo, trompeta, piano, guitarra])).


% grupo(sophieTrio,       contrabajo).
% grupo(sophieTrio,       guitarra).
% grupo(sophieTrio,       violin).
% grupo(jazzmin,          bateria).
% grupo(jazzmin,          bajo).
% grupo(jazzmin,          trompeta).
% grupo(jazzmin,          piano).
% grupo(jazzmin,          guitarra).


% PUNTO 4

% no importa el grupo
% no tiene que haber alguien que ya toque el instrumento
% y el instrumento sirve para el grupo

% hayCupo(Instrumento, Grupo):-
%     grupo(Grupo, bigBand),
%     esDeViento(Instrumento).
% hayCupo(Instrumento, Grupo):-
%     instrumento(Instrumento,_),
%     grupo(Grupo, TipoDeGRupo),
%     sirveInstrumento(TipoDeGRupo, Instrumento),
%     not(integrante(Grupo, _, Instrumento)).

% esDeViento(Instrumento):-
%     % integrante(_, Instrumento,_),
%     instrumento(Instrumento, melodico(viento)).

% % grupo(sophieTrio,       formacion([contrabajo, guitarra, violin])).

% sirveInstrumento(formacion(ListaDeIinstrumentosNecesitados), Instrumento):-
%     member(Instrumento, ListaDeIinstrumentosNecesitados).
% sirveInstrumento(bigBand, bateria).
% sirveInstrumento(bigBand, bajo).
% sirveInstrumento(bigBand, piano).



hayCupo(Instrumento, Grupo):-
    grupo(Grupo, bigBand),
    esDeViento(Instrumento).
hayCupo(Instrumento, Grupo):-
    instrumento(Instrumento, _),
    grupo(Grupo, TipoDeGrupo),
    sirveInstrumento(TipoDeGrupo, Instrumento),
    not(integrante(Grupo, _, Instrumento)).

esDeViento(Instrumento):-
    instrumento(Instrumento, melodico(viento)).
% 
sirveInstrumento(formacion(InstrumentosBuscados), Instrumento):-
    member(Instrumento, InstrumentosBuscados).

% sirveInstrumento(bigBand, Instrumento):-
%     esDeViento(Instrumento).

sirveInstrumento(bigBand, bateria).
sirveInstrumento(bigBand, bajo).
sirveInstrumento(bigBand, piano).





% EJERCICIO 5


%ROMPE
% integrande(grupo, integranteDeGrupo, instrumento)
% nivelQueTiene(persona, instrumento, rangoDe)

puedeIncorporarseBenjamin(Persona, Instrumento, Grupo):-
    not(integrante(Grupo, Persona, _)),
    hayCupo(Instrumento, Grupo),
    nivelQueTiene(Persona, Instrumento, NivelPersona),
    nivelNecesarioDeGrupo(Grupo, NivelEsperado),
    NivelPersona >= NivelEsperado.

% LE ORDEN REALMENTE FUNCIONA, PERO PORQUE, prolog al encontrar el falso
% de la negación ya hace todo falso??????

puedeIncorporarseReOrdenado(Persona, Instrumento, Grupo):-
    hayCupo(Instrumento, Grupo),
    nivelQueTiene(Persona, Instrumento, NivelPersona),
    not(integrante(Grupo, Persona, _)),
    nivelNecesarioDeGrupo(Grupo, NivelEsperado),
    NivelPersona >= NivelEsperado.


nivelNecesarioDeGrupo(Grupo, 1):-
    grupo(Grupo, bigBand).

nivelNecesarioDeGrupo(Grupo, NivelEsperado):-
    grupo(Grupo, formacion(InstrumentosBuscados)),
    length(InstrumentosBuscados, CantidadInstrumentosBuscados),
    NivelEsperado is 7 - CantidadInstrumentosBuscados.



% puedeIncorporarseProfe(Persona, Instrumento, Grupo):-
%     hayCupo(Instrumento, Grupo),
%     nivelQueTiene(Persona, Instrumento, NivelPersona),
%     not(integrante(Grupo, Persona, _)),
%     grupo(Grupo, TipoDeGrupo),
%     nivelMinimo(TipoDeGrupo, NivelEsperado),
%     NivelPersona >= NivelEsperado.

% nivelMinimo(bigBand, 1).
% nivelMinimo(formacion(Instrumentos), NivelMinimo):-
%     length(Instrumentos, CantidadInstrumentos),
%     NivelMinimo is 7 - CantidadInstrumentos.



% EJ 6


seQuedaEnBanda(Persona):-
    nivelQueTiene(Persona, _, _),
    not(integrante(_, Persona, _)),
    not(puedeIncorporarseBenjamin(Persona, _, _)).



% EJ 7 

% puedeTocar(Grupo):-
%     grupo(Grupo, bigBand),
%     necesidadesMinimas(TipoDeGrupo).



puedeTocar(Grupo):-
    grupo(Grupo, bigBand),
    unaBuenaBase(Grupo),
    findall(Persona, (integrante(Grupo, Persona, Instrumento), instrumento(Instrumento, 
        melodico(viento))), ListaDeArtistas),
    length(ListaDeArtistas, CantidaArtistasDeViento),

    % length(CantidaArtistasDeViento, ListaDeArtistas),
    CantidaArtistasDeViento >= 2.




puedeTocar(Grupo):-
    grupo(Grupo, formacion(ListaDeIinstrumentosNecesitados)),
    % integrante(Grupo, _, Instrumento),
    % Instrmento queres que se ligue con el segundo argumento, no con el integrante, CREO.
    forall(member(Instrumento,ListaDeIinstrumentosNecesitados), integrante(Grupo, _, Instrumento)).


% puedeTocar(Grupo):-
%     grupo(Grupo, bigBand),
%     unaBuenaBase(Grupo),
%     findall(TocaViento, (integrante(Grupo, TocaViento, Instrumento), esDeViento(Instrumento)),
%      TocanViento),
%     length(TocanViento, CantidadVientos),
%     CantidadVientos >= 5.

% puedeTocar(Grupo):-
%     grupo(Grupo, formacion(Instrumentos)),
%     forall(member(Instrumento, Instrumentos), integrante(Grupo, _, Instrumento)).