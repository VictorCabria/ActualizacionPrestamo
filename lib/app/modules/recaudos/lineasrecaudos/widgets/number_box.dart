import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../models/client_model.dart';
import '../../../../models/recaudo_line_modal.dart';
import '../../../../utils/utils.dart';
import '../controllers/lineasrecaudos_controller.dart';

final format = DateFormat('yyyy-MM-dd');
final numberFormat = NumberFormat.currency(symbol: "\$", decimalDigits: 1);

class BuildNumber extends StatelessWidget {
  const BuildNumber({super.key, this.number, this.method});

  final number;
  final method;

  @override
  Widget build(BuildContext context) {
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
}

class BuildPunto extends StatelessWidget {
  const BuildPunto({super.key, this.number, this.method});

  final number;
  final method;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => method(),
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
}

Widget buildCodeNumberBox(String codeNumber) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: SizedBox(
      width: 50.w,
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

Widget buildBackspace(method) {
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
        child: Center(
            child: IconButton(
          onPressed: () => method(),
          icon: const Icon(
            Icons.backspace,
            size: 28,
          ),
        )),
      ),
    ),
  );
}

Widget buildspace(method, line) {
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
        child: Center(
            child: IconButton(
          onPressed: () => method(line),
          icon: const Icon(
            Icons.check,
            size: 28,
          ),
        )),
      ),
    ),
  );
}

showNumericPanel(
  BuildContext context,
  Client client,
  RecaudoLine recaudoLineModal,
  LineasrecaudosController controller,
) {
  // controller.value.value = recaudoLineModal.monto!.toString();
  return showDialog(
      context: context,
      builder: (_) => Dialog(
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 8,
            backgroundColor: Palette.primaryLetter,
            child: Stack(
              children: [
                SizedBox(
                  height: 60.h,
                  child: Column(
                    children: [
                      Expanded(
                        child: Obx(
                          () => Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 1.w),
                                margin: EdgeInsets.only(bottom: 2.h),
                                height: 7.h,
                                decoration: BoxDecoration(
                                  color: Palette.primary,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Cliente: ${client.nombre}",
                                        overflow: TextOverflow.fade,
                                        style: styles.tittleRegister,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              buildCodeNumberBox(
                                  numberFormat.format(controller.value.value)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.09,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                BuildNumber(
                                    number: 1,
                                    method: controller.agregarAcumula),
                                BuildNumber(
                                    number: 2,
                                    method: controller.agregarAcumula),
                                BuildNumber(
                                    number: 3,
                                    method: controller.agregarAcumula),
                                BuildNumber(
                                    number: 10, method: controller.agregarSuma),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.09,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                BuildNumber(
                                    number: 4,
                                    method: controller.agregarAcumula),
                                BuildNumber(
                                    number: 5,
                                    method: controller.agregarAcumula),
                                BuildNumber(
                                    number: 6,
                                    method: controller.agregarAcumula),
                                BuildNumber(
                                    number: 20, method: controller.agregarSuma),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.09,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                BuildNumber(
                                    number: 7,
                                    method: controller.agregarAcumula),
                                BuildNumber(
                                    number: 8,
                                    method: controller.agregarAcumula),
                                BuildNumber(
                                    number: 9,
                                    method: controller.agregarAcumula),
                                BuildNumber(
                                    number: 50, method: controller.agregarSuma),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.09,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                buildspace(
                                    controller.aceptar, recaudoLineModal),
                                BuildNumber(
                                    number: 0,
                                    method: controller.agregarAcumula),
                                BuildPunto(
                                    number: '.', method: controller.puntoMode),
                                buildBackspace(controller.delete),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          /* TextButton(
                        onPressed: () => controller.getToHome(),
                        child: const Text("Login")), */
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 3,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Palette.secondary,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
          ));
}
