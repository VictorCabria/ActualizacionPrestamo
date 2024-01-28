class Prestamo {
  String? id;
  String? clienteId;
  String? clientName;
  String? clienttipo;
  String? cobradorId;
  String? detalle;
  String? fecha;
  String? fechalimite;
  double? monto;
  String? zonaId;
  bool? refinanciado;
  bool? renovado;
  bool? listanegra;
  /* Timestamp? primerprestamo; */
  int? numeroDeCuota;
  double? porcentaje;
  String? puntoDeReferencia;
  String? recorrido;
  double? saldoPrestamo;
  String? sesionId;
  String? tipoPrestamoId;
  double? totalPrestamo;
  double? valorCuota;
  /* List<Recaudo>? recaudos; */
  String? fechaPago;
  String? estado;

  Prestamo(
      {this.id,
      this.clienteId,
      this.cobradorId,
      this.detalle,
      this.fecha,
      this.monto,
      this.zonaId,
      this.numeroDeCuota,
      this.fechalimite,
      this.porcentaje,
      this.refinanciado,
      this.renovado,
      this.listanegra,
      this.puntoDeReferencia,
      this.recorrido,
      this.fechaPago,
      this.saldoPrestamo,
      this.sesionId,
      this.estado,
      this.tipoPrestamoId,
      this.totalPrestamo,
      this.valorCuota});

/*   void actualizarEstado() {
    // this.estado = consta .estadoPrestamo[estado];
    if (saldoPrestamo! > 0) {
      DateTime fechaActual = DateTime.now();
      DateTime fechaPago = DateTime.parse(this.fechaPago!);

      int dias = fechaActual.difference(fechaPago).inDays;
      print("dias $dias");
      if (dias == 0) {
        estado = StatusPrestamo.aldia.name;
      } else if (dias > 0 && dias <= 5) {
        estado = StatusPrestamo.atrasado.name;
      } else if (dias > 5) {
        estado = StatusPrestamo.vencido.name;
      }
    }
  } */

  factory Prestamo.fromJson(json) {
    print("object");
    return Prestamo(
      id: json.id,
      clienteId: json['cliente'],
      cobradorId: json['cobrador'],
      detalle: json['detalle'],
      fecha: json['fecha'],
      monto: json['monto'],
      zonaId: json['zonaId'],
      estado: json['estado'],
      fechalimite: json['fechalimite'],
      refinanciado: json['refinanciado'],
      renovado: json['renovado'],
      listanegra : json['listanegra'],
      numeroDeCuota: json['numero_de_cuota'],
      porcentaje: json['porcentaje'],
      fechaPago: json['fechaPago'],
      puntoDeReferencia: json['punto_de_referencia'],
      recorrido: json['recorrido'],
      saldoPrestamo: json['saldo_prestamo'],
      sesionId: json['sesion_id'],
      tipoPrestamoId: json['tipo_prestamo'],
      totalPrestamo: json['total_prestamo'],
      valorCuota: json['valor_cuota'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['cliente'] = clienteId;
    data['cobrador'] = cobradorId;
    data['detalle'] = detalle;
    data['fecha'] = fecha;
    data['monto'] = monto;
    data['zonaId'] = zonaId;
    data['refinanciado'] = refinanciado;
    data['renovado'] = renovado;
    data['fechalimite'] = fechalimite;
    data['listanegra'] = listanegra;
    data['numero_de_cuota'] = numeroDeCuota;
    data['porcentaje'] = porcentaje;
    data['punto_de_referencia'] = puntoDeReferencia;
    data['recorrido'] = recorrido;
    data['fechaPago'] = fechaPago;
    data['saldo_prestamo'] = saldoPrestamo;
    data['sesion_id'] = sesionId;
    data['tipo_prestamo'] = tipoPrestamoId;
    data['total_prestamo'] = totalPrestamo;
    data['valor_cuota'] = valorCuota;
    data['estado'] = estado;

    return data;
  }
}
