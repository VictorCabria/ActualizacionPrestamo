import 'package:get/get.dart';

import '../controllers/create_recaudos_controller.dart';

class CreateRecaudosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateRecaudosController>(
      () => CreateRecaudosController(),
    );
  }
}
