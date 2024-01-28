class Ajustes {
  String? id;
  String? positivo;
  String? negativo;
  double? monto;
  int? diasrefinanciacion;
  String? refinanciacion;
  String? tipoprestamoid;
  int? diasparacobro;
  String? conceptoid;
  bool? cobrarsabados;
  bool? cobrardomingos;

  Ajustes({
    this.id,
    this.positivo,
    this.negativo,
    this.tipoprestamoid,
    this.diasparacobro,
    this.diasrefinanciacion,
    this.refinanciacion,
    this.cobrarsabados,
    this.cobrardomingos,
    this.monto,
    this.conceptoid,
  });

  factory Ajustes.fromJson(json) {
    return Ajustes(
        id: json.id,
        positivo: json['positivo'],
        negativo: json['negativo'],
        monto: json['monto'],
        diasparacobro: json['diasparacobro'],
        diasrefinanciacion: json['diasrefinanciacion'],
        refinanciacion: json['refinanciacion'],
        cobrarsabados: json['cobrarsabados'],
        cobrardomingos: json['cobrardomingos'],
        tipoprestamoid: json['tipoprestamoid'],
        conceptoid: json['conceptoid']);
  }
  factory Ajustes.fromDinamic(dinamico) {
    var idMap = dinamico['id'];
    return Ajustes(
        id: idMap,
        positivo: dinamico['positivo'],
        negativo: dinamico['negativo'],
        monto: dinamico['monto'],
        refinanciacion: dinamico['refinanciacion'],
        diasparacobro: dinamico['diasparacobro'],
        diasrefinanciacion: dinamico['diasrefinanciacion'],
        cobrarsabados: dinamico['cobrarsabados'],
        cobrardomingos: dinamico['cobrardomingos'],
        tipoprestamoid: dinamico['tipoprestamoid'],
        conceptoid: dinamico['conceptoid']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['positivo'] = positivo;
    data['monto'] = monto;
    data['negativo'] = negativo;
    data['refinanciacion'] = refinanciacion;
    data['diasparacobro'] = diasparacobro;
    data['diasrefinanciacion'] = diasrefinanciacion;
    data['cobrarsabados'] = cobrarsabados;
    data['cobrardomingos'] = cobrardomingos;
    data['tipoprestamoid'] = tipoprestamoid;
    data['conceptoid'] = conceptoid;
    return data;
  }
}
