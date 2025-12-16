receta(Nombre, Ingredistes).

ingrediente(Ingrediente).

calorias(Ingrediente, Calorias).


/*
trivial/1 se cumple para recetas con un unico ingrediente

elPeor/2 relaciona una receta con su ingrediente mas calorico

caloriasTotales/2 relaciona una receta y su total de calorias

versionLight/2 relaciona una receta con sus ingredientes, sin el peor.

guasada/1 se cumple para una receta con algun ingrediente de más de 1000kcal
*/


%? Pattern matching
trivial(Receta):-
    receta(Receta, [_]).


elPeor(Ingredientes, Peor):-
    member(Peor, Ingredientes),
    calorias(Peor, CaloriasdDelPeor),
    forall(member(Ingrediente, Ingredientes), 
           (calorias(Ingrediente, Calorias), CaloriasDelPeor >= Calorias)).