import repartidores.Caravana
class DetallesDeSolicitud {
  const distancia
  const peso
  const esFragil

  method distancia() = distancia
  method peso() = peso

  method esCritica() = peso > 500 and esFragil and distancia > 5000 
}


class TransporteEnCurso{
  const detalles
  const responsable

  method valorFinal() = detalles.distancia() + detalles.peso() - responsable.costo()

  method estaInvolucrado(repartidor) = responsable.pertence(repartidor)

  method finalizar() = responsable.finalizarTransporte()
}


object centralDeTransporte {
  const transportesEnCurso = []
  const repartidores = []
  var ganancias = 0

  method procesarSolicitud(solicitud){
    const responsableDisponible = self.responsableDisponiblePara(solicitud)
    const nuevoTransporte = new TransporteEnCurso(detalles = solicitud, responsable= responsableDisponible)
    transportesEnCurso.add(nuevoTransporte)
  }

  method transportesEnCurso() = transportesEnCurso

  method responsableDisponiblePara(solicitud){
    if(!solicitud.esCritica()){
      return self.repartidorPara(solicitud)
    }
    else{
      return self.caravanaPara(solicitud)
    }
  }

  method repartidorPara(solicitud) {
    const repartidoresDisponibles = self.repartidoresDisponiblesPara(solicitud)
    
    if(repartidoresDisponibles.isEmpty()){
      throw new DomainException(message="No hay repartidores disponibles para la solicitud")
    }

    return repartidoresDisponibles.anyOne()
  }

  method caravanaPara(solicitud) {
    const cantidadNecesaria = 3
    const repartidoresDisponibles = self.repartidoresDisponiblesPara(solicitud)

    if(repartidoresDisponibles.size() < cantidadNecesaria){
      throw new DomainException(message="No hay repartidores disponibles suficientes para formar la caravana")
    } 

    return new Caravana(repartidores = repartidoresDisponibles.take(cantidadNecesaria))
  }

  method repartidoresDisponiblesPara(solicitud) = repartidores.filter({repartidor => repartidor.puedeAceptar(solicitud) and !self.estaOcupado(repartidor)})

  method estaOcupado(repartidor) = transportesEnCurso.any({transporte => transporte.estaInvolucrado(repartidor)})

  method finalizarTransporte(transporte, horas){
    transportesEnCurso.remove(transporte)
    transporte.finalizar()
    ganancias += transporte.valorFinal() - horas
  }
  
}






