import 'package:get/get.dart';

import '../controllers/listadeprestamos_controller.dart';

class ListadeprestamosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListadeprestamosController>(
      () => ListadeprestamosController(),
    );
  }
}
