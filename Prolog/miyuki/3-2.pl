/*
Ah, pero dijimos que ibamos a usar autos para llegar a algunos lugares. Sabemos que:

tomas y fede tienen auto.
las personas que tienen auto llegan fácil a cualquier destino.
batman llega fácil a cualquier destino (obvio, ¡medios de transporte le sobran!)
Escribí los predicados tieneAuto/1 y llegaFacil/2
*/


tieneAuto(tomas).
tieneAuto(fede).

llegaFacil(Persona,Lugar):-
    tieneAuto(Persona).

llegaFacil(batman,_).
