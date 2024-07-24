import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/session_model.dart';

class PaneladminController extends GetxController {
  //TODO: Implement PaneladminController

  final gestorMode = false.obs;
  final loading = false.obs;
  final scrollController = ScrollController();
  Session? session;
}


