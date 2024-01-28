class Diasnocobro {
  String? id;
  String? dia;

  Diasnocobro({this.id, this.dia});

  factory Diasnocobro.fromJson(json) {
    return Diasnocobro(
      id: json.id,
      dia: json['dia'],
    );
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['dia'] = dia;

    return data;
  }
}
