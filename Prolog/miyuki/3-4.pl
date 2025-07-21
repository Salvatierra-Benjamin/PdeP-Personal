/*
Interesante lo que acaba de suceder, ¿no? Cuando hacemos una consulta como llegaFacil(tomas, exactas), llegaFacil/2 funciona, 
pese a que en la tercera cláusula nunca dijimos cuál es la zona.

llegaFacil(Persona, Destino) :-
  viveEn(Persona, Zona), %% Zona es una variable que salió "de la nada" :o 
  quedaEn(Destino, Zona).
A diferencia de Persona, a la que cuando la consultamos le dimos el valor tomas, nunca dijimos cual iba a ser el valor de Zona antes 
de usarla por primera vez. Zona es entonces una variable libre: la usamos sin haberla instanciado previamente.

Peeero, resulta que Prolog, es un tipo muy inteligente para estas cosas, y se da cuenta de que existe una Zona (nuniez) 
en la que al mismo tiempo vive tomas y en la que queda exactas:

∃ Zona : viveEn(tomas, Zona) ∧ quedaEn(exactas, Zona)
Y entonces, sin siquiera dudarlo, Prolog nos dice yes

Veamos si queda claro: escribí un predicado destinosProximos/2, que nos dice si dos destinos están en la misma zona.


*/

viveEn(mariano, avellaneda).
viveEn(fede, avellaneda).
viveEn(victoria, versalles).
viveEn(rodrigo, villaBallester).
viveEn(tomas, nuniez).

quedaEn(utn, almagro).
quedaEn(utn, villaLugano).
quedaEn(exactas, nuniez).
quedaEn(river, nuniez).
quedaEn(racing, avellaneda). 

tieneAuto(tomas).
tieneAuto(fede). 

llegaFacil(batman, _).
llegaFacil(Persona, _) :-
 tieneAuto(Persona).
llegaFacil(Persona, Destino) :-
  viveEn(Persona, Zona),
  quedaEn(Destino, Zona).


destinosProximos(D1,D2):-
    quedaEn(D1, Zona),
    quedaEn(D2, Zona).