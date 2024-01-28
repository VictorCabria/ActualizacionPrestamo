import 'package:get/get.dart';

import '../controllers/edit_recaudos_controller.dart';

class EditRecaudosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditRecaudosController>(
      () => EditRecaudosController(),
    );
  }
}
