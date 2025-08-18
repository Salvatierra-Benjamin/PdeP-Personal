% cada figura tiene un número y una imagen.
% cada imagen puede ser básica, brillante o rompecabezas

% básicas       --> pueden tener varios personajes
% brillantes    --> siempre un único personaje
% rompecabezas  --> dibujo no completo

% Formas de conseguir figuritas
%   1. Por un paquete   (interesa el orden de apertura)
%   2. Por otra persona (interesa quien la entregó)


% Base de conocimiento

% coleccionistas
coleccionista(andy).
coleccionista(flor).
coleccionista(bobby).
coleccionista(lala).
coleccionista(pablito).
coleccionista(toto).
coleccionista(juanchi).

% tieneLaCarta(coleccionista, #carta, metodo).

% % Andy


% tieneLaCarta(andy, dos, paquete).       % primer paquete
% tieneLaCarta(andy, cuatro, paquete).    % primer paquete
% tieneLaCarta(andy, siete, paquete).     % segundo paquete
% tieneLaCarta(andy, seis, paquete).      % segundo paquete
% tieneLaCarta(andy, ocho, paquete).      % tercer paquete
% tieneLaCarta(andy, uno, paquete).       % tercer paquete
% tieneLaCarta(andy, tres, paquete).      % tercer paquete
% tieneLaCarta(andy, cinco, paquete).     % tercer paquete
% tieneLaCarta(andy, uno, donada).

% % Flor
% tieneLaCarta(flor, cinco, donada).


% paqueteAbierto(coleccionista, #figura, #paquete)
% figuraDonada(receptor, #figura, emisor).

% Andy
paqueteAbierto(andy, dos, primerPaquete).
paqueteAbierto(andy, cuatro, primerPaquete).
paqueteAbierto(andy, siete, segundoPaquete).
paqueteAbierto(andy, seis, segundoPaquete).
paqueteAbierto(andy, ocho, tercerPaquete).
paqueteAbierto(andy, uno, tercerPaquete).
paqueteAbierto(andy, tres, tercerPaquete).
paqueteAbierto(andy, cinco, tercerPaquete).
paqueteAbierto(andy, uno, tercerPaquete).

figuraDonada(andy, uno, flor).

% Flor
paqueteAbierto(flor, cinco, segundoPaquete).
figuraDonada(flor, cuatro, andy).
figuraDonada(flor, siete, andy).
figuraDonada(flor, dos, bobby).


% Bobby
figuraDonada(bobby, uno, flor).
figuraDonada(bobby, cuatro, flor).
figuraDonada(bobby, seis, flor).
paqueteAbierto(bobby, tres, primerPaquete).
paqueteAbierto(bobby, cinco, primerPaquete).
paqueteAbierto(bobby, siete, segundoPaquete).

% Lala
paqueteAbierto(lala, tres, primerPaquete).
paqueteAbierto(lala, siete, primerPaquete).
paqueteAbierto(lala, uno, primerPaquete).
figuraDonada(lala, cinco, pablito).

% Pablito
figuraDonada(pablito, uno, lala).
figuraDonada(pablito, dos, toto).


% Toto
paqueteAbierto(toto, uno, primerPaquete).
figuraDonada(toto, seis, pablito).

% Juanchi
% NADA


% ----  1   ---- 

% tieneFigurita     --> fue recibida por alguien    o   de un paquete.

% tieneFigura(coleccionista, #figura).
tieneFigura(Colecionista, NumeroFigura):-
    paqueteAbierto(Colecionista,NumeroFigura,_).
tieneFigura(Colecionista, NumeroFigura):-
    figuraDonada(Coleccionista, NumeroFigura,_).


% ----  2   ---- 

% tieneRepetida     --> tiene cierta figura más de una vez. 

% tieneRepetida(colecionista, #figura).
tieneRepetida(Colecionista, NumeroFigura):-
    paqueteAbierto(Colecionista, NumeroFigura, NumeroPaquete),
    paqueteAbierto(Colecionista, NumeroFigura, OtroNumeroPaquete),
    NumeroPaquete\=OtroNumeroPaquete.
tieneRepetida(Colecionista, NumeroFigura):-
    figuraDonada(Colecionista, NumeroFigura,_),
    paqueteAbierto(Colecionista, NumeroFigura,_).
tieneRepetida(Colecionista, NumeroFigura):-
    figuraDonada(Colecionista, NumeroFigura, Emisor),
    figuraDonada(Colecionista, NumeroFigura, OtroEmisor),
    Emisor\=OtroEmisor.


% ----  3   ---- 
% figuraRara    --> nadie la consiguio en los dos primeros paquetes
% figuraRara    --> menos de la mitad de colecionistas tienen la figurita ( más de la mitad (4) NO tiene la figurita), y no es repetida

% figuraRara(#figura).
figuraRara(NumeroFigura):-
    paqueteAbierto(_,NumeroFigura,PaqueteAbierto),
    paqueteAbierto(_,NumeroFigura,OtroPaqueteAbierto),
    PaqueteAbierto\=primerPaquete,
    OtroPaqueteAbierto\=segundoPaquete.

figuraRara(NumeroFigura):-