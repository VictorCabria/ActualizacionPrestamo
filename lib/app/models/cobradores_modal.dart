class Cobradores {
  String? id;
  dynamic tipocedula;
  String? cedula;
  String? nombre;
  String? pin;
  String? apellido;
  String? direccion;
  dynamic barrio;
  String? telefono;
  String? correo;
  String? celula;

  Cobradores(
      {this.id,
      this.tipocedula,
      this.cedula,
      this.nombre,
      this.pin,
      this.apellido,
      this.direccion,
      this.barrio,
      this.telefono,
      this.correo,
      this.celula});

  factory Cobradores.fromJson(map) {
    return Cobradores(
        id: map.id,
        tipocedula: map['tipocedula'],
        cedula: map['cedula'],
        nombre: map['nombre'],
        apellido: map['apellido'],
        pin: map['pin'],
        direccion: map['direccion'],
        barrio: map['barrio'],
        telefono: map['telefono'],
        correo: map['correo'],
        celula: map['celula']);
  }
  factory Cobradores.fromDinamic(dinamico) {
    var idMap = dinamico["id"];
    return Cobradores(
        id: idMap,
        tipocedula: dinamico['tipocedula'],
        cedula: dinamico['cedula'],
        nombre: dinamico['nombre'],
        apellido: dinamico['apellido'],
        direccion: dinamico['direccion'],
        pin: dinamico['pin'],
        barrio: dinamico['barrio'],
        telefono: dinamico['telefono'],
        correo: dinamico['correo'],
        celula: dinamico['celula']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['tipocedula'] = tipocedula;
    data['cedula'] = cedula;
    data['nombre'] = nombre;
    data['apellido'] = apellido;
    data['pin'] = pin;
    data['direccion'] = direccion;
    data['barrio'] = barrio;
    data['correo'] = correo;
    data['celula'] = celula;
    data['telefono'] = telefono;

    return data;
  }
}
