import 'dart:core';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ruta_sdg/plandia.dart';
import 'package:ruta_sdg/promocion_socio.dart';
import 'package:ruta_sdg/widgets/header.dart';
import 'package:ruta_sdg/widgets/promotion_form.dart';
import 'package:ruta_sdg/widgets/tabbar.dart';

class PromocionPage extends StatefulWidget {
  const PromocionPage({Key? key}) : super(key: key);

  @override
  State createState() => _PromocionPageState();
}

class _PromocionPageState extends State<PromocionPage> {
  final List<UserData> users = [
    UserData("1", "12345678", "Arce Quispe Ruth Milagros"),
    UserData("2", "98765432", "Cahuata Lavilla Yolmy Milagros"),
    // Agrega más usuarios según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomAppBar(
        child: TabBarBottom(),
      ),
      body: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              Container(
                height: 125,
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 5,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(0),
                  ),
                  color: Color.fromARGB(255, 0, 76, 128),
                ),
                child: Row(
                  children: [
                    Column(
                      children: [
                        const Header(),
                        Container(
                          margin: const EdgeInsets.all(24),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              // Navegar a MyPlanDiarioPage
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MyPlanDiarioPage(title: "")),
                              );
                            },
                            child: const Text(
                              "PLAN DEL DIA",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Agrega aquí el contenido específico de la pantalla de promoción
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  elevation: 5,
                  shadowColor: const Color.fromARGB(
                      255, 5, 5, 5), // Agrega el color de sombra gris
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Ajusta el valor según sea necesario
                    side: BorderSide(
                      color: Colors.grey
                          .withOpacity(0.5), // Agrega el color del borde
                      width:
                          1.0, // Ajusta el ancho del borde según sea necesario
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          10.0), // Ajusta el valor según sea necesario
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey
                              .withOpacity(0.5), // Agrega el color de la sombra
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0,
                              3), // Cambia la posición de la sombra según sea necesario
                        ),
                      ],
                    ),
                    child: const Text(
                      "CARTERA DE PROMOCIÓN",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        width: 2.0), // Borde blanco
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  color: const Color.fromARGB(255, 255, 255, 255),
                  elevation: 5,
                  child: SizedBox(
                    height: 200, // Establece la altura deseada
                    width: 600,
                    child: SingleChildScrollView(
                      child: DataTable(
                        showCheckboxColumn: false,
                        //dataRowHeight: 50.0,
                        columnSpacing: 7.0,
                        columns: const [
                          DataColumn(label: Text('N°')),
                          DataColumn(label: Text('DNI')),
                          DataColumn(label: Text('Nombre')),
                          DataColumn(label: Text('')),
                        ],
                        rows: users.map((user) {
                          return DataRow(
                            onSelectChanged: (isSelected) {
                              if (isSelected != null && isSelected) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PromocionSocio(),
                                  ),
                                );
                              }
                            },
                            cells: [
                              DataCell(Text(user.number)),
                              DataCell(Text(user.dni)),
                              DataCell(Text(user.name)),
                              const DataCell(Icon(Icons.check)),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserData {
  final String number;
  final String dni;
  final String name;

  UserData(this.number, this.dni, this.name);
}
