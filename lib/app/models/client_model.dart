class Client {
  String? id;
  String? apodo;
  String? recorrido;
  dynamic barrio;
  String? cedula;
  String? correo;
  String? direccion;
  bool? listanegra;
  String? nombre;
  String? telefono;

  Client(
      {this.id,
      this.apodo,
      this.recorrido,
      this.barrio,
      this.cedula,
      this.listanegra,
      this.correo,
      this.direccion,
      this.nombre,
      this.telefono});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    apodo = json['apodo'];
    recorrido = json['recorrido'];
    barrio = json['barrio'];
    cedula = json['cedula'];
    listanegra = json['listanegra'];
    correo = json['correo'];
    direccion = json['direccion'];
    nombre = json['nombre'];
    telefono = json['telefono'];
  }

  factory Client.fromJsonMap(map) {
    return Client(
        id: map.id,
        apodo: map['apodo'],
        recorrido: map['recorrido'],
        barrio: map['barrio'],
        cedula: map['cedula'],
        listanegra: map['listanegra'],
        correo: map['correo'],
        direccion: map['direccion'],
        nombre: map['nombre'],
        telefono: map['telefono']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['apodo'] = apodo;
    data['barrio'] = barrio;
    data['recorrido'] = recorrido;
    data['cedula'] = cedula;
    data['listanegra'] = listanegra;
    data['correo'] = correo;
    data['direccion'] = direccion;
    data['nombre'] = nombre;
    data['telefono'] = telefono;
    return data;
  }
}
