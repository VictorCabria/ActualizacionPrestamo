import 'package:get/get.dart';

import '../controllers/list_prestamo_controller.dart';

class ListPrestamoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListPrestamoController>(
      () => ListPrestamoController(),
    );
  }
}
