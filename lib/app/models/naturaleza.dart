class Naturaleza {
  String? id;
  String? tipo;

  Naturaleza({
    this.id,
    this.tipo,
  });

  factory Naturaleza.fromJson(map) {
    return Naturaleza(
      id: map.id,
      tipo: map['tipo'],
    );
  }
  factory Naturaleza.fromDinamic(dinamico) {
    var idMap = dinamico['id'];
    return Naturaleza(
      id: idMap,
      tipo: dinamico['tipo'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['tipo'] = tipo;
    return data;
  }
}
