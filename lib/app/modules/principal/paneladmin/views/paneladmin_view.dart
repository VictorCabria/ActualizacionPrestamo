import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:prestamo_mc/app/utils/palette.dart';
import 'package:prestamo_mc/app/utils/text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/paneladmin_controller.dart';

class PaneladminView extends GetView<PaneladminController> {
  const PaneladminView({Key? key}) : super(key: key);
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
                      title: Text("Administrador"),
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
                                  Get.toNamed(Routes.LISTADEPRESTAMOS);
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
                                          " Tipos de Prestamos",
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
                                  Get.toNamed(Routes.LISTCLIENT);
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
                                          "Clientes",
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
                                  Get.toNamed(Routes.LISTACOBRADORES);
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
                                          "Cobradores",
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
                                  Get.toNamed(Routes.LISTACONCEPTOS);
                                },
                                child: Card(
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/icons/concepto.png",
                                          scale: 1.5,
                                        ),
                                        Text(
                                          "Conceptos",
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
                                  Get.toNamed(Routes.LISTBARRIOS);
                                },
                                child: Card(
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/icons/marcador-de-posicion.png",
                                          scale: 1.5,
                                        ),
                                        Text(
                                          "Barrios",
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
                                  Get.toNamed(Routes.LISTZONAS);
                                },
                                child: Card(
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/icons/ubicacion-del-mapa.png",
                                          scale: 1.5,
                                        ),
                                        Text(
                                          "Zonas",
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
                                  Get.toNamed(Routes.DIASDENOCOBRO);
                                },
                                child: Card(
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/icons/dinero.png",
                                          scale: 1.5,
                                          height: 50,
                                        ),
                                        Text(
                                          "Dias de no cobro",
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
                                  Get.toNamed(Routes.LISTANEGRA);
                                },
                                child: Card(
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/icons/lista-negra.png",
                                          scale: 1.5,
                                          height: 50,
                                        ),
                                        Text(
                                          "Lista Negra",
                                          style: styles.tittleSub,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
