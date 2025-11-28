% festival(NombreDelFestival, Bandas, Lugar).
% Relaciona el nombre de un festival con la lista de los nombres de bandas que tocan en él y el lugar dónde se realiza.
festival(lollapalooza, [gunsAndRoses, theStrokes, littoNebbia], hipodromoSanIsidro).

% lugar(nombre, capacidad, precioBase).
% Relaciona un lugar con su capacidad y el precio base que se cobran las entradas ahí.
lugar(hipodromoSanIsidro, 85000, 3000).

% banda(nombre, nacionalidad, popularidad).
% Relaciona una banda con su nacionalidad y su popularidad.
banda(gunsAndRoses, eeuu, 69420).

% entradaVendida(NombreDelFestival, TipoDeEntrada).
% Indica la venta de una entrada de cierto tipo para el festival 
% indicado.
% Los tipos de entrada pueden ser alguno de los siguientes: 
%     - campo
%     - plateaNumerada(Fila)
%     - plateaGeneral(Zona).
entradaVendida(lollapalooza, campo).
entradaVendida(lollapalooza, plateaNumerada(1)).
entradaVendida(lollapalooza, plateaGeneral(zona2)).

% plusZona(Lugar, Zona, Recargo)
% Relacion una zona de un lugar con el recargo que le aplica al precio de las plateas generales.
plusZona(hipodromoSanIsidro, zona1, 1500).


%*1. itinerario(Festival).
itinerario(Festival):-
    festival(Festival, Bandas, Lugar),
    festival(Festival, Bandas, OtroLugar),
    Lugar \= OtroLugar.

%*2. careta(Festival).
careta(Festival):-
    festival(personalFest, _, _).
careta(Festival):-
    festival(Festival,_ , _),
    not(entradaVendida(Festival, campo)).

%*3. nacAndPop(Festival).
sonArgentinaYPopular(Bandas):-
    banda(Bandas, argentina, Popularidad),
    Popularidad > 1000.

nacAndPop(Festival):-
    not(careta(Festival)),
    forall(festival(Festival, Bandas, _), sonArgentinaYPopular(Bandas)).


%*4. sobreVendido(Festival).
sobreVendido(Festival):-
    festival(Festival, _, Lugar),
    forall(lugar(Lugar, Capacidad), )