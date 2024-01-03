import 'dart:core';
import 'package:flutter/material.dart';
import 'package:ruta_sdg/supervisor/homeSupervisor.dart';
import 'package:ruta_sdg/supervisor/cartera/listacartera.dart';
import 'package:ruta_sdg/user.dart';
import 'package:ruta_sdg/widgets/menu_supervisor.dart';

class CarteraPage extends StatefulWidget {
  const CarteraPage({Key? key}) : super(key: key);

  @override
  State createState() => _CarteraPageState();
}

class _CarteraPageState extends State<CarteraPage> {
  String selectedMenu = 'CARTERA';
  final List<UserData> users = [
    UserData(
        "1",
        "Ruth Milagros",
        "Arce Quispe",
        "12345678",
        "978563412",
        'abcd@gmail.com',
        "Jr. Jose Carlos Mariategui #345",
        "Cusco",
        "Cusco",
        "Cusco"),
    UserData("2", "Yolmy Milagros", "Cahuata Lavilla", "98765432", "978563412",
        "foo@gmail.com", "Av. La cultura #345", "Cusco", "Cusco", "Cusco"),
    // Agrega más usuarios según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const MenuSupervisor(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20.0),
                  const Text(
                    'CARTERA DE ANALISTAS',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: DropdownButton<String>(
                          items: [
                            'Juan Perez Garcia',
                            'Ruth Milagros Arce Quispe',
                            'Stiward Maldonado',
                            'Justino Ferro'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontFamily: 'Unna-Bold',
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            // Agregar lógica para manejar la opción seleccionada
                          },
                          hint: const Text(
                            'Seleccionar opción',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontFamily: 'Unna-Bold',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const SizedBox(height: 16.0),
                  Center(
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('N°')),
                        DataColumn(label: Text('DNI')),
                        DataColumn(label: Text('NOMBRE')),
                        DataColumn(label: Text('DIRECCIÓN')),
                      ],
                      rows: users.map((user) {
                        return DataRow(
                          onSelectChanged: (isSelected) {
                            if (isSelected != null && isSelected) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ListaSupervisor(
                                          tabColorLeft: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          tabName: 'CARTERA',
                                          user: user,
                                        )),
                              );
                            }
                          },
                          cells: [
                            DataCell(Text(user.number)),
                            DataCell(Text(user.dni)),
                            DataCell(Text("${user.name} ${user.lastName}")),
                            DataCell(Text(user.address)),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
