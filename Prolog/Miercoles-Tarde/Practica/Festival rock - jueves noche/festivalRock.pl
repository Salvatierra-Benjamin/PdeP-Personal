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
careta(personalFest).
careta(Festival):-
    festival(Festival, _ , _),
    not(entradaVendida(Festival, campo)).

%*3. nacAndPop(Festival).
sonArgentinaYPopular(Bandas):-
    banda(Bandas, argentina, Popularidad),
    Popularidad > 1000.

nacAndPop(Festival):-
    festival(Festival, _, _),
    not(careta(Festival)),
    forall(festival(Festival, Bandas, _), sonArgentinaYPopular(Bandas)).

%! ASI LO HIZO EL PELA
% nacAndPop(Festival):-
%     festival(Festival, Bandas),
%     forall(member(Banda, Bandas),  (banda(Banda, argentina, Popularidad), Popularidad >1000)).


% %*4. sobreVendido(Festival).
% sobreVendido(Festival):-
%     festival(Festival, _, Lugar),
%     forall(lugar(Lugar, Capacidad), )

%? Yo no quiero que esto sea inversible
cantVendidos(Festivales, CantVendido):-
    findall(Festivales, entradaVendida(Festivales,_), Total),
    length(Total, CantVendido).


sobreVendido(Festival):-
    festival(Festival, _, Lugar),
    lugar(Lugar, CapMax, _),
    cantVendidos(Festival, CantVendido),
    CantVendido > CapMax.


%! Forma que la hizo el pelado
% sobreVendido(Festival):-
%     festival(Festival, _, Lugar),
%     lugar(Lugar, Capacidad, _),
%     findall(Entrada, entradaVendida(Festival, Entrada), Entradas),
%     length(Entradas, Cantidad),
%     Cantidad > Capacidad.


%*5. recaudacionTotal(Festival, Total).


%! Cunado me meti al findall, perdi la informacion del lugar, por lo tanto 
%! repeti mucha logica en el auxiliar.

% precioPorEntrada(campo, Precio):-
%     entradaVendida(Lugar, campo),
%     lugar(Lugar, _, Precio).

% precioPorEntrada(plateaGeneral(Zona), Precio):-
%     entradaVendida(Lugar, campo),
%     lugar(Lugar, _, PrecioBase),
%     plusZona(Lugar, Zona, Recargo),
%     Precio is PrecioBase + Recargo.

% precioPorEntrada(plateaNumerada(Fila), Precio):-
%     entradaVendida(Lugar, campo),
%     lugar(Lugar, _, PrecioBase),
%     Precio is PrecioBase *3,
%     Fila > 10.

% precioPorEntrada(plateaNumerada(Fila), Precio):-
%     entradaVendida(Lugar, campo),
%     lugar(Lugar, _, PrecioBase),
%     Precio is PrecioBase *6,
%     Fila >= 10.


% % recaudacionTotal(Festival, Total):-
% %     findall(Precio, (festival(Festival, _, Lugar), lugar(Lugar, _, PrecioBase),
% %             entradaVendida(Lugar, Entrada), precioPorEntrada(Entrada, Lugar, Precio)), Total).

% recaudacionTotal2(Festival, Total):-
%     festival(Festival, _, Lugar),
%     %! ACA PERDI LUGAR Y COMO ESTOY VIENDO EN EL PRECIOpOReNTRADA, LA DATA DEL LUGAR
%     %! POR LO TANTO LO QUE QUIERO ES LIGAR LUGAR ANTES.
%     %! asi precioPorEntrada tendra 3 variables.
%     findall(Precio, (entradaVendida(Lugar, Entrada), precioPorEntrada(Entrada, Precio)), Precios),
%     sumlist(Precios, Total).


precioPorEntrada(campo, Lugar, Precio):-
    lugar(Lugar, _, Precio).


precioPorEntrada(plateaGeneral(Zona), Lugar, Precio):-
    lugar(Lugar, _, PrecioBase),
    plusZona(Lugar, Zona, Recargo),
    Precio is PrecioBase + Recargo.

precioPorEntrada(plateaNumerada(Fila), Lugar, Precio):-
    lugar(Lugar, _, PrecioBase),
    Precio is PrecioBase *3,
    Fila > 10.

precioPorEntrada(plateaNumerada(Fila), Lugar, Precio):-
    lugar(Lugar, _, PrecioBase),
    Precio is PrecioBase *6,
    Fila =< 10.


recaudacionTotal(Festival, Total):-
    festival(Festival, _, Lugar),
    findall(Precio, (entradaVendida(Festival, Entrada),precioPorEntrada(Entrada, Lugar, Precio)),
            Precios),
    sumlist(Precios, Total).
    
%* delMismoPalo/2 es punto de recursividad, cosa que ya no se evalua.