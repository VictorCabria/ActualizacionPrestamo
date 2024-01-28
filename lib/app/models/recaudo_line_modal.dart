import 'package:prestamo_mc/app/models/prestamo_model.dart';
import 'package:prestamo_mc/app/models/recaudo_model.dart';

class RecaudoLine {
  String? id;
  String? fecha;
  String? clientName;
  String? idSession;
  double? monto, cuota, total, saldo, saldoAnterior;
  String? idPrestamo;
  String? idCliente;
  String? idRecaudo;
  bool? procesado;

  RecaudoLine({
    this.id,
    this.fecha,
    this.monto,
    this.idPrestamo,
    this.idSession,
    this.idRecaudo,
    this.idCliente,
    this.saldoAnterior,
    this.cuota,
    this.total,
    this.saldo,
    this.procesado,
  });

  RecaudoLine.fromJson(json) {
    id = json.id;
    fecha = json ['fecha'];
    monto = json['monto'];
    idSession = json['id_session'];
    idPrestamo = json['prestamo'];
    saldo = json['saldo'];
    total = json['total'];
    saldoAnterior = json['saldoAnterior'];
    idRecaudo = json['id_recaudo'];
    idCliente = json['id_cliente'];
    cuota = json['cuota'];
    procesado = json['procesado'];
  }

  RecaudoLine.fromPrestamo(Prestamo prestamo, Recaudo recaudo) {
    fecha = DateTime.now().toString();
    monto = 0.0;
    idPrestamo = prestamo.id;
    idRecaudo = recaudo.id;
    idCliente = prestamo.clienteId;
    cuota = prestamo.valorCuota;
    total = prestamo.totalPrestamo;
    saldo = prestamo.saldoPrestamo;
    saldoAnterior = prestamo.saldoPrestamo;
    procesado = false;
    idSession = recaudo.sessionId;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fecha'] = fecha;
    data['prestamo'] = idPrestamo;
    data['id_session'] = idSession;
    data['monto'] = monto;
    data['total'] = total;
    data['saldo'] = saldo;
    data['saldoAnterior'] = saldoAnterior;
    data['id_recaudo'] = idRecaudo;
    data['id_cliente'] = idCliente;
    data['cuota'] = cuota;
    data['procesado'] = procesado;
    return data;
  }
}
