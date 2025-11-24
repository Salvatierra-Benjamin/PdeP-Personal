// ! Esto es algo importante o una devolución
// ? Duda o algo a revisar
// TODO Falta completar esto
// * Comentario normal o decorativo
// Comentario común


class SuperComputadoras{
  const equipos = []
  var totalDeComplejidadComputada = 0

  //* Es correcto que estaActivo() sea responsabilidad de equipo para que ellso decidan cuando estar activos o no 
  // 

  method equiposActivos() = equipos.filter{equipo => equipo.estaActivo()}

  method computo() = self.equiposActivos().sum{equipo => equipo.computo()}

  method consumo() = self.equiposActivos().sum{equipo => equipo.consumo()}

  // method equipoQueMasConsumo() = self.equiposActivos.max{equipo => equipo.consumo()}
  // method equipoQueMasComputa() = self.equiposActivos.max{equipo => equipo.computo()}
  // method malConfigurada() = self.equipoQueMasConsumo() != self.equipoQueMasComputa()


  method equipoActivoAqueMas(criterio) = self.equiposActivos().max(criterio)

  method malConfigurada() = 
          self.equipoActivoAqueMas{ equipo => equipo.consumo()} != 
          self.equipoActivoAqueMas{equipo => equipo.computo()}

  method computarProblema(problema) {
    // *utilizar forEach cuando no me interesa el resultado, solo aplicar ESO a cada elemento
    // Hacer problemas pero con una complejidad menor
    // self.equiposActivos().forEach{ equipo => equipo.computar(new Problema(complejidad = problema.complejidad() / self.equiposActivos().size()))}

    const subProblema = (new Problema(complejidad = problema.complejidad() / self.equiposActivos().size()))
    self.equiposActivos().forEach{ equipo => equipo.computar(subProblema)}

    totalDeComplejidadComputada + problema.complejidad() 
  }

}

class Problema{
  const property complejidad
}


class Equipo{ 
  var property modoDeTrabajo = standard // Cada computadora tendra un diferente modo de trabajo
  var estaQuemado = false

  method estaActivo() = !estaQuemado && self.computo() >0

  method consumo() = modoDeTrabajo.consumoDe(self)
  method computo() = modoDeTrabajo.computoDe(self)

  method consumoBase()                // No se puede generalizar
  method computoBase()                // No se puede generalizar
  method computoExtraOverclokeado()   // No se puede generalizar

  // method disminucionDesdeConsumoBase() = self.consumoBase() - 200
  // method consumoEnAhorroDeEnergia()

  method computar(problema){
    if(problema.complejidad() > self.computo()) throw new DomainException(message= "Capacidad maxima") 
    modoDeTrabajo.realizarComputo(self)
  }
  // method computar(problema){
  //   if(problema.complejidad() <= self.computo())
  //   throw new Exception(message= "error al computar")
  // }

}


class A105 inherits Equipo{
  override method consumoBase() = 300
  override method computoBase() = 600

  method consumo(equipo) = modoDeTrabajo.consumoDe(self)

  override method computoExtraOverclokeado() = self.computoBase() * 1/3
  // para nada quiero hardcodear y poner 200
  
  override method computar(problema) {
    if(problema.complejidad() < 5) throw new DomainException(message= "Error de fabrica")
    super(problema)
  } 

}

class B2 inherits Equipo{

  var microChipsInstalados // "puede variar" ergo composicion? 

  override method consumoBase() = (microChipsInstalados * 50) + 10
  override method computoBase() = 800.min(microChipsInstalados * 100)
  // override method computoBase() {
  //   if(microChipsInstalados >= 8) 
  //   800
  //   else microChipsInstalados*100
  // }

  override method computoExtraOverclokeado() = 20 * microChipsInstalados


   //! Esto esta MAL porque no agrega logica a computar, directamente lo dejo como esta al heredar
  // override method computar(problema){
  //   super(problema)
  // }


}

////////////// * MODOS DE TRABAJO //////////////

class ModoDeTRabajo{

  method consumo()

}

object standard{
  method consumoDe(equipo) = equipo.consumoBase() 
  method computoDe(equipo) = equipo.computoBase()
}

class OverClock{
  var property usosRestantes

  override method initialize(){
    if (usosRestantes < 0 )throw new DomainException(message= "Los usos restantes deben ser mayor a cero")
  }
  method consumoDe(equipo) = equipo.consumoBase() * 2
  method computoDe(equipo) =  equipo.computoBase() + equipo.computoExtraOverclokeado()

  method realizaComputo(equipo){
    if(usosRestantes == 0){
      equipo.estaQuemado(true)
      throw new DomainException(message= "Equipo quemado!!!")
    }
    usosRestantes -= 1

  }

}

class AhorroDeEnergia{
  var computosREalizados = 0
  
  method consumoDe(equipo) = 200 //equipo.consumoEnAhorroDeEnergia()  
  // method computoDe(equipo) = equipo.consumoBase() - equipo.consumoEnAhorroDeEnergia()
  method computoDe(equipo) = equipo.consumoBase() / equipo.consumoBase() * equipo.computoBase()
  method periodicidadDeError() = 17
  method realizaComputo(equipo){
    computosREalizados -= 1
    if(computosREalizados % self.periodicidadDeError() == 0) throw new DomainException(message= "Corriendo monitor")
  }

}


class APruebaDeFallos inherits AhorroDeEnergia{
  override method periodicidadDeError() = 100
  override method computoDe(equipo) = super(equipo) /2 
  
  
}


