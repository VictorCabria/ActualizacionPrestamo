class TypePrestamo {
  String? id;
  String? nombre;
  int? cuotas;
  int? meses;
  double? porcentaje;
  dynamic tipo;

  TypePrestamo(
      {this.id,
      this.nombre,
      this.cuotas,
      this.meses,
      this.porcentaje,
      this.tipo});
  factory TypePrestamo.fromJson(map) {
    return TypePrestamo(
        id: map.id,
        nombre: map['nombre'],
        cuotas: map['cuotas'],
        meses: map['meses'],
        porcentaje: map['porcentaje'].toDouble(),
        tipo: map['tipo']);
  }
  factory TypePrestamo.fromDinamic(dinamico) {
    var idMap = dinamico["id"];
    return TypePrestamo(
        id: idMap,
        nombre: dinamico['nombre'],
        cuotas: dinamico['cuotas'],
        meses: dinamico['meses'],
        porcentaje: dinamico['porcentaje'],
        tipo: dinamico['tipo']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nombre'] = nombre;
    data['cuotas'] = cuotas;
    data['meses'] = meses;
    data['porcentaje'] = porcentaje;
    data['tipo'] = tipo;
    return data;
  }
}
