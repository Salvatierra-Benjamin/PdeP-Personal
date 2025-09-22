object bobEsponja {
  var dinero = 10000
  var energia = 1000
  var felicidad = 100
  
  method estaListo() = true
  
  method comerCangreburgers() {
    energia += 1000 * felicidad
    return energia
  }

  method propina(){
    if(energia > 600){
      return energia * 10
    }
    else{
      return 100
    }
    
  }
}

object patricio {
  var masaMuscular = 40
  var dinero = 0
  
  method comerCangreburgers() {
    masaMuscular += 10
    return masaMuscular
  }
}

object calamardo {
  var horasQueDurmio = 4
  var dinero = 5000
  
  method comerCangreburgers() {
    
  }
  
  method estaListo() = horasQueDurmio.even()
  // es lo mismo con el return horasQueDurmio.eve()
}

object donCangrejo{
  var dinero = 1000000
  var dineroGastadoEnPerlita = 500000
  method llevarComision(precioFinal){
    dinero += precioFinal

  }

  
}


object crustaceoCascarudo{
  var nivelLimpieza = 100
  var empleado = calamardo
  const precioCangreburgers = 1000

  method estaLimpio() = nivelLimpieza.between(50,95)
  
   method estaListoParaAbrir(){
    return empleado.estaListo() && self.estaLimpio()
   }

   method cobrarCangreBurger(personaje){
    donCangrejo.llevarComision(self.precioFinal(personaje))
    personaje.comerCangreburgers()
   }

   method precioFinal(personaje){
    return precioCangreburgers + personaje.propina()
   }

   method empleado(nuevoEmpleado){
    empleado = nuevoEmpleado
   }
}