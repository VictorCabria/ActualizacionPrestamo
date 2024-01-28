import 'package:get/get.dart';

import '../controllers/listaconceptos_controller.dart';

class ListaconceptosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListaconceptosController>(
      () => ListaconceptosController(),
    );
  }
}
