// Clase 6 (Falsa clase 6, porque la verdadera clase 6 fue asincrónica)

// Mi resolución (mayormente)

class Artista {
    const nombre

    const nacionalidad

    const añosTrayectoria
    const nroIntegrantes

    method nroIntegrantes() = nroIntegrantes

    const reconocimiento

    method reconocimiento() = reconocimiento

    var genero

    // Porque el enunciado lo indica
    method genero(unGenero) {
        genero = unGenero
    }
    
    method presentacion() {
        return "Hola, somos " + nombre + " y tocamos " + genero.nombre()
    }
    
    method laVanARomper() {
        // Se podría delegar cada comparación
        return reconocimiento > 70 and añosTrayectoria > 10 and genero.energia(self) > 5
    }

    method cantidadOyentes() {
        return reconocimiento * nacionalidad.impronta(self) * genero.popularidad()
    }
}

class Genero {
    const nombre 
    const energia = 0
    const popularidad = 0
    method energia(artista) = energia
    method popularidad() = popularidad
    method nombre() = nombre
}

object rock inherits Genero(nombre = "rock", popularidad=8) {
    override method energia(artista) {
        if (artista.nroIntegrantes() > 3)
            return 10
        return 8
    }

}
const funk = new Genero(nombre="funk", energia=7, popularidad=7)
const trap = new Genero(nombre="trap", energia=8, popularidad=10)

object Uruguay {
    method impronta(artista) {
        return 100 * artista.reconocimiento()
    }
}

object Argentina {
    method impronta(artista) {
        return 400 * artista.nroIntegrantes()
    }
}


object pdepalloza {
    // conjunto o lista (da igual, pero tiene más sentido que sea un conjunto acá)
    const artistas = #{}
    //const artistas = []

    // esConcurrido()
    method totalDeOyentesSuficiente() {
        return artistas.sum({artista => artista.cantidadOyentes()}) > 100000
    }

    method vaASerUnExito(pais) {
        return self.totalDeOyentesSuficiente() || artistas.all({artista => artista.laVanARomper()})
    }
}

// Alternativa:
//  * clase abstracta: Artista (sin nacionalidad) 
//  * clase concreta:  ArtistaUruguayo, ArtistaArgentino (heredan de Artista)

// Alternativa:
// class Show { ... }

// 17/11: "Clase picnic" :O (la clase después del parcial) (algo no cierra porque el parcial es el 3/11 xd)


/* HERENCIA VS. COMPOSICIÓN */

// Composición es cuando tenemos un objeto como atributo de otro objeto (un
// objeto adentro de un objeto)


// Herencia:
// * No la podemos cambiar en tiempo de ejecución
// * Solo puedo heredar de una clase

// Composición:
// * Puedo o no cambiarlo (const vs. var)
// * Puedo tener varias

// La elección de uno u otro tiene un cierto grado de subjetividad

// Ya vimos todos los temas :D :D :D :D

// El parcial va a tener "algo más del estilo conceptual (?)"
//
// El dia anterior nos llega un ejercicio resuelto y en el parcial contestamos
// preguntas basadas en eso.
//
// "No hay parciales de ese formato"
//
// "...no sé todavía..." (cómo va a tomarlo exactamente)
