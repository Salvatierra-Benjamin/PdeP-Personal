// object julieta{
//   var fuerza = 80
//   var punteria = 20
//   var tickets = 15
//   var cansancio = 100

//   method punteria() = punteria
//   method cansancio() = cansancio  
//   method esFuerte() = fuerza > 75
 

//   // method jugarTiroAlBlanco(){
//   //   cansancio -= 3
//   // }
//   method ganarJuego(juego, parametroDeTicket){
//     tickets += juego.entregarTicket(self, parametroDeTicket)
//   }

//   method jugarJuego(juego){
//     juego.jugar(self)
//   }

// }


// object tiroAlBlanco{

//   method jugar(jugador){
//     jugador.cansancio()- 3
//   }  

//   method entregarTicket(jugador, patoQueTira){
//     10 * jugador.punteria() * patoQueTira
//   } 

// }

// object pruebaDeFuerza{
//   method entregarTicket(jugador){
//     if(jugador.esFuerte()) 20
//   }

// }


object julieta{
    var property tickets = 15
    // var tickets = 15
    var cansancio = 0
    // var punteria = 20 //? Hacer esto no me la posibilidad
    // de que otros objetos utilicen la punteria. 
    method punteria() = 20

    //poner var fuerza = .. estaria mal porque siempre queremos 
    // que se calcule
    method fuerza() = 80 - cansancio 

    // method tickets() = tickets 
    // method tickets(nuevoTickets) { 
    //     tickets +=  nuevoTickets
    //     }

    method jugar(juego){
        tickets = tickets + juego.ticketsGanados(self)
        cansancio = cansancio + juego.cansancionQueProduce()
    }    

    method canjearJuguete(premio) = tickets >= premio.costo()
    
    
}

//* JUEGOS

object tiroAlBlanco{

    //! Aca no debeira tambien entrar por parametros la 
    //! cant. de patitos?
    //? Yo quiero que todo esto retorne para que sea julieta
    //? quien modifica sus valores
    // method ticketsGanados(jugador){
    //     (jugador.punteria() / 10).roundUp() 
    // }
    method ticketsGanados(jugador) = (jugador.punteria()/20).roundUp()

    method cansancioQueProduce() = 3
}

object tiroDeFuerza{

    method ticketsGanados(jugador) = 
        if(jugador.fuerza() > 75) 20 else 0


    method cansancioQueProduce() = 8
}

object ruedaDeLaFortuna{

    var property aceitada = true 

    // var aceitada = true
    // method aceitada() = aceitada
    // method aceitada(nuevoValor) {
    //     aceitada = nuevoValor
    // }

    //! Aca es donde me invento un argumento pero para que cumpla
    //! solo con el polimorfismo
    method ticketsGanados(jugador) = 0.randomUpTo(20).roundUp()

    method cansancioQueProduce() = if(aceitada) 0 else 1
}


object osito{
    method costo() = 45
}

object taladro{

    var property costo = 100
}

// object duenio{
//     var precioOsito = 45
//     var precioDolar = 100
//     var precioBaseTaladro = 100
//     method precioTaladro() = precioDolar * precioBaseTaladro

    
//     method entregarJuguete(jugador){
//         if(jugador.tickets() > precioOsito) "precio" else "nono"
//     } 

// }


object gerundio {
    method puedeCanjear(premio) = true
}