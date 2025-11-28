class Caravana {
  const repartidores

  method pertenece(repartidor) = repartidores.contains(repartidor)

  method costo() = repartidores.sum({repartidor => repartidor.costo()}) + 5000
}