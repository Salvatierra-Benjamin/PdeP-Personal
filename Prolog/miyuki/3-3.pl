/*
Bueno, para ser justos, también podés llegar fácilmente si vivís en la misma zona del destino (caminar hace bien ).

Es decir, alguien llega fácil a un destino, si vive en la misma zona en la que queda este destino. ¿Se podrá decir expresar esto en Prolog?

llegaFacil(batman, _).
llegaFacil(Persona, _) :-
 tieneAuto(Persona).
llegaFacil(Persona, Destino) :-
  viveEn(Persona, Zona),
  quedaEn(Destino, Zona).
¿Ves algo extraño en la última cláusula de llegaFacil? ¿Funcionará este predicado? ¡Descubrilo!

Probá en la consola las siguientes consultas:

llegaFacil(batman, exactas) (debería, porque siempre llega fácil)
llegaFacil(victoria, exactas) (no debería, porque no tiene auto ni vive en Núñez)
llegaFacil(fede, exactas) (debería, porque tiene auto)

*/



