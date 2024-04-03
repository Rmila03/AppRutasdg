import 'package:flutter/material.dart';
import 'package:ruta_sdg/socio.dart';
//import 'package:ruta_sdg/views/motivo_dialog.dart';
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

  DataRow _buildDataRow(Socio user) {
    return DataRow(
      cells: [
        DataCell(Text(
          user.dni,
          style: const TextStyle(
            fontFamily: 'HelveticaCondensed',
            fontSize: 13,
          ),
        )),
        DataCell(
          Text(
            "${user.name} ${user.lastName}",
            style: const TextStyle(
              fontFamily: 'HelveticaCondensed',
              fontSize: 13,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () {
              _showMotivoDialog(user);
            },
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 200, // Máximo ancho del campo
              ),
              child: Text(
                motivos[user] ?? "agregar",
                style: const TextStyle(
                  fontFamily: 'HelveticaCondensed',
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
    String motivo = motivos[socio] ?? ''; // Definir el motivo aquí
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Agregar motivo',
          style: TextStyle(
            fontFamily: "HelveticaCondensed",
          ),
        ),
        content: TextField(
          onChanged: (value) {
            motivo = value; // Actualizar el motivo cuando cambie el texto
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
            child: const Text(
              'Cancelar',
              style: TextStyle(
                fontFamily: "HelveticaCondensed",
                color: Color.fromARGB(255, 0, 76, 128),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _updateMotivo(socio,
                  motivo); // Llamar a una función para actualizar el motivo
            },
            child: const Text(
              'Aceptar',
              style: TextStyle(
                fontFamily: "HelveticaCondensed",
                color: Color.fromARGB(255, 0, 76, 128),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateMotivo(Socio socio, String motivo) {
    setState(() {
      motivos[socio] = motivo;
    });

    // enviar el motivo a la base de datos
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
            Center(
              // Centrar el TextField
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: searchController,
                  onChanged: searchUsers,
                  style: const TextStyle(
                    fontFamily: 'HelveticaCondensed',
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
                        color: Color.fromARGB(255, 0, 76, 128),
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
                child: Center(
                  // Centrar el DataTable
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
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
                                  fontFamily: 'HelveticaCondensed',
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 0, 0, 0))),
                        ),
                        DataColumn(
                          label: Text('Nombres y Apellidos',
                              style: TextStyle(
                                  fontFamily: 'HelveticaCondensed',
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 0, 0, 0))),
                        ),
                        DataColumn(
                          label: Text('Motivo',
                              style: TextStyle(
                                  fontFamily: 'HelveticaCondensed',
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 0, 0, 0))),
                        ),
                      ],
                      rows: (searchResults.isEmpty ? socios : searchResults)
                          .map((user) => _buildDataRow(user))
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
