class Barrio {
  String? id;
  String? nombre;
  dynamic zona;

  Barrio({this.id, this.nombre, this.zona});

  factory Barrio.fromJson(map) {
    return Barrio(
        id: map.id,
        nombre: map['nombre'],
        zona: map['zona'],
      );
  }
  factory Barrio.fromDinamic(dinamico) {
    var idMap = dinamico["id"];
    return Barrio(
      id: idMap,
      nombre: dinamico['nombre'],
      zona: dinamico['zona'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nombre'] = nombre;
    data['zona'] = zona;
    return data;
  }
}
