class Transacciones {
  String? id;
  String? concept;
  String? fecha;
  double? valor;
  String? cobrador;
  String? cobradorname;
  String? conceptname;
  String? idSession;
  String? detalles;
  double? tiponaturaleza;

  Transacciones(
      {this.id,
      this.concept,
      this.fecha,
      this.valor,
      this.cobrador,
      this.idSession,
      this.detalles,
      this.tiponaturaleza});

  factory Transacciones.fromJson(map) {
    return Transacciones(
        id: map.id,
        concept: map['concept'],
        fecha: map['fecha'],
        valor: map['valor'],
        cobrador: map['cobrador'],
        idSession: map['id_session'],
        detalles: map['detalles'],
        tiponaturaleza: map['tiponaturaleza']);
  }
  factory Transacciones.fromDinamic(dinamico) {
    var idMap = dinamico["id"];
    return Transacciones(
        id: idMap,
        concept: dinamico['concept'],
        fecha: dinamico['fecha'],
        valor: dinamico['valor'],
        idSession: dinamico['id_session'],
        cobrador: dinamico['cobrador'],
        detalles: dinamico['detalles'],
        tiponaturaleza: dinamico['tiponaturaleza']);
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['concept'] = concept;
    data['fecha'] = fecha;
    data['valor'] = valor;
    data['cobrador'] = cobrador;
    data['id_session'] = idSession;
    data['detalles'] = detalles;
    data['tiponaturaleza'] = tiponaturaleza;
    return data;
  }
}


/* class ModeloMap {
  String? id;
  String? nombre;

  ModeloMap({this.id, this.nombre});

  ModeloMap.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nombre'] = nombre;
    return data;
  }
} */
