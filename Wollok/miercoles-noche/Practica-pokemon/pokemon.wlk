// pokemon.grositud()
class Pokemon{
  const vidaMaxima 
  var movimientos = []
  var vida = 100
  // var property condicion //* Se podria tener una condicion inicial
  
  var property condicion = normal //* al final si lo pongo por el punto b, que quiere usar algo
  //* dependiendo la condicion en que este

  method grositud() = vidaMaxima * movimientos.sum{ movimiento => movimiento.poder()} 

  method curar(puntosDeSalud) {
    vida = (puntosDeSalud + vida).min(vidaMaxima)
  }

  method recibirDanio(danioRecibido){
    vida = 0.max(danioRecibido) // De esta Forma no puedo tener vida negativa
  }

  //* Remplazado por el var property
  // method condicion(condicion){
  //   condicion = condicion
  // }
  
  method lucharContra(contrincante){
    self.validarQueEstaVivo()
    contrincante.validarQueEstaVivo()
    // elegir un movimiento de los que estan disponibles
    const movimientoAUsar = self.movimientoDisponible()
    // usar el movimiento. Solo si la condicion lo permite

    condicion.intentaMoverse(self)

    movimientoAUsar.usarEntre(self, contrincante)
    
  }
  
  method movimientoDisponible() = movimientos.find {movimiento => movimiento.estaDisponible()}

  method normalizar(){
    condicion = normal
  }

  method validarQueEstaVivo() {
    if(vida == 0) throw new NoPuedeMoverseException(message = "El pokemon no esta vivo") 
  }

}


//* MOVIMIENTO ////


class Movimiento{
  var usosPendientes = 0 

  method usarEntre(usuario, contrincante){
    if(!self.estaDisponible())
        throw new MovimientoAgotadoException(message = "El movimiento no esta disponible")

      usosPendientes -= 1
      self.afectarPokemones(usuario,contrincante)
  }

  method estaDisponible() = usosPendientes > 0

  method afectarPokemones(usuario, contrincante) //Lo dejo abstracto

}



class MovimientoCurativo inherits Movimiento{
  const puntosDeSalud
  method poder() = puntosDeSalud 

  override method afectarPokemones(usuario, contrincante){
    usuario.curarse(puntosDeSalud) //! Aca no curo al pokemon, solo le mando mensaje al pokemon
    //! para que este se cure
  }
}



class MovimientoDAnino inherits Movimiento{
  const danioQueProduce
  method poder() = 2 * danioQueProduce

  override method afectarPokemones(usuario, contrincante){
    contrincante.recibirDanio(danioQueProduce) 
  }
  
}

//? No esta bueno porque acoplo todo
// class MovimientoDeSuenio{
//   method poder() = 50
// }

// class MovimientoDeParalisis{
//   method poder() = 30
// }

class MovimientoEspecial inherits Movimiento{
  const condicionQueGenera
  method poder() = condicionQueGenera.poder()

  override method afectarPokemones(usuario, contrincante){
    contrincante.condicion(condicionQueGenera)  
  }
}


//* CONDICIONES ///////

class CondicionEspecial{
  method poder()

  method intentaMoverse(pokemon){
    if(!self.lograMoverse())
        throw new NoPuedeMoverseException(message = "El pokemon no pudo moverse")
  }
  
  method lograMoverse() =  0.randomUpTo(2).roundUp().even()


}

object paralisis inherits CondicionEspecial{
  override method poder() = 30


  // method intentaMoverse(pokemon){
  //   if(!self.lograMoverse())
  //       throw new NoPuedeMoverseException(message = "El pokemon no pudo moverse")
  // }
  
  // method lograMoverse() =  0.randomUpTo(2).roundUp().even()

}


object suenio inherits CondicionEspecial{
  override method poder() = 50
  
  override method intentaMoverse(pokemon){
    super(pokemon)
    pokemon.normalizar()
  }

}

class Confusion inherits CondicionEspecial{
  // var  turnosQueDura  = 0 
  const  turnosQueDura  = 0 


  method poder() = 40 * turnosQueDura

  override method intentaMoverse(pokemon){
    self.pasoUnTurno(pokemon)
    try{
      super(pokemon)
      // self.pasoUnTurno(pokemon)
    } 
    catch e : NoPuedeMoverseException{
      pokemon.recibirDanio(20)
      // self.pasoUnTurno(pokemon)
      throw new NoPuedeMoverseException(message = "El pokemon no puede moverse y se saltimo a si mismo")
    } 
    // then always {
    //   self.pasoUnTurno(pokemon)
    // }
  }
  
  // method pasoUnTurno(pokemon){
  //   // turnosQueDura -= 1
  //   if(turnosQueDura == 0){
  //     pokemon.normalizar()
  //   }else{
  //     pokemon.condicion(new Confusion(turnosQueDura = turnosQueDura -1))
  //   }
  // }

  method pasoUnTurno(pokemon){
    // turnosQueDura -= 1
    if(turnosQueDura > 1){
      pokemon.condicion(new Confusion(turnosQueDura = turnosQueDura -1))
    }else{
      pokemon.normalizar()
    }
  }

}

//* Condicion normal

object normal{
  method intentaMoverse(pokemon){
    // Vacio 
  }
}

//* EXCEPCIONES /////////
class NoPuedeMoverseException inherits Exception{

}


class MovimientoAgotadoException inherits Exception{

}
/*
>>> pokemon.grositud()

////////

>>> movimiento.usarEntre(usuario, contrincante)


>>> pokemon.lucharContra(contrincante)
*/