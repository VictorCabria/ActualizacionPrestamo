import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prestamo_mc/app/models/client_model.dart';
import 'package:prestamo_mc/app/utils/palette.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../models/cobradores_modal.dart';
import '../../../../../models/concepto_model.dart';
import '../../../../../models/prestamo_model.dart';
import '../../../../../models/recaudo_line_modal.dart';
import '../../../../../models/transaction_model.dart';
import '../../../../../models/type_prestamo_model.dart';
import '../controllers/detallesdetodassesiones_controller.dart';

class DetallesdetodassesionesView
    extends GetView<DetallesdetodassesionesController> {
  const DetallesdetodassesionesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.primary,
          title: FutureBuilder(
              future:
                  controller.getcobradorById(controller.session.cobradorId!),
              builder: (context, snapshot) {
                print(snapshot.data);
                if (snapshot.hasData) {
                  Cobradores cobrador = snapshot.data as Cobradores;
                  return Text(
                    ('Sesion ${(controller.session.fecha != null ? DateFormat("dd/MM/yyyy").format(DateTime.parse(controller.session.fecha!).toLocal()) : "") + (' - ${cobrador.nombre!}')}'),
                    style: const TextStyle(fontSize: 20),
                  );
                } else {
                  return const Text("");
                }
              }),
        ),
        body: Column(
          children: [
            Container(
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FutureBuilder(
                                        future: controller.getcobradorById(
                                            controller.session.cobradorId!),
                                        builder: (context, snapshot) {
                                          print(snapshot.data);
                                          if (snapshot.hasData) {
                                            Cobradores cobrador =
                                                snapshot.data as Cobradores;
                                            return Text(
                                              (cobrador.nombre!),
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            );
                                          } else {
                                            return const Text("");
                                          }
                                        }),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 4.7.h),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.homecontroller.fecha.value,
                                      style: const TextStyle(fontSize: 18))
                                ],
                              ),
                            ],
                          ))
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text('Valor inicial',
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 4.7.h),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      controller.session.valorInicial
                                          .toString(),
                                      style: const TextStyle(fontSize: 18))
                                ],
                              ),
                            ],
                          ))
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text('Prestamos',
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 4.7.h),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.session.costos.toString(),
                                      style: const TextStyle(fontSize: 18))
                                ],
                              ),
                            ],
                          ))
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text('Transacciones',
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 4.7.h),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.session.gastos.toString(),
                                      style: const TextStyle(fontSize: 18))
                                ],
                              ),
                            ],
                          ))
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text('Recaudos',
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 4.7.h),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.session.ingresos.toString(),
                                      style: const TextStyle(fontSize: 18))
                                ],
                              ),
                            ],
                          ))
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text('Saldo Actual',
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 4.7.h),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      controller.session.pyg!
                                          .toStringAsFixed(2),
                                      style: TextStyle(fontSize: 18))
                                ],
                              ),
                            ],
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: DefaultTabController(
                    length: 3,
                    child: Form(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: Column(children: [
                            TabBar(
                              controller: controller.tabController,
                              labelColor: Palette.primary,
                              indicatorColor: Palette.primary,
                              tabs: const [
                                Tab(text: "Prestamos"),
                                Tab(text: "Transacciones"),
                                Tab(text: "Recaudos"),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: controller.tabController,
                                children: [
                                  Page1(controller: controller),
                                  Page2(controller: controller),
                                  Page3(controller: controller),
                                ],
                              ),
                            ),
                          ])),
                    )))
          ],
        ));
  }
}

