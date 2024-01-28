import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/recaudo_line_modal.dart';
import 'package:prestamo_mc/app/services/model_services/prestamo_service.dart';

import '../../../../models/prestamo_model.dart';
import '../../../../models/recaudo_model.dart';
import '../../../../services/model_services/client_service.dart';
import '../../../../services/model_services/recaudos_service.dart';
import '../../../../services/model_services/tipoprestamo_service.dart';
import '../../../principal/home/controllers/home_controller.dart';

class VentanarecaudotodosController extends GetxController {
  final homeControll = Get.find<HomeController>();
  RxList<RecaudoLine> recaudo = RxList<RecaudoLine>([]);
  late Stream<List<RecaudoLine>> recaudoStream;
  List<RecaudoLine> get recaudoget => recaudo;
  RxBool isloading = false.obs;
  Recaudo? recaudos;
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
