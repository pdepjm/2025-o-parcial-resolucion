


class Repartidor {
    var pedidosQueHizo = 0 // "Transportes" = "pedidos"

    method puedeAceptar(solicitud) = self.puedeSoportar(solicitud.peso()) and !self.estaHabilitado()

    method costoBase() = 1000 

    method pertenece(repartidor) = repartidor == self

    method finalizarTransporte(){
        pedidosQueHizo += 1
    }

    method puedeSoportar(peso)

    method estaHabilitado()
}

class RepartidorRobot inherits Repartidor {

    override method puedeSoportar(peso) = peso > 5 and peso < 1000

    override method estaHabilitado() = pedidosQueHizo <= 100

    method costo() = self.costoBase() + 500
}


class RepartidorHumano inherits Repartidor {
    var mejora = sinMejoras

    method cambiarMejora(nuevaMejora){
        mejora = nuevaMejora
    }

    override method finalizarTransporte(){
        super()
        mejora = sinMejoras
    }

    override method estaHabilitado() = self.costo() <= 10000

    override method puedeSoportar(peso) = peso <= mejora.pesoMaximo()

    method costo() = self.costoBase() + mejora.agilidad() + pedidosQueHizo
}


object mejoraSuperFuerza {
    method agilidad() = 20
    method pesoMaximo() = 200
}

object mejoraSuperAgilidad {
    method agilidad() = 100
    method pesoMaximo() = 5
}

object sinMejoras {
    method agilidad() = 45
    method pesoMaximo() = 40
}