import 'package:get/get.dart';

import '../controllers/seachcliente2_controller.dart';

class Seachcliente2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Seachcliente2Controller>(
      () => Seachcliente2Controller(),
    );
  }
}
