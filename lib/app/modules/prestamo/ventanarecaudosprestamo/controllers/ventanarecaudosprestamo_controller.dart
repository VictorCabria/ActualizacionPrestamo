import 'package:get/get.dart';
import '../../../../models/prestamo_model.dart';
import '../../../../models/recaudo_line_modal.dart';
import '../../../../services/model_services/client_service.dart';
import '../../../../services/model_services/recaudos_service.dart';
import '../../../../services/model_services/tipoprestamo_service.dart';
import '../../../principal/home/controllers/home_controller.dart';

class VentanarecaudosprestamoController extends GetxController {
  final homeControll = Get.find<HomeController>();
  RxList<RecaudoLine> recaudo = RxList<RecaudoLine>([]);
  late Stream<List<RecaudoLine>> recaudoStream;
  List<RecaudoLine> get recaudoget => recaudo;
  RxBool isloading = false.obs;
  Prestamo? prestamo;
  final montosuma = 0.0.obs;
  @override
  void onInit() {
    prestamo = Get.arguments['prestamos'];
    recaudoStream = getrecaudo();

    init();
    super.onInit();
  }

  getrecaudo() => recaudoService
      .obtenerlistrecaudo()
      .where('prestamo', isEqualTo: prestamo!.id)
      .orderBy("fecha", descending: true)
      .snapshots()
      .map((event) => event.docs.map((e) => RecaudoLine.fromJson(e)).toList());

  init() {
    recaudoStream.listen((event) async {
      recaudo.value = event;
      monto();
    });
  }

  monto() async {
    montosuma.value = 0;
    for (var i in recaudo) {
      montosuma.value += i.monto!.toInt();
    }
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
