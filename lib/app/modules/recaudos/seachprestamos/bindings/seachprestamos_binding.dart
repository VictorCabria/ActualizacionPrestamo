import 'package:get/get.dart';

import '../controllers/seachprestamos_controller.dart';

class SeachprestamosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeachprestamosController>(
      () => SeachprestamosController(),
    );
  }
}
