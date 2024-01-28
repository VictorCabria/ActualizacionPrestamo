class TipoConcepto {
  String? id;
  String? nombre;

  TipoConcepto({
    this.id,
    this.nombre,
  });

  factory TipoConcepto.fromJson(map) {
    return TipoConcepto(
      id: map.id,
      nombre: map['nombre'],
    );
  }
  factory TipoConcepto.fromDinamic(dinamico) {
    var idMap = dinamico["id"];
    return TipoConcepto(
      id: idMap,
      nombre: dinamico['nombre'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nombre'] = nombre;
    return data;
  }
}
