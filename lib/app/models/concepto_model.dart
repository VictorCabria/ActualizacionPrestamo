class Concepto {
  String? id;
  String? nombre;
  dynamic tipoconcepto;
  dynamic naturaleza;
  bool? conceptotransaccion;

  Concepto(
      {this.id,
      this.nombre,
      this.tipoconcepto,
      this.naturaleza,
      this.conceptotransaccion});

  factory Concepto.fromJson(map) {
    return Concepto(
      id: map.id,
      nombre: map['nombre'],
      tipoconcepto: map['tipoconcepto'],
      naturaleza: map['naturaleza'],
      conceptotransaccion: map['conceptotransaccion'],
    );
  }
  factory Concepto.fromDinamic(dinamico) {
    var idMap = dinamico["id"];
    return Concepto(
      id: idMap,
      nombre: dinamico['nombre'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nombre'] = nombre;
    data['tipoconcepto'] = tipoconcepto;
    data['naturaleza'] = naturaleza;
    data['conceptotransaccion'] = conceptotransaccion;

    return data;
  }
}
