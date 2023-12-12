import 'dart:core';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ruta_sdg/home.dart';
import 'package:ruta_sdg/plandia.dart';

class SeguimientoPage extends StatefulWidget {
  const SeguimientoPage({Key? key}) : super(key: key);

  @override
  State createState() => _SeguimientoPageState();
}

class _SeguimientoPageState extends State<SeguimientoPage> {
  final List<UserData> users = [
    UserData("1", "12345678", "Arce Quispe Ruth Milagros"),
    UserData("2", "98765432", "Cahuata Lavilla Yolmy Milagros"),
    // Agrega más usuarios según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _bottomAction("Inicio", FontAwesomeIcons.house,
                const Color.fromARGB(255, 4, 54, 95), 20.0),
            _bottomAction("Notificaciones", FontAwesomeIcons.solidBell,
                const Color.fromARGB(255, 4, 54, 95), 20.0),
            _bottomAction("Reportes", FontAwesomeIcons.newspaper,
                const Color.fromARGB(255, 4, 54, 95), 20.0),
          ],
        ),
      ),
      body: _body(),
    );
  }

  Widget _bottomAction(
      String label, IconData icon, Color iconColor, double iconSize) {
    return InkWell(
      onTap: () {
        // Lógica que se ejecuta al hacer clic en el ícono
        if (label == "Inicio") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(label),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return SafeArea(
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
                      Row(
                        children: [
                          const Icon(
                            Icons.format_list_bulleted,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 8,
                            ),
                            child: Image.asset(
                              'assets/logo-sdg.png',
                              width: 45,
                              height: 45,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Text(
                            'RUTASDG',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
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
            // Agrega aquí el contenido específico de la pantalla de Recuperación
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
                    width: 1.0, // Ajusta el ancho del borde según sea necesario
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
                    "CARTERA DE SEGUIMIENTO",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.lightGreen,
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
                      color: Colors.white, width: 2.0), // Borde blanco
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: const Color.fromARGB(255, 255, 255, 255),
                elevation: 5,
                child: SizedBox(
                  height: 200, // Establece la altura deseada
                  width: 600,
                  child: SingleChildScrollView(
                    child: DataTable(
                      // ignore: deprecated_member_use
                      dataRowHeight: 50.0,
                      columnSpacing: 7.0,
                      columns: const [
                        DataColumn(label: Text('N°')),
                        DataColumn(label: Text('DNI')),
                        DataColumn(label: Text('Nombre')),
                        DataColumn(label: Text('')),
                      ],
                      rows: users.map((user) {
                        return DataRow(cells: [
                          DataCell(Text(user.number)),
                          DataCell(Text(user.dni)),
                          DataCell(Text(user.name)),
                          const DataCell(Icon(Icons.check)),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
//////////////////////
          ],
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
