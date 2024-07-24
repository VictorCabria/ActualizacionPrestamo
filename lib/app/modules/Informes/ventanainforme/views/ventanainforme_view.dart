import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../routes/app_pages.dart';
import '../../../../utils/palette.dart';
import '../../../../utils/text_styles.dart';
import '../controllers/ventanainforme_controller.dart';

class VentanainformeView extends GetView<VentanainformeController> {
  const VentanainformeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
 return Scaffold(
      body: Obx(() => controller.loading.value
          ? const Center(child: CircularProgressIndicator())
          : Container(
              color: Palette.secondary,
              height: 100.h,
              child: CustomScrollView(
                controller: controller.scrollController,
                slivers: [
                  const SliverAppBar(
                      title: Text("Informes"),
                      automaticallyImplyLeading: false,
                      centerTitle: true,
                      pinned: true,
                      backgroundColor: Palette.primary,
                      flexibleSpace: FlexibleSpaceBar(),
                      leading: BackButton()),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 1.h),
                  ),
                  SliverGrid.count(
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    children: controller.gestorMode.value
                        ? [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.h,
                                vertical: 2.h,
                              ),
                              child: Card(
                                child: Container(
                                  margin: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        "assets/icons/prestamo.png",
                                        scale: 1.5,
                                      ),
                                      Text(
                                        "Registrar Clientes",
                                        style: styles.tittleSub,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.h,
                                vertical: 2.h,
                              ),
                              child: Card(
                                child: Container(
                                  margin: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        "assets/icons/workplace (1).png",
                                        scale: 1.5,
                                      ),
                                      Text(
                                        "Actividades Economicas",
                                        style: styles.tittleSub,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]
                        : [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.h,
                                vertical: 2.h,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.INFORMEPRESTAMO);
                                },
                                child: Card(
                                  child: Container(
                                    margin: const EdgeInsets.all(7),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/icons/banco.png",
                                          scale: 1.5,
                                        ),
                                        Text(
                                          "Prestamos",
                                          style: styles.tittleSub,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            /* Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.h,
                                vertical: 2.h,
                              ),
                              child: Card(
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        "assets/icons/prestamo.png",
                                        scale: 1.5,
                                      ),
                                      Text(
                                        "Actividades Economicas",
                                        style: styles.tittleSub,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ), */
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.h,
                                vertical: 2.h,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.INFORMERECAUDO);
                                },
                                child: Card(
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/icons/transaccion.png",
                                          scale: 1.5,
                                        ),
                                        Text(
                                          "Recaudos",
                                          style: styles.tittleSub,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.h,
                                vertical: 2.h,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.INFORMESESSION);
                                },
                                child: Card(
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/icons/workplace (1).png",
                                          scale: 1.5,
                                        ),
                                        Text(
                                          "Sessiones",
                                          style: styles.tittleSub,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.h,
                                vertical: 2.h,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.INFORMETRANSACCIONES);
                                },
                                child: Card(
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/icons/transaccion.png",
                                          scale: 1.5,
                                        ),
                                        Text(
                                          "Transacciones",
                                          style: styles.tittleSub,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            /* Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.h,
                                vertical: 2.h,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.INFORMEDEPRUEBA);
                                },
                                child: Card(
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/icons/transaccion.png",
                                          scale: 1.5,
                                        ),
                                        Text(
                                          "Pruebas",
                                          style: styles.tittleSub,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ), */
                          ],
                  ),

                  // SessionWidget(),
                  // const SizedBox(height: 20),
                  // const Text('Hello World'),
                ],
              ),
            )),
    );
  }
}
