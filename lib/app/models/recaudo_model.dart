import 'package:prestamo_mc/app/utils/app_constants.dart';

class Recaudo {
  String? id;
  String? fecha;
  String? estado;
  String? zoneId;
  String? cobradorId;
  String? confirmacion;
  String? sessionId;
  double? total;

  Recaudo(
      {this.id,
      this.fecha,
      this.estado,
      this.zoneId,
      this.confirmacion,
      this.cobradorId,
      this.sessionId,
      this.total});

  Recaudo.nueva(this.fecha, this.cobradorId, String session, [this.zoneId]) {
    estado = StatusRecaudo.open.name;
    confirmacion = StatusRecaudo.nopassed.name;
    total = 0.0;
    sessionId = session;
  }

  Recaudo.autorizado(this.fecha, this.cobradorId, String session,
      [this.zoneId]) {
    estado = StatusRecaudo.passed.name;
    sessionId = session;
  }

  Recaudo.fromJson(json) {
    try {
      id = json.id;
    } catch (e) {
      id = null;
    }

    fecha = json['fecha'];
    estado = json['estado'];
    zoneId = json['id_zone'];
    confirmacion = json['confirmacion'];
    sessionId = json['sessionId'];
    cobradorId = json['id_cobrador'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fecha'] = fecha;
    data['estado'] = estado;
    data['id_zone'] = zoneId;
    data['confirmacion'] = confirmacion;
    data['sessionId'] = sessionId;
    data['id_cobrador'] = cobradorId;
    data['total'] = total;

    return data;
  }
}
