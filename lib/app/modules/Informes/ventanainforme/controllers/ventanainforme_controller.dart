import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/session_model.dart';

class VentanainformeController extends GetxController {
  //TODO: Implement VentanainformeController

final gestorMode = false.obs;
  final loading = false.obs;
  final scrollController = ScrollController();
  Session? session;
}

