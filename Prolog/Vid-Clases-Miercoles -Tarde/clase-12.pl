% estaEn(Pais, Continente).
estaEn(argentina, americaDelSur).
estaEn(uruguay, americaDelSur).
estaEn(brasil, americaDelSur).
estaEn(chile, americaDelSur).
estaEn(peru, americaDelSur).
estaEn(colombia, americaDelSur).

estaEn(mexico, americaDelNorte).
estaEn(california, americaDelNorte).
estaEn(nuevaYork, americaDelNorte).
estaEn(oregon, americaDelNorte).
estaEn(alaska, americaDelNorte).

estaEn(alemania, europa).
estaEn(espania, europa).
estaEn(francia, europa).
estaEn(granBretania, europa).
estaEn(rusia, europa).
estaEn(polonia, europa).
estaEn(italia, europa).
estaEn(islandia, europa).

estaEn(sahara, africa).
estaEn(egipto, africa).
estaEn(etiopia, africa).

estaEn(aral, asia).
estaEn(china, asia).
estaEn(gobi, asia).
estaEn(mongolia, asia).
estaEn(siberia, asia).
estaEn(india, asia).
estaEn(iran, asia).
estaEn(kamchatka, asia).
estaEn(turquia, asia).
estaEn(israel, asia).
estaEn(arabia, asia).

estaEn(australia, oceania).
estaEn(sumatra, oceania).
estaEn(borneo, oceania).
estaEn(java, oceania).

% Como limitaCon/2 pero simétrico
limitrofes(Pais, Limitrofe):- limitaCon(Pais, Limitrofe).
limitrofes(Pais, Limitrofe):- limitaCon(Limitrofe, Pais).

% Antisimétrico, irreflexivo y no transitivo
% Predicado auxiliar. Usar limitrofes/2.
limitaCon(argentina,brasil).
limitaCon(uruguay,brasil).
limitaCon(uruguay,argentina).
limitaCon(argentina,chile).
limitaCon(argentina,peru).
limitaCon(brasil,peru).
limitaCon(chile,peru).
limitaCon(brasil,colombia).
limitaCon(colombia,peru).

limitaCon(mexico, colombia).
limitaCon(california, mexico).
limitaCon(nuevaYork, california).
limitaCon(oregon, california).
limitaCon(oregon, nuevaYork).
limitaCon(alaska, oregon).

limitaCon(espania,francia).
limitaCon(espania,granBretania).
limitaCon(alemania,francia).
limitaCon(alemania,granBretania).
limitaCon(polonia, alemania).
limitaCon(polonia, rusia).
limitaCon(italia,francia).
limitaCon(alemania,italia).
limitaCon(granBretania, islandia).

limitaCon(china,india).
limitaCon(iran,india).
limitaCon(china,iran).
limitaCon(gobi,china).
limitaCon(aral, iran).
limitaCon(gobi, iran).
limitaCon(china, kamchatka).
limitaCon(mongolia, gobi).
limitaCon(mongolia, china).
limitaCon(mongolia, iran).
limitaCon(mongolia, aral).
limitaCon(siberia, mongolia).
limitaCon(siberia, aral).
limitaCon(siberia, kamchatka).
limitaCon(siberia, china).
limitaCon(turquia, iran).
limitaCon(israel, turquia).
limitaCon(arabia, israel).
limitaCon(arabia, turquia).

limitaCon(australia, sumatra).
limitaCon(australia, borneo).
limitaCon(australia, java).

limitaCon(sahara, egipto).
limitaCon(etiopia, sahara).
limitaCon(etiopia, egipto).

limitaCon(australia, chile).
limitaCon(aral, rusia).
limitaCon(iran, rusia).
limitaCon(india, sumatra).
limitaCon(alaska, kamchatka).
limitaCon(sahara, brasil).
limitaCon(sahara, espania).
limitaCon(egipto, polonia).
limitaCon(turquia, polonia).
limitaCon(turquia, rusia).
limitaCon(turquia, egipto).
limitaCon(israel, egipto).

%% Estado actual de la partida

% ocupa(Jugador, Pais, Ejercitos)
ocupa(azul, argentina, 5).
ocupa(azul, uruguay, 3).
ocupa(verde, brasil, 7).
ocupa(azul, chile, 8).
ocupa(verde, peru, 1).
ocupa(verde, colombia, 1).

ocupa(rojo, alemania, 2).
ocupa(rojo, espania, 1).
ocupa(rojo, francia, 6).
ocupa(rojo, granBretania, 1).
ocupa(amarillo, rusia, 6).
ocupa(amarillo, polonia, 1).
ocupa(verde, italia, 1).
ocupa(amarillo, islandia, 1).

ocupa(magenta, aral, 1).
ocupa(azul, china, 1).
ocupa(azul, gobi, 1).
ocupa(azul, india, 1).
ocupa(azul, iran,8).
ocupa(verde, mongolia, 1).
ocupa(verde, siberia, 2).
ocupa(verde, kamchatka, 2).
ocupa(amarillo, turquia, 10).
ocupa(negro, israel, 1).
ocupa(negro, arabia, 3).

ocupa(azul, australia, 1).
ocupa(azul, sumatra, 1).
ocupa(azul, borneo, 1).
ocupa(azul, java, 1).

ocupa(amarillo, mexico, 1).
ocupa(amarillo, california, 1).
ocupa(amarillo, nuevaYork, 3).
ocupa(amarillo, oregon, 1).
ocupa(amarillo, alaska, 4).

ocupa(amarillo, sahara, 1).
ocupa(amarillo, egipto, 5).
ocupa(amarillo, etiopia, 1).




% forall(limitrofes(Paises, Otro),
%    ocupadoPorRival(Otro, Jugador)).


% FORALL()
%   -   para verificar si todos los que cumplen una consulta, también cumplen con otra
%   -   como recibe consultas, es de orden 2
%   -   a la primera consulta que recibe le deciamos ANTECEDENTE, y la segunda CONSECUENTE
%   -   el antecedente y consecuente deben vincularse adecuadamente
%   -   SIEMPRE debe haber alguna variable libre en el antecedente, para decir "para todo X, tal que X..."

%   para todo L() => P().




% Casos de no inversibilidad 
%   - hechos con variables
%   - comparación por distinto
%   - negación
%   - >,>=, <,=<
%   - is/2
