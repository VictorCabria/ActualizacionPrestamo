import '../utils/app_constants.dart';

class Session {
  String? id;
  String? estado;
  String? fecha;
  String? cobradorId;
  String? cobradorname;
  String? zonaId;
  String? sesionAnteriorId;
  double? valorInicial;
  double? ingresos;
  double? gastos;
  double? costos;
  double? pyg;
/*   int? prestamoCar;
  int? prestamoCnt;
  int? prestamoEfe;
  int? recaudoCar;
  int? recaudoCnt;
  int? recaudoEfe;
  int? refinanciacionCar;
  int? refinanciacionCnt;
  int? refinanciacionEfe;
  int? renovacionCar;
  int? renovacionCnt;
  int? renovacionEfe;
  int? saldoActualCar;
  int? saldoActualEfe;
  int? saldoAnteriorCar;
  int? saldoAnteriorEfe;
  int? transaccionCar;
  int? transaccionCnt;
  int? transaccionEfe; */

  Session(
      {this.id,
      this.estado,
      this.fecha,
      this.cobradorId,
      this.zonaId,
      this.costos,
      this.gastos,
      this.ingresos,
      this.sesionAnteriorId,
      this.pyg,
      this.valorInicial
      /*   this.prestamoCar,
      this.prestamoCnt,
      this.prestamoEfe,
      this.recaudoCar,
      this.recaudoCnt,
      this.recaudoEfe,
      this.refinanciacionCar,
      this.refinanciacionCnt,
      this.refinanciacionEfe,
      this.renovacionCar,
      this.renovacionCnt,
      this.renovacionEfe,
      this.saldoActualCar,
      this.saldoActualEfe,
      this.saldoAnteriorCar,
      this.saldoAnteriorEfe,
      this.transaccionCar,
      this.transaccionCnt,
      this.transaccionEfe */
      });

  Session.nueva(this.fecha, this.cobradorId, this.valorInicial,
      [this.zonaId, Session? session]) {
    estado = "open";
    costos = 0.0;
    ingresos = 0.0;
    gastos = 0.0;
    pyg = valorInicial;
    if (session != null) {
      sesionAnteriorId = session.id;

//       if (session.pyg != valorInicial) {

//         if(session.pyg)
// /*         Transacciones transacciones = Transacciones(
//             cobrador: cobradorId,
//             valor: valorInicial,
//             idSession: id,
//             fecha: fecha);
//         print(cobradorId);
//         transaccionesService.savetransacciones(transacciones); */
//       } else {
//         pyg = session.pyg;
//       }
    }
    /* prestamoCar = 0;
    prestamoCnt = 0;
    prestamoEfe = 0;
    recaudoCar = 0;
    recaudoCnt = 0;
    recaudoEfe = 0;
    refinanciacionCar = 0;
    refinanciacionCnt = 0;
    refinanciacionEfe = 0;
    renovacionCar = 0;
    renovacionCnt = 0;
    renovacionEfe = 0;
    saldoActualCar = 0;
    saldoActualEfe = 0;
    saldoAnteriorCar = 0;
    transaccionCar = 0;
    transaccionCnt = 0;
    transaccionEfe = 0;
    saldoAnteriorEfe = 0; */
  }

  updatePyG(TipoOperacion tipo, double valor, {bool crear = true}) {
    switch (tipo) {
      case TipoOperacion.ingreso:
        if (crear) {
          pyg = pyg != null ? pyg! + valor : valor;
          ingresos = ingresos != null ? ingresos! + valor : valor;
        } else {
          pyg = pyg != null ? pyg! - valor : valor;
          ingresos = ingresos != null ? ingresos! - valor : valor;
        }

        break;
      case TipoOperacion.costo:
        if (crear) {
          pyg = pyg != null ? pyg! - valor : valor;
          costos = costos != null ? costos! - valor : valor;
        } else {
          pyg = pyg != null ? pyg! + valor : valor;
          costos = costos != null ? costos! + valor : valor;
        }
        break;
      case TipoOperacion.gasto:
        if (crear) {
          pyg = pyg != null ? pyg! - valor : valor;
          gastos = gastos != null ? gastos! - valor : valor;
        } else {
          pyg = pyg != null ? pyg! + valor : valor;
          gastos = gastos != null ? gastos! + valor : valor;
        }
        break;
      default:
    }
  }

  Session.fromJson(json) {
    try {
      id = json.id;
    } catch (e) {
      id = null;
    }
    estado = json['estado'];
    fecha = json['fecha'];
    zonaId = json['zonaId'];
    cobradorId = json['cobradorId'];
    sesionAnteriorId = json['sesion_AnteriorId'];
    valorInicial = json['valor_Inicial'];
    ingresos = json['ingresos'];
    gastos = json['gastos'];
    costos = json['costos'];
    pyg = double.parse(json['pyg'].toString());
    /*   prestamoCar = json['prestamo_car'];
    prestamoCnt = json['prestamo_cnt'];
    prestamoEfe = json['prestamo_efe'];
    recaudoCar = json['recaudo_car'];
    recaudoCnt = json['recaudo_cnt'];
    recaudoEfe = json['recaudo_efe'];
    refinanciacionCar = json['refinanciacion_car'];
    refinanciacionCnt = json['refinanciacion_cnt'];
    refinanciacionEfe = json['refinanciacion_efe'];
    renovacionCar = json['renovacion_car'];
    renovacionCnt = json['renovacion_cnt'];
    renovacionEfe = json['renovacion_efe'];
    saldoActualCar = json['saldo_actual_car'];
    saldoActualEfe = json['saldo_actual_efe'];
    saldoAnteriorCar = json['saldo_anterior_car'];
    saldoAnteriorEfe = json['saldo_anterior_efe'];
    transaccionCar = json['transaccion_car'];
    transaccionCnt = json['transaccion_cnt'];
    transaccionEfe = json['transaccion_efe']; */
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['estado'] = estado;
    data['fecha'] = fecha;
    data['zonaId'] = zonaId;
    data['cobradorId'] = cobradorId;
    data['sesion_AnteriorId'] = sesionAnteriorId;
    data['valor_Inicial'] = valorInicial;
    data['ingresos'] = ingresos;
    data['gastos'] = gastos;
    data['costos'] = costos;
    data['pyg'] = pyg;
    /*  data['prestamo_car'] = prestamoCar;
    data['prestamo_cnt'] = prestamoCnt;
    data['prestamo_efe'] = prestamoEfe;
    data['recaudo_car'] = recaudoCar;
    data['recaudo_cnt'] = recaudoCnt;
    data['recaudo_efe'] = recaudoEfe;
    data['refinanciacion_car'] = refinanciacionCar;
    data['refinanciacion_cnt'] = refinanciacionCnt;
    data['refinanciacion_efe'] = refinanciacionEfe;
    data['renovacion_car'] = renovacionCar;
    data['renovacion_cnt'] = renovacionCnt;
    data['renovacion_efe'] = renovacionEfe;
    data['saldo_actual_car'] = saldoActualCar;
    data['saldo_actual_efe'] = saldoActualEfe;
    data['saldo_anterior_car'] = saldoAnteriorCar;
    data['saldo_anterior_efe'] = saldoAnteriorEfe;
    data['transaccion_car'] = transaccionCar;
    data['transaccion_cnt'] = transaccionCnt;
    data['transaccion_efe'] = transaccionEfe; */
    return data;
  }
}
