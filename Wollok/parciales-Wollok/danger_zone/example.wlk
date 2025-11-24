// todos tienen habilidades
// incapacitado => salud esta debjo de la salud crítica


// HERENCIA ES ARMA DE UN SOLO TIRO
// No puedo poner herencia para oficinistaJefe y espiaJefe

class Empleado{
  var salud = 100
  const habilidades = []
  var puesto

  method estaIncampacitado() = salud < self.saludCritica() 
  method saludCritica() = puesto.saludCritica() // metodo abstracto, el metodo esta definido en los hijos???

  method puedeUsar(habilidad) = not self.estaIncampacitado() and self.poseeHabilidad(habilidad)

  method poseeHabilidad(habilidad) = habilidad.contains(habilidad)

  method recibirdanio(cantidad){
    salud -= cantidad
  }

  method estaVivo() = salud > 0

  method finalizarMision(mision){
    if(self.estaVivo()){
      self.completarMision(mision)
    }
  }

  method completarMision(mision){
    puesto.completarMision(mision, self)
  }

}
/*
Si tengo un objeto que tiene estado, y no quiero que sea compartido por los demás, lo más probable es que 
tenga que ser una instacnai de una clase

// puede puestoEspia que sea un WKO? que todos conozcan su existencia?? Si, porque no tiene estados que vayan a ser compartidos
// puede puestoOficinista que sea un WKO? que todos conozcan su existencia?? NOOO!!!
*/
object puestoEspia {
  method saludCritica() = 15

  method completarMision(mision, empleado){

  }

}


class PuestoOficinista {
  var cantEstrellas = 0 // es logico que que solo el puesto oficinista tenga estrellas
  method saludCritica()= 40 - (5*cantEstrellas)

  method ganarEstrellas(){
    cantEstrellas = cantEstrellas +1
    
  }
}

class Jefe inherits Empleado {
  const subordinados = []

  override method poseeHabilidad(habilidad) = super(habilidad) or self.algunSubordinadoLaTiene(habilidad)

  method algunSubordinadoLaTiene(habilidad) = subordinados.any{ subordinado => subordinado.puedeUsar(habilidad)}

}



// PUNTO 3 !!!

// peligrosidad será un daño que se descontará de salud de Empleado

// Mision será una clase: dentro de ella tendra peligrosidad y habilidades requeridas

class Mision {
  const habilidadesRequeridas = []
  const peligrosidad 
  
  method serCumplidaPor(asignado){
    self.validarHabilidades(asignado)
    asignado.recibirDanio(peligrosidad)
    // No PONER ESTO: asignado.salud( asignado.salud() - peligrosidad)
    asignado.finalizarMision(self)
  }

  method validarHabilidades(asignado){
      if(not self.rehuneHabilidadesRequeridas(asignado)){
      self.error("La mision es muy compleja")
      // throw new NoPuedeCumplirMision(message = "La mision es muy compleja")
      }
  }


  method rehuneHabilidadesRequeridas(aisgnado) = habilidadesRequeridas().all({hab => asignado.puedeUsar(hab)})
   
}

// empleado.cumplir(mision) // disparador y tendra un efecto en empleado NO BUENO
// mision.serCumplidaPor(empleado) ✅✅
//¿Quien tiene la responsabilidad? mmh



// Equipo?? un set de empleados??




/*

//////////// SOLUCION COMPOSICION ///////////////////

class Empleado2{
  var property puesto // Necesita tener un puesto, para que después tenga la responsabilidad de saber si esta incapacitado
  // De esta forma puedo tener algo para TODOS los empleados 
  // y también tener algo para cada puesto!!!
  
  var salud = 100

  method estaIncapacitado() = salud > puesto.saludCritica()
}

object espia { // Este también podria ser class pero como no tengo un estado (cantEstrellas = 0 por ej) pero no hay necesidad  
  method saludCritica() = 15
}

class Oficinista { // Permitira tener dos objetos diferentes con una cantidad diferente de cantEstrellas
  var cantEstrellas = 0
// Donde poner la cantidad de estrellas?? clase empleado? oficinista? Es para oficinista, porque solo interesa para oficinista


  !!!!SUPER REDUNDANTE!!!
  Si es posible tener cosas que se pueden calcular en base a otras, HACERLO!!! 
// Salud critica depende de la cantEstrellas, ergo saludCritica no deberia ser estrella. Si algo puede ser calculado en base a otra, hacerlo

  Aparte no se plasma facilmente con lo que dice el enunciado


  var property saludCritica = 40 // nuevo oficinista, asi que no tendra estrellas (40 - 0) ( GANAMOS!!! WOOHOOO broma)


  method ganarEstrellas(){
    cantEstrellas += 1
    saludCritica -= 5 // Gane una estrella, entonces (40 - 5*1) :D :D :D !GANAMOS!!
  }


  method saludCritica()= 40 - 5 * cantEstrellas // ALTAMENTE SUPERIOR A LO COMENTADO ANTERIOR

}

object cientifico{
  method saludCritica() = 100

}

*/



// PUNTO 2

// empleado.puedeIsar(Habilidad) // responsabilidad del empleado
// habilidad.puedeSerUsada(empleado) // se descarta porque las habilidades son muy simples // responsabilidad de la habilidad

// class EspiaJefe inherits Espia {
//   /*
//   VA A REPETIR LOGICA PARA OFICINISTAJEFE

//   // const Subordinados = []
//   // override method poseeHabilidad(habilidad) = habilidad.contains(habilidad) or self.algunSubordinadoLaTiene(habilidad)

//   */
// }

