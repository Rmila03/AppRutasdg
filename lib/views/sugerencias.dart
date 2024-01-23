import 'package:flutter/material.dart';
import 'package:ruta_sdg/socio.dart';
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
  final List<Socio> socios = getSocios();
  List<Socio> searchResults = [];

  TextEditingController searchController = TextEditingController();

  void searchUsers(String query) {
    setState(() {
      searchResults = socios
          .where(
              (user) => user.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  DataRow buildDataRow(Socio user) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            "${user.name} ${user.lastName}",
            style: const TextStyle(fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        DataCell(Text(user.tipoGrupo, style: const TextStyle(fontSize: 14))),
        DataCell(
          IconButton(
            onPressed: () {
              // Lógica para añadir al usuario
            },
            icon: const Icon(Icons.add, color: Color.fromARGB(255, 4, 56, 99)),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomAppBar(
        child: TabBarBottom(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
                height: 16), // Añade un espacio debajo del encabezado
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 8.0), // Ajusta el margen izquierdo
                child: TextField(
                  controller: searchController,
                  onChanged: searchUsers,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Buscar por nombre',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 4, 56, 99),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => const Color.fromARGB(255, 0, 76, 128)),
                  columnSpacing: 10.0, // Ajusta la distancia entre las columnas
                  columns: const [
                    DataColumn(
                      label: Text('NOMBRE',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    DataColumn(
                      label: Text('MODALIDAD',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    DataColumn(
                      label: Text('', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                  rows:
                      searchResults.map((user) => buildDataRow(user)).toList(),
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
    );
  }
}
