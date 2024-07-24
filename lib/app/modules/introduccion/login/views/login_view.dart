import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../utils/palette.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
          child: Scaffold(
            backgroundColor: Palette.primary,
            body: SingleChildScrollView(
              child: Form(
                  key: controller.formkey,
                  child: Container(
                    color: Palette.primary,
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          SizedBox(
                            width: 90.w,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.gestorMode.value = false;
                                      },
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundColor:
                                            controller.gestorMode.value
                                                ? Colors.white
                                                : Colors.blue,
                                        child: Image.asset(
                                          'assets/icons/workplace (1).png',
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                                Expanded(
                                  child: Column(children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.gestorMode.value = true;
                                      },
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundColor:
                                            !controller.gestorMode.value
                                                ? Colors.white
                                                : Colors.blue,
                                        child: Image.asset(
                                          'assets/icons/workers (1).png',
                                        ),
                                      ),
                                    ),
                                  ]),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Card(
                              child: SizedBox(
                            height: 55.h,
                            width: 90.w,
                            child: controller.gestorMode.value
                                ? KeyLogin(
                                    controller: controller,
                                  )
                                : PassLogin(
                                    controller: controller,
                                  ),
                          )),
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        ));
  }
}

class KeyLogin extends StatelessWidget {
  const KeyLogin({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Obx(
            () => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildCodeNumberBox(controller.code.value.length > 0
                    ? controller.code.substring(0, 1)
                    : ""),
                buildCodeNumberBox(controller.code.value.length > 1
                    ? controller.code.substring(1, 2)
                    : ""),
                buildCodeNumberBox(controller.code.value.length > 2
                    ? controller.code.substring(2, 3)
                    : ""),
                buildCodeNumberBox(controller.code.value.length > 3
                    ? controller.code.substring(3, 4)
                    : ""),
              ],
            ),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          color: const Color(0xFFF5F4F9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                     buildNumber(1, controller.agregar),
                    buildNumber(2, controller.agregar),
                    buildNumber(3, controller.agregar), 
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                     buildNumber(4, controller.agregar),
                    buildNumber(5, controller.agregar),
                    buildNumber(6, controller.agregar), 
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                     buildNumber(7, controller.agregar),
                    buildNumber(8, controller.agregar),
                    buildNumber(9, controller.agregar), 
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildspace(),
                    buildNumber(0, controller.agregar), 
                    buildBackspace(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
               TextButton(
                  onPressed: () => controller.getToHome(),
                  child: const Text("Login")), 
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildCodeNumberBox(String codeNumber) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: SizedBox(
      width: 60,
      height: 60,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF6F5FA),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black26,
                blurRadius: 25.0,
                spreadRadius: 1,
                offset: Offset(0.0, 0.75))
          ],
        ),
        child: Center(
          child: Text(
            codeNumber,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F1F1F),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildNumber(int number, method) {
  return Expanded(
    child: GestureDetector(
      onTap: () => method(number),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F1F1F),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildBackspace() {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.backspace,
            size: 28,
          ),
        ),
      ),
    ),
  );
}

Widget buildspace() {
  return Expanded(child: Container());
}

class PassLogin extends StatelessWidget {
  const PassLogin({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LoginController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.w),
        const Text("Ingresar Usuario",
            style: TextStyle(fontSize: 20, color: Palette.primary)),
        SizedBox(height: 5.w),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Container(
         
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.name,
              controller: controller.emailcontroller,
              validator: (value) {
                return null;
              },
              onSaved: (value) {
                controller.emailcontroller.text = value!;
              },
              textInputAction: TextInputAction.next,
              cursorColor: Palette.primary,
              decoration: const InputDecoration(
                  prefixIcon:
                      Icon(Icons.account_circle, color: Palette.primary),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40.0),
                    ),
                    borderSide: BorderSide(
                      color: Palette.primary,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40.0),
                    ),
                    borderSide: BorderSide(
                      color: Palette.primary,
                    ),
                  ),
                  labelText: "Nombre",
                  fillColor: Palette.primary,
                  labelStyle: TextStyle(color: Palette.primary)),
            ),
          ),
        ),
        const SizedBox(height: 3),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: Container(
            
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.visiblePassword,
              controller: controller.passwordcontroller,
              validator: (value) {
                return null;
              },
              onSaved: (value) {
                controller.passwordcontroller.text = value!;
              },
              textInputAction: TextInputAction.next,
              cursorColor: Palette.primary,
              obscureText: true,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.key, color: Palette.primary),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40.0),
                    ),
                    borderSide: BorderSide(
                      color: Palette.primary,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40.0),
                    ),
                    borderSide: BorderSide(
                      color: Palette.primary,
                    ),
                  ),
                  labelText: "Contraseña",
                  fillColor: Palette.primary,
                  labelStyle: TextStyle(color: Palette.primary)),
            ),
          ),
        ),
        const SizedBox(height: 30),
        Material(
          borderRadius: BorderRadius.circular(20),
          color: Palette.primary,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            onPressed: () async {
              await controller
                  .getusuarios(controller.emailcontroller.toString());

               
              if(controller.usuario == null){
                Get.dialog(const AlertDialog(
                  title: Text("ESTE USUARIO NO EXISTE"),
                  content: Text("O ESTA MAL ESCRITO")));
              }

              else if (controller.usuario!.isAdmin == true) {
                controller.authUser(controller.emailcontroller.text,
                    controller.passwordcontroller.text);
              } else {
                Get.dialog(const AlertDialog(
                  title: Text("ERROR DEL SISTEMA"),
                  content: Text("USTED NO ES ADMIN"),
                ));
              }
            },
            child: const Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),

          /* TextButton(
            onPressed: () => controller.getToHome(),
            child: const Text("Login")), */
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
