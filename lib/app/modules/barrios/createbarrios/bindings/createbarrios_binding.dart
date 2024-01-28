import 'package:get/get.dart';

import '../controllers/createbarrios_controller.dart';

class CreatebarriosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatebarriosController>(
      () => CreatebarriosController(),
    );
  }
}
