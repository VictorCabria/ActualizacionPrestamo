import 'package:get/get.dart';

import '../../../../models/recaudo_line_modal.dart';
import '../../../../models/recaudo_model.dart';
import '../../../../services/model_services/client_service.dart';
import '../../../../services/model_services/recaudos_service.dart';
import '../../../../services/model_services/tipoprestamo_service.dart';

class DetallesdepagosrecaudosController extends GetxController {
  //TODO: Implement DetallesdepagosrecaudosController
  Recaudo? recaudos;
  RxList<RecaudoLine> recaudo = RxList<RecaudoLine>([]);
  late Stream<List<RecaudoLine>> recaudoStream;
  List<RecaudoLine> get recaudoget => recaudo;
  RxBool isloading = false.obs;

  @override
  void onInit() {
    recaudos = Get.arguments['recaudos'];
    recaudoStream = getrecaudo();
    init();
    super.onInit();
  }

  getrecaudo() => recaudoService
      .obtenerlistrecaudo()
      .where('id_recaudo', isEqualTo: recaudos!.id)
      .snapshots()
      .map((event) => event.docs.map((e) => RecaudoLine.fromJson(e)).toList());

  init() {
    recaudoStream.listen((event) async {
      recaudo.value = event;
    });
  }

    getClientById(String id) async {
    var response = await clientService.getClientById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  gettipoprestamoById(String id) async {
    var response = await typePrestamoService.getprestamoById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }
}
