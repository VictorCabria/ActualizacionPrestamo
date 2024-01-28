// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prestamo_mc/app/routes/app_pages.dart';
import 'package:prestamo_mc/app/services/model_services/cobradores_service.dart';

import '../../../../models/user_model.dart';
import '../../../../services/model_services/user_service.dart';

class LoginController extends GetxController {
  final gestorMode = false.obs;
  final code = "".obs;
  final phoneNumber = "".obs;
  final manetenerSession = false.obs;
  Usuarios? usuario;

  final formkey = GlobalKey<FormState>();
  late TextEditingController emailcontroller, passwordcontroller;

  @override
  void onInit() {
    super.onInit();
    emailcontroller = TextEditingController();
    passwordcontroller = TextEditingController();
  }

  getToHome() async {
    Get.toNamed(Routes.HOME, arguments: {'gestorMode': gestorMode.value});
  }

  getusuarios(String email) async {
    var response = await userService.loginusuariosemail(emailcontroller.text);
    usuario = response;
  }

  loginusuario() {
    if (usuario!.isAdmin == true) {
      authUser(emailcontroller.text, passwordcontroller.text);
    } else {
      Get.dialog(AlertDialog(
        title: Text("ERROR DEL SISTEMA"),
        content: Text("USTED NO ES ADMIN"),
      ));
    }
  }

  Future<String?> authUser(String email, String pass) async {
    try {
      // UserCredential userCredential = await FirebaseAuth.instance
      //     .signInWithEmailAndPassword(email: email, password: pass);
      var response = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      print("id user ${response.user!.uid}");
      getToHome();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email.');
        }
        return 'No user found for that email.';
        // Get.dialog(AlertDialog(
        //   title: Text("ERROR DEL SISTEMA"),
        //   content: Text("Usuario invalidos"),
        // ));
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
        return 'Wrong password provided for that user.';
        // Get.dialog(AlertDialog(
        //   title: Text("ERROR DEL SISTEMA"),
        //   content: Text("Contraseña invalidos"),
        // ));
      }
    }
    return null;
  }

  Future<String?> signupUser(String email, String pass) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);

      if (kDebugMode) {
        print(userCredential.user?.uid);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
        return 'The account already exists for that email.';
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future<String> recoverPassword(String name) {
    if (kDebugMode) {
      print('Name: $name');
    }
    return Future.delayed(const Duration(seconds: 1)).then((_) {
      // if (!users.containsKey(name)) {
      //   return 'User not exists';
      // }
      return '';
    });
  }

  /*  agregar2(int val) {
    if (code.value.length < 4) {
      code.value += "$val";
    } else {
      Get.toNamed(Routes.HOME, arguments: {'gestorMode': gestorMode.value});
    }
  } */

  agregar(int val) async {
    if (formkey.currentState!.validate()) {
      code.value += "$val";
      if (code.value.length == 4) {
        var response = await cobradoresService.loginCobradores(code.value);
        if (response != null) {
          Get.toNamed(Routes.HOME, arguments: {
            'gestorMode': gestorMode.value,
            'cobrador': response
          });
        } else {
          Get.dialog(const AlertDialog(
            title: Text("Codigo Incorrecto"),
          ));
          code.value = '';
        }
      }
    }
  }
}
