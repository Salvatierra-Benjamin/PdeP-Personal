//Los orcos 
// Los humanos



// class Personaje {
//   var fuerza
//   var inteligencia 
//   // method rol()

//   method potenciaOfenciva(objeto) = objeto.fuerza() * 10 + self.extraBase(objeto)
  
  
//   method extraBase(mascota)

// }

// class Guerrero inherits Personaje{

//   override method extraBase(mascota) = 100 
// }

// class Cazador inherits Personaje{
//   var tieneMascota = true
//   override method extraBase(mascota) = mascota.tieneGarras()

// }

// class Brujo inherits Personaje{
//   //No tiene extra
// }

// class Orco inherits Personaje{
//   override method potenciaOfenciva(objeto) =  super(objeto) * 10/100 
  
// }


// class Mascota{
//   var fuerza
//   var edad
//   var property  tieneGarras = true
// }




// class Localidad{

// }


/*
* DESDE EL PUNTO DE VISTA CLASES
* Cada personaje (humano o orco) puede ser guerrero, cazador o brujo
* hacer una clase para cada rol (guerrero, cazador o brujo) repito mucha logica
* y aun mas si tengo que hacer la combinacion de rol x personaje humano o orco
* Esto es muy malo porque repito logica por cada combinacion, y si llego a querer
* agregar más personajes/roles voy a repetir aún más logica.

* Aca entra en juego la composicion, donde 
*/

/*
* DESDE EL PUNTO DE VISTA HERENCIA.
* Si llego a querer contruir una clase para Humano y Orco, y de cada una 
* salgan los humanosBrujo, OrcoBrujo, se complica aún mas porque ahora esta aun más
* alejada la repeticion de logica. 
* Y si llega a aparecer un nuevo rol (o sea que en cada personaje tenga un nuevo rol),
* lo tendre que agregar para cada personaje. 

* Y si aparece una nueva raza, tengo que meter todos los roles en la nueva
* raza. 

* El enunciado que pueda cambiar de roles, y con clases heredas no lo puedo cambiar.


* Herencia en este caso: 
? Si aparecen cosas nuevas, la tengo que repetir en varios lados.
? La repeticion de logica es mas dificil de encontrar.
*/

//? PERSONAJES

class Personaje {
  const property fuerza
  const property inteligencia
  var property rol 
  //!NO, no todos los personajes tiene mascota
  // var property mascota 
  

  method potensialOfensivo() = 10* fuerza + rol.potencialOfensivoExtra()
  
  //* Generzalizo algo para que las subclases la pisen a su criterio
  method esGroso() = self.esInteligente() || self.esGrosoParaSuRol()

  method esInteligente() 
  method esGrosoParaSuRol() = rol.esGroso(self)
  
}

class Humano inherits Personaje{
  //Por ahora no hacemos nada
  override method esInteligente() = inteligencia > 50
  
}

class Orco inherits Personaje{
  //* Ejecuto lo que estaba definido arriba más un 
  //* 10 por cierto más
  //* Si llega a aparecer un nuevo personaje, es facilmente agregar
  //* el potensialOfensivo()
  override method potensialOfensivo() = super() * 1.1
  override method esInteligente() = false

}
// class Elfo inherits Personaje{
//   //? Ejemplo
//   override method potensialOfensivo() = super() - 100
// }




//? ROLES

//* No hace falta porque la logica de cada rol
//* es muy diferente
// class Rol{

// }

object guerrero{
  //* El Personaje conoce al Rol, pero el Rol no conoce al personaje
  //* Personaje -> Rol
  method esGroso(objeto)= objeto.fuerza() > 50
  method potencialOfensivoExtra() = 100
}
// object cazador{

object brujo{
  //* Esto lo hago para que se acepte el polimorfismo
  method potencialOfensivoExtra() = 0 
  method esGroso(algo) = true
}

class Cazador{  
//* Deja de ser objeto porque no todos los 
//* cazadores tendran mascota o la misma mascota
  var mascota 
  method potencialOfensivoExtra(){
    mascota.potensialOfensivo()
  }

  //* Delego a la mascota saber cuando es longeva. 
  //* Por ejemplo: si viene un dragon, este no será longeva a la misma edad
  // method esGroso(algo) = mascota.edad() > 10 //! NONO!! 

  method esGroso(algo) = mascota.esLongeva()
  
  
}

class Mascota{
  const fuerza
  const edad
  const tieneGarras

  method potencialOfensivo() = if(tieneGarras) fuerza * 2 else fuerza

  method esLongeva() = edad > 10
}

class Dragon inherits Mascota{
  override method esLongeva() = edad > 1000000
}


//? ZONAS


// cosnt ejercito = [unJercito, OtroEjercito] //! Nonoo

class Ejercito{
  const property miembros = []

  method potencialOfensivo() = miembros.sum{ personaje => personaje.potencialOfensivo() }
  
  method invadir(zona){
    if(zona.potencialOfensivo() < self.potencialOfensivo()){
      zona.seOcupadaPor(self)
    } 
  }
}


class Zona{
  var habitantes

  method potencialOfensivo() = habitantes.potencialOfensivo()

  method seOcupada(ejecito) {
    habitantes = ejecito
  }
  
}

class Ciudad inherits Zona{
  override method potencialOfensivo() = super() + 300
}

class Aldea inherits Zona{

  const maxHabitantes = 50

  override method seOcupada(ejecito){
    if(ejecito.miembros().size() > maxHabitantes){

      const nuevosHabitantes = ejecito.miembros().sortedBy{uno, otro => uno.potencialOfensivo() > otro.PotencialOfensivo()}.take(10)

      super(new Ejercito(miembros = nuevosHabitantes))
      ejecito.miembros().removeAll(nuevosHabitantes)
  }
    else super(ejecito)
  }
  
  
}