import 'package:get/get.dart';

import '../controllers/informerecaudo_controller.dart';

class InformerecaudoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InformerecaudoController>(
      () => InformerecaudoController(),
    );
  }
}
