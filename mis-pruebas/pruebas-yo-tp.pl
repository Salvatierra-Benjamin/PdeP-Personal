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


