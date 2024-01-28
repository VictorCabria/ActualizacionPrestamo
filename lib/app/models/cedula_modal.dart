class Cedula {
  String? id;
  String? cedula;

  Cedula({
    this.id,
    this.cedula,
  });

  factory Cedula.fromJson(map) {
    return Cedula(
      id: map.id,
      cedula: map['cedula'],
    );
  }
  factory Cedula.fromDinamic(dinamico) {
    var idMap = dinamico["id"];
    return Cedula(
      id: idMap,
      cedula: dinamico['cedula'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cedula'] = cedula;

    return data;
  }
}
