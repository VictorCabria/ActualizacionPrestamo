import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/usuario_controller.dart';

class UsuarioView extends GetView<UsuarioController> {
  const UsuarioView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UsuarioView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'UsuarioView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
