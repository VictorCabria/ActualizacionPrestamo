class Cuotas {
  String? id;
  String? idprestmo;
  String? idrecaudo;
  String? sesionId;
  int? ncuotas;
  String? fechadepago;
  String? fechaderecaudo;
  double? valorcuota;
  double? valorpagado;
  String? estado;

  Cuotas(
      {this.id,
      this.ncuotas,
      this.idprestmo,
      this.sesionId,
      this.fechadepago,
      this.fechaderecaudo,
      this.idrecaudo,
      this.valorcuota,
      this.valorpagado,
      this.estado});

  Cuotas.fromJson(json) {
    id = json['id'];
    ncuotas = json['ncuotas'];
    idprestmo = json['idprestmo'];
    sesionId = json['sesionId'];
    idrecaudo = json['idrecaudo'];
    fechadepago = json['fechadepago'];
    fechaderecaudo = json['fechaderecaudo'];
    valorcuota = json['valor'];
    valorpagado = json['valorapagar'];
    estado = json['estado'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ncuotas'] = ncuotas;
    data['fechadepago'] = fechadepago;
    data['idprestmo'] = idprestmo;
    data['sesionId'] = sesionId;
    data['idrecaudo'] = idrecaudo;
    data['fechaderecaudo'] = fechaderecaudo;
    data['valor'] = valorcuota;
    data['valorapagar'] = valorpagado;
    data['estado'] = estado;
    return data;
  }
}
