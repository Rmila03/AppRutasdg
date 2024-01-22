import 'package:flutter/material.dart';
import 'package:ruta_sdg/user.dart';
import 'package:ruta_sdg/widgets/header.dart';
import 'package:ruta_sdg/widgets/navigation_drawer.dart';
import 'package:ruta_sdg/widgets/tabbar.dart';

class SugerenciaPage extends StatefulWidget {
  const SugerenciaPage({super.key, required this.title});
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
