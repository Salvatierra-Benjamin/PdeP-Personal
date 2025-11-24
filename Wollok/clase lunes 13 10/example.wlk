object pepita {
  var energy = 100
  
  method energy() = energy
  
  method fly(minutes) {
    energy -= minutes * 3
  }
}

// Las excepciones no se usaran mucho en la materia, se vera más en diseño o desarrollo de software
// throw new exception será evaluado.


// para que utilizar clases? por que repetian la misma logica, además tenian "alguito" diferente

// Con el super hacemos que entienda el metodo, pero que además haga algo más


habria que modelar los usuarios que tienen cupones? 


// Con la herencia, no puedo modificar el nivel de un objeto. Puede que tenga delegar en un objeto diferente al nivel para 
// que pueda cambiar de nivel

