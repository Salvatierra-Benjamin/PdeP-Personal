// Revisado: 08.12.25

/* --------------- MAGOS --------------- */
class Mago {
    const poderInnato // 1 al 10
    const objetosMagicos
    const property nombre
    var energia
    const property resistencia
    const categoria // aprendiz - veterano - inmortal

    method energia() = energia

    // Punto A.1
    method poder() = objetosMagicos.sum{ obj => obj.poder(self) } * poderInnato
    
    // Punto A.2
    method desafiarA(otroMago) {
        if (otroMago.puedeSerVencido(self)) {
            const energiaQueRecibe = otroMago.energiaQuePerderia()
            energia = energia + energiaQueRecibe
            otroMago.perderEnergia()
        }
    }

    method puedeSerVencido(otroMago) = categoria.puedeSerVencida(self, otroMago)

    method energiaQuePerderia() = categoria.energiaQuePerderia(self)

    method perderEnergia() {
        const energiaQuePierde = self.energiaQuePerderia()
        energia = energia - energiaQuePierde
    }

    method recibirEnergia(energiaRecibida) {
        energia = energia + energiaRecibida
    }

    method lider() = self
}

/* --------------- CATEGORIAS DE MAGOS --------------- */

object aprendiz {
    method puedeSerVencida(magoDefensor, magoAtacante) = magoDefensor.resistencia() < magoAtacante.poder()
    method energiaQuePerderia(magoDefensor) = magoDefensor.energia() * 0.50
}

object veterano {
    method puedeSerVencida(magoDefensor, magoAtacante) = magoDefensor.resistencia() * 1.5 < magoAtacante.poder()
    method energiaQuePerderia(magoDefensor) = magoDefensor.energia() * 0.25
}

object inmortal {
    method puedeSerVencida(magoDefensor, magoAtacante) = false
    method energiaQuePerderia(magoDefensor) = 0
}

/* --------------- OBJETOS --------------- */

class Varita {
    const poderBase
    method poder(mago) = if (self.tieneNombrePar(mago)) poderBase * 1.5 else poderBase
    method tieneNombrePar(mago) = mago.nombre().size().even()
}

class TunicaComun {
    const poderBase
    method poder(mago) = poderBase + 2 * mago.resistencia()
}

class Tunicaepica inherits TunicaComun {
    override method poder(mago) = super(mago) + 10
}

object amuleto {
    const property poder = 200
}

object ojota {
    method poder(mago) = mago.nombre().size() * 10
}

/* --------------- GREMIOS --------------- */

object agenciaDeHechiceria {
    // Punto B.1
    method crearGremio(nuevosMiembros) {
        if (nuevosMiembros.size() < 2)
            throw new CantidadInvalidaException(message = "Se necesitan al menos 2 miembros para crear un gremio.")
        else
            return new Gremio (miembros = nuevosMiembros)
    }
}

class CantidadInvalidaException inherits Exception {}

class Gremio {
    const miembros // magos o gremios

    method poder() = miembros.sum{miembro => miembro.poder()}
    method energia() = miembros.sum{miembro => miembro.energia()}
    method lider() = miembros.max{miembro => miembro.poder()}.lider()
    method resistencia() = miembros.sum{miembro => miembro.resistencia()} + self.lider().resistencia()

    method puedeSerVencido(contrincante) = contrincante.poder() > self.resistencia()

    method energiaQuePerderia() = miembros.sum{ miembro => miembro.energiaQuePerderia() }

    method perderEnergia() = miembros.forEach{ miembro => miembro.perderEnergia() }

    // Punto B.2
    method desafiarA(contrincante) {
        if (contrincante.puedeSerVencido(self)) {
            const energiaQueRecibe = contrincante.energiaQuePerderia()
            self.lider().recibirEnergia(energiaQueRecibe)
            contrincante.perderEnergia()
        }
    }
}

// Punto B.3: En general no hizo falta hacer cambios gracias a respetar la misma interfaz
// del mago a la hora de diseñar al gremio, por ej: que ambos respondan poder() y energia()
// Lo único que hubo que cambiar es que el mago pueda responder lider(), para
// poder pedir de forma polimorfica el lider al miembro mas poderoso, sin tener
// que preguntar si es un mago o un gremio