import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/landing_controller.dart';

class LandingView extends GetView<LandingController> {
  const LandingView({Key? key}) : super(key: key);
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.loading.value
          ? const Center(child: CircularProgressIndicator())
          : const Text("no loading")),
    );
  }
}
