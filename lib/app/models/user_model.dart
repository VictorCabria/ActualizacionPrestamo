class Usuarios {
  String? id;
  bool? activo;
  String? correo;
  bool? isAdmin;
  String? nombre;

  Usuarios({
    this.id,
    this.activo,
    this.correo,
    this.isAdmin,
    this.nombre,
  });

  factory Usuarios.fromJson(map) {
    return Usuarios(
      id: map.id,
      activo: map['activo'],
      nombre: map['nombre'],
      isAdmin: map['isAdmin'],
      correo: map['correo'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['activo'] = activo;
    data['correo'] = correo;
    data['isAdmin'] = isAdmin;
    data['nombre'] = nombre;

    return data;
  }
}
