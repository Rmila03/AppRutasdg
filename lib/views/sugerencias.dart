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
  Map<Socio, String> motivos = {};

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
        DataCell(Text(user.dni, style: const TextStyle(fontSize: 13))),
        DataCell(
          Text(
            "${user.name} ${user.lastName}",
            style: const TextStyle(fontSize: 13),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () {
              _showMotivoDialog(user);
            },
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 200, // Máximo ancho del campo
              ),
              child: Text(
                motivos[user] ?? "agregar",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showMotivoDialog(Socio socio) {
    showDialog(
      context: context,
      builder: (context) {
        String motivo = motivos[socio] ?? '';
        return AlertDialog(
          title: const Text('Agregar motivo'),
          content: TextField(
            onChanged: (value) {
              motivo = value;
            },
            controller: TextEditingController(text: motivo),
            decoration: const InputDecoration(
              hintText: 'Ingrese el motivo',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  motivos[socio] = motivo;
                });
                Navigator.pop(context);
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 5.0, bottom: 5.0),
                child: TextField(
                  controller: searchController,
                  onChanged: searchUsers,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Buscar socio',
                    hintStyle: TextStyle(
                      fontSize: 15,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
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
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFD9D9D9),
                      ),
                    ),
                    child: DataTable(
                      columnSpacing: 10.0,
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => const Color(0xFFD9D9D9)),
                      dataRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                      columns: const [
                        DataColumn(
                          label: Text('DNI',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 0, 0, 0))),
                        ),
                        DataColumn(
                          label: Text('Nombres y Apellidos',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 0, 0, 0))),
                        ),
                        DataColumn(
                          label: Text('Motivo',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 0, 0, 0))),
                        ),
                      ],
                      rows: (searchResults.isEmpty ? socios : searchResults)
                          .map((user) => buildDataRow(user))
                          .toList(),
                    ),
                  ),
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
