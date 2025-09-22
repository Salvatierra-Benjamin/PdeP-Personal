// Clase 4 (vino Messi)

// Ejercicio práctico: Wollok Game Worlds

/* 
HAY UN TEMA: Josedeodo y Caps tienen interfaces muy similares, entonces tenemos
que repetir código. O eso tendríamos que hacer si no usáramos las CLASES.
*/

// Usar clases nos da declaratividad y expresividad

// Siempre en singular y en mayúscula
class Jugador {

    // Es opcional asignar valores en una clase
    var antiguedad
    var cansancio

    // Si los asigno, se puede instanciar la clase sin pasar ningún valor, y
    // los asignados serán los predeterminados. Ver las instanciaciones de
    // Jugador más adelante

    //var antiguedad = 0
    //var cansancio = 0

    method esTitular() = antiguedad > 3
    method estaCansado() = cansancio >= 100

    // Es preferible !estaCansado() a noEstaCansado()
    method puedeJugar() = self.esTitular() && !self.estaCansado()

    method tomarBebida() {
        cansancio = 0.max(cansancio-10)
    }
}

// Instanciación de una clase

// Es const porque "no quiero que la flechita apunte a otro lado" (en el
// diagrama de objetos) (palabras de la profe)
const caps = new Jugador(antiguedad = 8, cansancio = 50)
const josedeodo = new Jugador(antiguedad = 6, cansancio = 50)

// No se puede hacer esto, salvo que los atributos de la clase tengan valores
// predeterminados:
//
//const josedeodo2 = new Jugador()

// WKO
object faker {
    var estaTilteado = false

    method estaTilteado() = estaTilteado
    method tomarTecito() {
        estaTilteado = false;
    }

    method puedeJugar() = !estaTilteado
    //method jugar() {
    //    if (puedeJugar())
    //          ...
    //}
    
}

/*
 1) d) Recordar que los test son útiles cuando hacemos cambios en el código
 
 En puedeJugar() un jugador con antiguedad 1 y un jugador con antiguedad 2
 están en la misma clase de equivalencia, porque en ambos casos puedeJugar()
 retorna false
 
 En tomarBebida() tengo 2 clases de equivalencia: una para 0 y otra para
 (cansancio-10), entonces hago 2 test.
 
 El nombre del test nos ayuda a ver qué parte del código estamos testeando.

 Es preferible testear una clase antes que cada instancia?
*/


// DIAGRAMA DE CLASES


// El diagrama de clases es una herramienta de comunicación
// EL DIAGRAMA DE CLASES SE VA A EVALUAR

// La línea punteada separa los atributos de los métodos

// * Diagrama dinámico: es una "foto" del sistema en un determinado momento
//                      (como el que genera Wollok)
// * Diagrama de clases: no representa los valores de las variables (los
//                       atributos) (el estado)

// En el diagrama se pone solamente lo más importante de la clase (nada de
// getters y setters en general)

// Mi intento de dibujar las flechas del diagrama en texto:
//
// *: Muchos
// ------|#>: Tiene/conoce
// - - - | >: Implementa una interfaz
// - - - |#>: Usa (como parámetro en algún método)


// Otra cosa:
class Jugador {
    method jugar() {

    }
}

object faker {
    method jugar() {

    }
}
/*
    En el REPL:
    > faker
    (aparece faker en el diagrama)

    > const diana = new Jugador(antiguedad = 10, cansancio = 100)
    (aparece un círculo (unJugador) y una flecha apuntándole (diana const) y
    los atributos :D

    > faker.jugar()
    (usa el método de faker)

    > diana.jugar()
    (usa el método de la clase Jugador, porque diana no tiene ninguno definido)
*/
