class SuperComputadora{
    const equipos = []

    var totalComplejidaComputada = 0

    method equiposActivos() = equipos.filter{ equipo  => equipo.activo()}
    method activo() = true

    method computo() = self.equiposActivos().sum{equipo => equipo.computo()}
    method consumo() = self.equiposActivos().sum{equipo => equipo.consumo()}

    // Me traigo los que mas computan y consumen
    method equipoQueMasConsumo() = self.equiposActivos().max{ equipo => equipo.consumo()}
    method equipoQueMasComputa() = self.equiposActivos().max{ equipo => equipo.computo()}
    method malConfigurada() = self.equipoQueMasComputa() != self.equipoQueMasConsumo()

    //* Aca cuando te dice que puede haber otras supercomputadoras dentro de mi 
    //* supercomputadora, justamente aca se ve bien como ya se contempla esto de que
    //* dentro de mi lista de computadoras, ya haya supercomputadoras
    method computar(problema){
        const subProblema = new Problema(complejidad = problema.complejidad() / self.equiposActivos().size())
        self.equiposActivos().forEach{ 
            // equipo => equipo.computar(new Problema(complejidad = problema.complejidad() / self.equiposActivos().size()))}
            equipo => equipo.computar(subProblema)} //? Aca 

        
        totalComplejidaComputada += problema.complejidad()
    }
}

class Problema{
    const property complejidad //* Posiblemente sobrediseño
}

class Equipo{
    var property modo 
    var property estaQuemado = false
    
    method activo() = !estaQuemado && self.computo() > 0

    method consumo() = modo.consumoDe(self)
    method computo() = modo.computoDe(self)

    method consumoBase()
    method computoBase()
    method computoExtraPorOverclock()
    method computar(problema) 

}
class A105 inherits Equipo{
    override method consumoBase() = 300
    override method computoBase() = 600
    override method computoExtraPorOverclock() = self.computoBase() * 1.3

    
}

class B2 inherits Equipo{
    var cantMicroChips = 20
    var consumoPlaca = 10

    override method consumoBase() = 50 * cantMicroChips + consumoPlaca
    override method computoBase() = (100* cantMicroChips).min(800) 
    override method computoExtraPorOverclock() = 20 * cantMicroChips


}
//*       //////////    MODO    //////////

object standar{
    method consumoDe(objeto) = objeto.consumoBase()
    method computoDe(objeto) = objeto.computoBase()
}

class Overclock{

    
    method consumoDe(objeto) = objeto.consumoBase() * 2
    //* Como el computo por overclock depende al equipo, delego en ese equipo
    //* creando un mensaje nuevo para ese extra de computo por overclock
    method computoDe(objeto) = objeto.computoBase() + objeto.computoExtraPorOverclock()
}

class AhorroDeEnergia{
    method consumoDe(objeto) = 200
    method computoDe(objeto) = self.consumoDe(objeto) / objeto.consumoBase() * objeto.computoBase()    
}