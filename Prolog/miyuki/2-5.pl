/*
Queremos ayudar a una agencia matrimonial a armar parejas según los signos del zodíaco. La agencia tiene estas reglas:

- Las personas de libra con ascendente en piscis son compatibles con las de capricornio con ascendente en aries.
- Las de acuario con ascendente en sagitario son compatibles con las de leo con ascendente en géminis.
- Las de leo con ascendente en aries son compatibles con las de libra con ascendente en sagitario.


Desarrollá esCompatible/2: que relaciona a dos personas cuando son compatibles.

?- esCompatible(maria,sara).
yes.

?- esCompatible(sara,maria).
yes.

Asumí que ya existen en la base de conocimiento hechos de la forma deLibra/1, deAcuario/1, deLeo/1, deCapricornio/1, 
ascendenteEnAries/1, ascendenteEnPiscis/1, ascendenteEnGeminis/1 y ascendenteEnSagitario/1.

 ¡Dame una pista!

Ojo con la simetría!!!
*/

% grupo1 -> deLibra() y ascendenteEnPiscis()        con     deCapricornio() y ascendenteEnArie()

% grupo2 -> deAcuario() y ascendenteEnSagitario()   con     deLeo() y asdencenteEnGeminis()

% grupo3 -> deLeo() y ascendenteEnArie()            con     deLibra() y ascendenteEnSagitario() 

deLibra(persona).
deAcuario(persona).
deLeo(persona).
deCapricornio(persona).
ascendenteEnAries(persona).
ascendenteEnPiscis(persona).
ascendenteEnGeminis(persona).
ascendenteEnSagitario(persona).

esCompatible(PrimerPersona, SegundaPersona):-
    deLibra(PrimerPersona),
    ascendenteEnPiscis(PrimerPersona),
    deCapricornio(SegundaPersona),
    ascendenteEnAries(SegundaPersona).

esCompatible(PrimerPersona, SegundaPersona):-
    deLibra(SegundaPersona),
    ascendenteEnPiscis(SegundaPersona),
    deCapricornio(PrimerPersona),
    ascendenteEnAries(PrimerPersona).

esCompatible(PrimerPersona,SegundaPersona):-
    deAcuario(PrimerPersona),
    ascendenteEnSagitario(PrimerPersona),
    deLeo(SegundaPersona),
    ascendenteEnGeminis(SegundaPersona).

esCompatible(PrimerPersona,SegundaPersona):-
    deAcuario(SegundaPersona),
    ascendenteEnSagitario(SegundaPersona),
    deLeo(PrimerPersona),
    ascendenteEnGeminis(PrimerPersona).

esCompatible(PrimerPersona, SegundaPersona):-
    deLeo(PrimerPersona),
    ascendenteEnAries(PrimerPersona),
    deLibra(SegundaPersona),
    ascendenteEnSagitario(SegundaPersona).

esCompatible(PrimerPersona, SegundaPersona):-
    deLeo(SegundaPersona),
    ascendenteEnAries(SegundaPersona),
    deLibra(PrimerPersona),
    ascendenteEnSagitario(PrimerPersona).
