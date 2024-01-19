import 'package:flutter/material.dart';
import 'package:ruta_sdg/user.dart';
import 'package:ruta_sdg/widgets/header.dart';
import 'package:ruta_sdg/widgets/navigation_drawer.dart';
import 'package:ruta_sdg/widgets/tabbar.dart';

class SugerenciaPage extends StatefulWidget {
  const SugerenciaPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SugerenciaPage> createState() => _SugerenciaPageState();
}

class _SugerenciaPageState extends State<SugerenciaPage> {
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
      "22",
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
    // Agrega más usuarios según sea necesario
  ];

  List<UserData> searchResults = [];

  TextEditingController searchController = TextEditingController();

  void searchUsers(String query) {
    // Filtra la lista de usuarios por nombre
    setState(() {
      searchResults = users
          .where(
              (user) => user.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BottomAppBar(
          child: TabBarBottom(),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchController,
                  onChanged: searchUsers,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 7, 12)),
                  decoration: const InputDecoration(
                    hintText: 'Buscar por nombre',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Nombre')),
                      DataColumn(label: Text('DNI')),
                      DataColumn(label: Text('')),
                    ],
                    rows: searchResults.map((user) {
                      return DataRow(
                        cells: [
                          DataCell(Text(user.name)),
                          DataCell(Text(user.dni)),
                          DataCell(
                            ElevatedButton(
                              onPressed: () {
                                // Lógica para añadir al usuario
                                // Puedes implementar la lógica según tus necesidades
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                    255, 0, 76, 128), // Color azul
                              ),
                              child: const Text('Añadir',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Header(),
          backgroundColor: const Color.fromARGB(255, 0, 76, 128),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: const MenuDrawer(),
      ),
    );
  }
}
