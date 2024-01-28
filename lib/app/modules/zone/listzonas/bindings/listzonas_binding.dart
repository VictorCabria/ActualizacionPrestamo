import 'package:get/get.dart';

import '../controllers/listzonas_controller.dart';

class ListzonasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListzonasController>(
      () => ListzonasController(),
    );
  }
}
