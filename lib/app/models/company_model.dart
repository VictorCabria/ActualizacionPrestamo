import '/app/models/client_model.dart';
import '/app/models/system_model.dart';
import '/app/models/transaction_model.dart';
import '/app/models/type_prestamo_model.dart';

import 'zone_model.dart';
import 'concept_model.dart';

class Company {
  String? cedula;
  String? direccion;
  String? nombre;
  String? telefono;
  System? system;
  List<Zone>? zones;
  List<Concept>? concepts;
  List<TypePrestamo>? types;
  List<Client>? clients;
  List<Transacciones>? transactions;

  Company({
    this.cedula,
    this.direccion,
    this.nombre,
    this.telefono,
    this.zones,
    this.concepts,
    this.types,
  });

  Company.fromJson(Map<String, dynamic> json) {
    cedula = json['cedula'];
    direccion = json['direccion'];
    nombre = json['nombre'];
    telefono = json['telefono'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cedula'] = cedula;
    data['direccion'] = direccion;
    data['nombre'] = nombre;
    data['telefono'] = telefono;
    return data;
  }
}
