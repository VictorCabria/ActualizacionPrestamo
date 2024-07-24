import 'package:get/get.dart';

import '../../../../models/cobradores_modal.dart';
import '../../../../models/recaudo_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/model_services/recaudos_service.dart';
import '../../../../services/model_services/zona_service.dart';
import '../../../../utils/references.dart';

class VentanarecaudosseguimientoController extends GetxController {
  RxList<Recaudo> recaudo = RxList<Recaudo>([]);
  late Stream<List<Recaudo>> recaudoStream;
  Cobradores? cobrador;
  List<Recaudo> get recaudoget => recaudo;
  RxBool isloading = false.obs;
  final zona = "".obs;
  final montorecaudos = 0.0.obs;

  @override
  void onInit() {
    cobrador = Get.arguments['cobradores'];
    recaudoStream = getrecaudo();
    init();
    super.onInit();
  }

  init() {
    recaudoStream.listen((event) async {
      recaudo.value = event;
      montoyinteres();
    });
  }

  getrecaudo() {
    return recaudoService
        .obtenerlistrecaudos()
        .where('id_cobrador', isEqualTo: cobrador!.id)
        .where('confirmacion', isEqualTo: "passed")
        .orderBy('fecha', descending: true)
        .snapshots()
        .map((event) => event.docs.map((e) => Recaudo.fromJson(e)).toList());
  }

  getzonaById(String id) async {
    var response = await zonaService.getzonaById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  ventanarecaudo(Recaudo recaudo) {
    Get.toNamed(Routes.DETALLESDEPAGORECAUDOS,
        arguments: {firebaseReferences.recaudos: recaudo});
  }

  montoyinteres() async {
    montorecaudos.value = 0;
    for (var i in recaudo) {
      montorecaudos.value += i.total!.toInt();
    }
  }
}
