import 'package:get/get.dart';

import '../controllers/listacobradores_controller.dart';

class ListacobradoresBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListacobradoresController>(
      () => ListacobradoresController(),
    );
  }
}
