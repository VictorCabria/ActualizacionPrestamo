import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class LandingController extends GetxController {
  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loading.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      loading.value = false;
      Get.offNamed(Routes.LOGIN);
    });
  }
}