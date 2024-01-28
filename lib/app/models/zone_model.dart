class Zone {
  String? id;
  String? nombre;

  Zone({this.id, this.nombre});

   factory Zone.fromJson(map) {
    return Zone(
        id: map.id,
        nombre: map['nombre'],
      );
  }
  factory Zone.fromDinamic(dinamico) {
    var idMap = dinamico["id"];
    return Zone(
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





/* class Zone {
  String? id;
  String? nombre;
  /*  List<Neighborhood>? neighborhoods; */

  Zone({
    this.id,
    this.nombre,
    /*  this.neighborhoods, */
  });

  Zone.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nombre'];
    return data;
  }
} */


/* 
class Neighborhood {
  String? id;
  String? name;

  Neighborhood.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'];
    return data;
  }
} */