class Page1 extends StatelessWidget {
  const Page1({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final DetallesdetodassesionesController controller;

  @override
  Widget build(BuildContext context) {
    return GetX<DetallesdetodassesionesController>(
      builder: (b) => b.isloading.value
          ? const CircularProgressIndicator()
          : ListView(
              children: controller.prestamosget
                  .map(
                    (element) => SizedBox(
                      child: Column(
                        children: [
                          CustomCard(
                            controller: b,
                            s: element,
                          ),
                          const Divider(
                            thickness: 0.5,
                          )
                        ],
                      ),
                    ),
                  )
                  .toList()),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final DetallesdetodassesionesController controller;

  @override
  Widget build(BuildContext context) {
    return GetX<DetallesdetodassesionesController>(
      builder: (b) => b.isloading.value
          ? const CircularProgressIndicator()
          : ListView(
              children: b.transaccionesget
                  .map(
                    (element) => SizedBox(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 1,
                          ),
                          CustomCard2(
                            controller: b,
                            s: element,
                          ),
                          const Divider(
                            thickness: 0.5,
                          )
                        ],
                      ),
                    ),
                  )
                  .toList()),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final DetallesdetodassesionesController controller;

  @override
  Widget build(BuildContext context) {
    return GetX<DetallesdetodassesionesController>(
      builder: (b) => b.isloading.value
          ? const CircularProgressIndicator()
          : ListView(
              children: controller.recaudoget
                  .map(
                    (element) => SizedBox(
                      child: Column(
                        children: [
                          CustomCard3(
                            controller: b,
                            s: element,
                          ),
                          const Divider(
                            thickness: 0.5,
                          )
                        ],
                      ),
                    ),
                  )
                  .toList()),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.controller, required this.s})
      : super(key: key);

  final DetallesdetodassesionesController controller;

  final Prestamo s;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 2,
        child: ListTile(
          onTap: () {},
          onLongPress: () {},
          title: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FutureBuilder(
                                      future: controller
                                          .getClientById(s.clienteId!),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          Client client =
                                              snapshot.data as Client;
                                          return Text(
                                            (client.nombre!),
                                            style:
                                                const TextStyle(fontSize: 20),
                                          );
                                        } else {
                                          return const Text("");
                                        }
                                      }),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            '${s.fecha}',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ])),
          isThreeLine: true,
          subtitle: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: FutureBuilder(
                            future: controller.getClientById(s.clienteId!),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                Client client = snapshot.data as Client;
                                return Text(
                                  (client.recorrido!),
                                );
                              } else {
                                return const Text("");
                              }
                            }),
                      ),
                      Container(
                          child: FutureBuilder(
                              future: controller
                                  .gettipoprestamoById(s.tipoPrestamoId!),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  TypePrestamo tipoprestamo =
                                      snapshot.data as TypePrestamo;
                                  return Container(
                                      child: Text(
                                    (" ${tipoprestamo.nombre!} "),
                                  ));
                                } else {
                                  return const Text("");
                                }
                              }))
                    ],
                  ),
                  SizedBox(height: 1.5.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Capital:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${s.monto}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Saldo:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${s.saldoPrestamo}',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Estado:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(s.estado ?? 'Nuevo'),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      )
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class CustomCard2 extends StatelessWidget {
  const CustomCard2({Key? key, required this.controller, required this.s})
      : super(key: key);

  final DetallesdetodassesionesController controller;

  final Transacciones s;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 2,
        child: ListTile(
          onTap: () {},
          onLongPress: () {},
          title: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FutureBuilder(
                                      future: controller
                                          .getconceptoById(s.concept!),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          Concepto concepto =
                                              snapshot.data as Concepto;
                                          return Text(
                                            (concepto.nombre!),
                                            style:
                                                const TextStyle(fontSize: 18),
                                          );
                                        } else {
                                          return const Text("");
                                        }
                                      }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ])),
          isThreeLine: true,
          subtitle: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Tercero:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FutureBuilder(
                                    future:
                                        controller.getcobradoresId(s.cobrador!),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        Cobradores cobradores =
                                            snapshot.data as Cobradores;
                                        return Text(
                                          (cobradores.nombre!),
                                          style: const TextStyle(fontSize: 15),
                                        );
                                      } else {
                                        return const Text("");
                                      }
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Fecha:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  s.fecha!,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Valor:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  s.valor!.toString(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Container(
                      child: const Text("Detalles",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  const SizedBox(height: 5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          s.detalles == null ? "" : s.detalles!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class CustomCard3 extends StatelessWidget {
  const CustomCard3({Key? key, required this.controller, required this.s})
      : super(key: key);

  final DetallesdetodassesionesController controller;

  final RecaudoLine s;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 2,
        child: ListTile(
          onTap: () {},
          onLongPress: () {},
          title: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FutureBuilder(
                                      future: controller
                                          .getClientById(s.idCliente!),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          Client client =
                                              snapshot.data as Client;
                                          return Text(
                                            (client.nombre!),
                                            style:
                                                const TextStyle(fontSize: 20),
                                          );
                                        } else {
                                          return const Text("");
                                        }
                                      }),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(s.fecha != null
                                              ? DateFormat("dd/MM/yyyy").format(
                                                  DateTime.parse("${s.fecha}")
                                                      .toLocal())
                                              : ""),
                                        ],
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ])),
          isThreeLine: true,
          subtitle: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Saldo',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(s.saldo!.toStringAsFixed(2)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Monto',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(s.monto!.toStringAsFixed(2)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Valor a pagar',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  s.total!.toString(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      )
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
