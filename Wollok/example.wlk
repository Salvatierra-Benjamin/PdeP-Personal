object fenderStratocaster {
  var property color = "negro"
  const property afinado = true
  const property esValioso = true
  method costo() {
    if (color == "negro") {
      return 15
    } else {
      return 10
    }
  }


}

object trompetaJupiter {

  var afinado = true
  var tieneSordina = true
  const costoBase = 30
  
  method costo() {
    if (tieneSordina) {
      return costoBase + 5
    } else {
      return costoBase
    }
  }


  method temperaturaIdeal(unaTemperatura) = unaTemperatura.between(20, 25)

  method afinarTrompeta(temperaturaAmbiente) {
    if (!self.temperaturaIdeal(temperaturaAmbiente)) {
        self.soplarTrompeta()
    }
  }


  method soplarTrompeta() {
    afinado = true
  }

  method estaAfinado() = afinado
  method esValioso() = false

  method sacarSordina(){ //legal, limpio????
    tieneSordina = false
  }

}

object pianoBechstein {
  var property largoHabitacion = 5
  var property anchoHabitacion = 5

  method areaHabitacion() = largoHabitacion * anchoHabitacion

  method afinado() = self.areaHabitacion() > 20
  method costo() = 2 * anchoHabitacion
  method esValioso() = self.afinado()
}

object violinStagg {
  var afinado = true
  var cantidadDeTremolos = 0
  const costoBase = 20
  var property pintura = "laca acrilica"
  
  method hacerTremolo() {
        cantidadDeTremolos+=1
    if (cantidadDeTremolos >= 10) {
      afinado = false
    }
  }
  method afinado() = afinado
  method costo() = 15.max(costoBase - cantidadDeTremolos)
  method costoPar() = self.costo().even()
  method esValioso() = pintura == "laca acrilica"
}

object johann {
  var instrumento = trompetaJupiter

  method feliz() = instrumento.costo() > 20

//Realizo el setter del instrumento debido al segundo test de johann donde le asigno como instrumento un violin
  method instrumento(instrumentoNuevo){
    instrumento = instrumentoNuevo
  }
}
object wolfgang {
  method feliz() = johann.feliz()
}

object antonio {
  var instrumento = pianoBechstein
  method feliz() = instrumento.esValioso()
}

object giuseppe {
  var instrumento = fenderStratocaster
  method feliz() = instrumento.afinado()
  //Agrego setter de instrumento para el segundo test donde le asigno un piano a giuseppe
  method instrumento(instrumentoNuevo){
    instrumento = instrumentoNuevo
  }
}

object maddalena {
  var instrumento = violinStagg
  method feliz() = instrumento.costoPar()
}

object asociacionMusical  {

//Pongo como var al set de musicos, ya que a la hora de hacer el test, debo poner otros musicos dentro
  var musicos = #{johann, wolfgang, antonio, giuseppe, maddalena}

//ademas creo un setter para poder agregar esos musicos
  method musicos(setDeMusicos){
    musicos = setDeMusicos
  }
  method musicosFelices() = musicos.filter({musico => musico.feliz()})
  }





