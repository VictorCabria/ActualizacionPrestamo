class System {
  int? monto;
  bool? activarRefinanciacion;
  bool? activarZona;
  ModeloMap? ajusteSesionNeg;
  ModeloMap? ajusteSesionPos;
  bool? cobrarDomingos;
  bool? cobrarSabados;
  bool? cobrarViernes;
  ModeloMap? conceptoDePerdidas;
  ModeloMap? conceptoPrestamo;
  ModeloMap? conceptoRecaudo;
  ModeloMap? conceptoRefinanciacion;
  int? diasParaElPrimerCobro;
  bool? dividirValorPorMilEnMovil;
  ModeloMap? efectivoId;
  bool? modificarValorInicialEnSesion;
  int? nDAsVencidosParaRefinanciar;
  ModeloMap? tipoPrestamo;
  bool? valorDeCuotaEnCero;

  System(
      {this.monto,
      this.activarRefinanciacion,
      this.activarZona,
      this.ajusteSesionNeg,
      this.ajusteSesionPos,
      this.cobrarDomingos,
      this.cobrarSabados,
      this.cobrarViernes,
      this.conceptoDePerdidas,
      this.conceptoPrestamo,
      this.conceptoRecaudo,
      this.conceptoRefinanciacion,
      this.diasParaElPrimerCobro,
      this.dividirValorPorMilEnMovil,
      this.efectivoId,
      this.modificarValorInicialEnSesion,
      this.nDAsVencidosParaRefinanciar,
      this.tipoPrestamo,
      this.valorDeCuotaEnCero});

  System.fromJson(Map<String, dynamic> json) {
    monto = json['Monto'];
    activarRefinanciacion = json['activar_refinanciacion'];
    activarZona = json['activar_zona'];
    ajusteSesionNeg = json['ajuste_sesion_neg'] != null
        ? ModeloMap?.fromJson(json['ajuste_sesion_neg'])
        : null;
    ajusteSesionPos = json['ajuste_sesion_pos'] != null
        ? ModeloMap?.fromJson(json['ajuste_sesion_pos'])
        : null;
    cobrarDomingos = json['cobrar_domingos'];
    cobrarSabados = json['cobrar_sabados'];
    cobrarViernes = json['cobrar_viernes'];
    conceptoDePerdidas = json['concepto_de_perdidas'] != null
        ? ModeloMap?.fromJson(json['concepto_de_perdidas'])
        : null;
    conceptoPrestamo = json['concepto_prestamo'] != null
        ? ModeloMap?.fromJson(json['concepto_prestamo'])
        : null;
    conceptoRecaudo = json['concepto_recaudo'] != null
        ? ModeloMap?.fromJson(json['concepto_recaudo'])
        : null;
    conceptoRefinanciacion = json['concepto_refinanciacion'] != null
        ? ModeloMap?.fromJson(json['concepto_refinanciacion'])
        : null;
    diasParaElPrimerCobro = json['dias_para_el_primer_cobro'];
    dividirValorPorMilEnMovil = json['dividir_valor_por_mil_en_movil'];
    efectivoId = json['efectivo_id'] != null
        ? ModeloMap?.fromJson(json['efectivo_id'])
        : null;
    modificarValorInicialEnSesion = json['modificar_valor_inicial_en_sesion'];
    nDAsVencidosParaRefinanciar = json['n_días_vencidos_para_refinanciar'];
    tipoPrestamo = json['tipo_prestamo'] != null
        ? ModeloMap?.fromJson(json['tipo_prestamo'])
        : null;
    valorDeCuotaEnCero = json['valor_de_cuota_en_cero'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Monto'] = monto;
    data['activar_refinanciacion'] = activarRefinanciacion;
    data['activar_zona'] = activarZona;
    if (ajusteSesionNeg != null) {
      data['ajuste_sesion_neg'] = ajusteSesionNeg?.toJson();
    }
    if (ajusteSesionPos != null) {
      data['ajuste_sesion_pos'] = ajusteSesionPos?.toJson();
    }
    data['cobrar_domingos'] = cobrarDomingos;
    data['cobrar_sabados'] = cobrarSabados;
    data['cobrar_viernes'] = cobrarViernes;
    if (conceptoDePerdidas != null) {
      data['concepto_de_perdidas'] = conceptoDePerdidas?.toJson();
    }
    if (conceptoPrestamo != null) {
      data['concepto_prestamo'] = conceptoPrestamo?.toJson();
    }
    if (conceptoRecaudo != null) {
      data['concepto_recaudo'] = conceptoRecaudo?.toJson();
    }
    if (conceptoRefinanciacion != null) {
      data['concepto_refinanciacion'] = conceptoRefinanciacion?.toJson();
    }
    data['dias_para_el_primer_cobro'] = diasParaElPrimerCobro;
    data['dividir_valor_por_mil_en_movil'] = dividirValorPorMilEnMovil;
    if (efectivoId != null) {
      data['efectivo_id'] = efectivoId?.toJson();
    }
    data['modificar_valor_inicial_en_sesion'] = modificarValorInicialEnSesion;
    data['n_días_vencidos_para_refinanciar'] = nDAsVencidosParaRefinanciar;
    if (tipoPrestamo != null) {
      data['tipo_prestamo'] = tipoPrestamo?.toJson();
    }
    data['valor_de_cuota_en_cero'] = valorDeCuotaEnCero;
    return data;
  }
}

class ModeloMap {
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
}
