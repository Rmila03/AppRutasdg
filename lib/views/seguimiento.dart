import 'dart:core';
import 'package:flutter/material.dart';
import 'package:ruta_sdg/plandia.dart';
import 'package:ruta_sdg/user.dart';
import 'package:ruta_sdg/widgets/header.dart';
import 'package:ruta_sdg/widgets/navigation_drawer.dart';
import 'package:ruta_sdg/widgets/tabbar.dart';
import 'package:ruta_sdg/listasocio.dart';

class SeguimientoPage extends StatefulWidget {
  const SeguimientoPage({super.key});

  @override
  State createState() => _SeguimientoPageState();
}

class _SeguimientoPageState extends State<SeguimientoPage> {
  final List<UserData> users = [
    UserData(
      "1",
      "Ruth Milagros",
      "Arce Quispe",
      "12345678",
      "Femenino",
      "20",
      "03/02/2002",
      "978563412",
      'abcd@gmail.com',
      "Jr. Jose Carlos Mariategui #345",
      "Cusco",
      "Cusco",
      "Cusco",
      "NORMAL",
      "CAMPAÑA",
      "CONSUMO",
      "INSTITUCIONAL",
      "COOPENAVIDEÑO",
      "CONSUMO NO REVOLVENTE",
      "40 000",
      "60",
      "15.25",
      "24/12/2018",
      "16/012024",
      "972.27",
      "0",
      "40 000",
      assignedDate: DateTime.now(),
    ),
    UserData(
      "2",
      "Yolmy Milagros",
      "Cahuata Lavilla",
      "98765432",
      "Femenino",
      "20",
      "25/10/2002",
      "978563412",
      "foo@gmail.com",
      "Av. La cultura #345",
      "Cusco",
      "Cusco",
      "Cusco",
      "NORMAL",
      "RECURRENTE",
      "COMERCIAL",
      "MININEGOCIO",
      "GENÉRICO",
      "CRÉDITOS A PEQUEÑAS EMPRESAS",
      "27 000",
      "36",
      "32.15",
      "9/06/2018",
      "10/06/2021",
      "1148.27",
      "6 025,59",
      "23 974,41",
      assignedDate: DateTime.now(),
    ),
    UserData(
      "3",
      "Juan Jaime",
      "Pando Muñoz",
      "98159874",
      "Masculino",
      "20",
      "03/02/2002",
      "98159874",
      "foo@gmail.com",
      "Av. Sol de Oro #345",
      "Cusco",
      "Cusco",
      "Cusco",
      "NORMAL",
      "CAMPAÑA",
      "CONSUMO",
      "INSTITUCIONAL",
      "COOPENAVIDEÑO",
      "CONSUMO NO REVOLVENTE",
      "40 000",
      "60",
      "15.25",
      "24/12/2018",
      "16/012024",
      "972.27",
      "0",
      "40 000",
      assignedDate: DateTime.now(),
    ),
    UserData(
      "4",
      "Jaja Jaime",
      "Pando Muñoz",
      "98159874",
      "Masculino",
      "20",
      "03/02/2002",
      "98159874",
      "foo@gmail.com",
      "Av. Sol de Oro #345",
      "Cusco",
      "Cusco",
      "Cusco",
      "NORMAL",
      "RECURRENTE",
      "COMERCIAL",
      "MININEGOCIO",
      "GENÉRICO",
      "CRÉDITOS A PEQUEÑAS EMPRESAS",
      "27 000",
      "36",
      "32.15",
      "9/06/2018",
      "10/06/2021",
      "1148.27",
      "6 025,59",
      "23 974,41",
      assignedDate: DateTime.now(),
    ),
    UserData(
      "5",
      "Jose Jaime",
      "Pando Muñoz",
      "98159874",
      "Masculino",
      "20",
      "03/02/2002",
      "98159874",
      "foo@gmail.com",
      "Av. Sol de Oro #345",
      "Cusco",
      "Cusco",
      "Cusco",
      "NORMAL",
      "CAMPAÑA",
      "CONSUMO",
      "INSTITUCIONAL",
      "COOPENAVIDEÑO",
      "CONSUMO NO REVOLVENTE",
      "40 000",
      "60",
      "15.25",
      "24/12/2018",
      "16/012024",
      "972.27",
      "0",
      "40 000",
      assignedDate: DateTime.now(),
    ),
    UserData(
      "6",
      "Carlos Jaime",
      "Pando Muñoz",
      "98159874",
      "Masculino",
      "20",
      "03/02/2002",
      "98159874",
      "foo@gmail.com",
      "Av. Sol de Oro #345",
      "Cusco",
      "Cusco",
      "Cusco",
      "NORMAL",
      "RECURRENTE",
      "COMERCIAL",
      "MININEGOCIO",
      "GENÉRICO",
      "CRÉDITOS A PEQUEÑAS EMPRESAS",
      "27 000",
      "36",
      "32.15",
      "9/06/2018",
      "10/06/2021",
      "1148.27",
      "6 025,59",
      "23 974,41",
      assignedDate: DateTime.now(),
    ),
    UserData(
      "7",
      "Carla Jaime",
      "Pando Muñoz",
      "98159874",
      "Masculino",
      "20",
      "03/02/2002",
      "98159874",
      "foo@gmail.com",
      "Av. Sol de Oro #345",
      "Cusco",
      "Cusco",
      "Cusco",
      "NORMAL",
      "CAMPAÑA",
      "CONSUMO",
      "INSTITUCIONAL",
      "COOPENAVIDEÑO",
      "CONSUMO NO REVOLVENTE",
      "40 000",
      "60",
      "15.25",
      "24/12/2018",
      "16/012024",
      "972.27",
      "0",
      "40 000",
      assignedDate: DateTime.now(),
    ),
    UserData(
      "8",
      "Juan Jaime",
      "Pando Muñoz",
      "98159874",
      "Masculino",
      "20",
      "03/02/2002",
      "98159874",
      "foo@gmail.com",
      "Av. Sol de Oro #345",
      "Cusco",
      "Cusco",
      "Cusco",
      "NORMAL",
      "RECURRENTE",
      "COMERCIAL",
      "MININEGOCIO",
      "GENÉRICO",
      "CRÉDITOS A PEQUEÑAS EMPRESAS",
      "27 000",
      "36",
      "32.15",
      "9/06/2018",
      "10/06/2021",
      "1148.27",
      "6 025,59",
      "23 974,41",
      assignedDate: DateTime.now(),
    ),
    UserData(
      "9",
      "Roswell Jaime",
      "Pando Muñoz",
      "98159874",
      "Masculino",
      "20",
      "03/02/2002",
      "98159874",
      "foo@gmail.com",
      "Av. Sol de Oro #345",
      "Cusco",
      "Cusco",
      "Cusco",
      "NORMAL",
      "CAMPAÑA",
      "CONSUMO",
      "INSTITUCIONAL",
      "COOPENAVIDEÑO",
      "CONSUMO NO REVOLVENTE",
      "40 000",
      "60",
      "15.25",
      "24/12/2018",
      "16/012024",
      "972.27",
      "0",
      "40 000",
      assignedDate: DateTime.now(),
    ),
    UserData(
      "10",
      "Jacinto Jaime",
      "Pando Muñoz",
      "98159874",
      "Masculino",
      "20",
      "03/02/2002",
      "98159874",
      "foo@gmail.com",
      "Av. Sol de Oro #345",
      "Cusco",
      "Cusco",
      "Cusco",
      "NORMAL",
      "CAMPAÑA",
      "CONSUMO",
      "INSTITUCIONAL",
      "COOPENAVIDEÑO",
      "CONSUMO NO REVOLVENTE",
      "40 000",
      "60",
      "15.25",
      "24/12/2018",
      "16/012024",
      "972.27",
      "0",
      "40 000",
      assignedDate: DateTime.now(),
    ),

    // Agrega más usuarios según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BottomAppBar(
          child: TabBarBottom(),
        ),
        body: _body(),
        appBar: AppBar(
          title: const Header(),
          backgroundColor: const Color.fromARGB(255, 0, 76, 128),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: const MenuDrawer(),
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
              height: 80,
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
                      color: Color.fromARGB(255, 4, 58, 6),
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
                      color: Color(0xFFD9DEDA), width: 2.0), // Borde blanco
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: const Color.fromARGB(255, 255, 255, 255),
                elevation: 0,
                child: SizedBox(
                  height: 200, // Establece la altura deseada
                  width: 600,
                  child: SingleChildScrollView(
                    child: DataTable(
                      showCheckboxColumn: false,
                      //dataRowHeight: 50.0,
                      columnSpacing: 7.0,
                      headingRowColor:
                          MaterialStateProperty.all(const Color(0xFFD9DEDA)),
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
                                    builder: (context) => ListaSocio(
                                          tabColorLeft: const Color.fromARGB(
                                              255, 4, 58, 6),
                                          tabName: 'SEGUIMIENTO',
                                          user: user,
                                        )),
                              );
                            }
                          },
                          cells: [
                            DataCell(Text(user.number)),
                            DataCell(Text(user.dni)),
                            DataCell(Text("${user.name} ${user.lastName}")),
                            const DataCell(Icon(Icons.check)),
                          ],
                        );
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
