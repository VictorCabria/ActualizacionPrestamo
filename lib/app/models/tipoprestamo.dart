class TipoPrestamos {
  String? id;
  String? tipo;

  TipoPrestamos({this.id, this.tipo});

   factory TipoPrestamos.fromJson(map) {
    return TipoPrestamos(
        id: map.id,
        tipo: map['tipo'],
      );
  }
  factory TipoPrestamos.fromDinamic(dinamico) {
    var idMap = dinamico["id"];
    return TipoPrestamos(
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
