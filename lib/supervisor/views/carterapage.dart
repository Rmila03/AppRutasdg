import 'package:flutter/material.dart';
import 'package:ruta_sdg/analista.dart';
import 'package:ruta_sdg/supervisor/listacartera.dart';
import 'package:ruta_sdg/widgets/menu_supervisor.dart';
import 'package:ruta_sdg/socio.dart';
import 'package:ruta_sdg/widgets/menu_supervisor_mobile.dart';

void main() {
  runApp(const CarteraPage());
}

class CarteraPage extends StatelessWidget {
  const CarteraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomeCarteraPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomeCarteraPage extends StatefulWidget {
  const MyHomeCarteraPage({super.key});

  @override
  _MyHomeCarteraPageState createState() => _MyHomeCarteraPageState();
}

class _MyHomeCarteraPageState extends State<MyHomeCarteraPage>
    with SingleTickerProviderStateMixin {
  String selectedOption = '';
  DateTime selectedDate = DateTime.now();

  List<Analista> analistas = getAnalistas();
  final List<Socio> socios = getSocios();

  @override
  Widget build(BuildContext context) {
    List<Socio> sociosAssignedToToday = [];
    List<Socio> sociosNotAssignedToToday = [];
    var container = Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButton<String>(
        value: selectedOption.isNotEmpty ? selectedOption : null,
        items: analistas.map((Analista analista) {
          return DropdownMenuItem<String>(
            value: analista.idAnalista,
            child: Text(
              '${analista.name} ${analista.lastName}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontFamily: "HelveticaCondensed",
              ),
            ),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            selectedOption = value ?? '';
          });
        },
        hint: const Text(
          'Seleccionar analista',
          style: TextStyle(
            color: Color.fromARGB(255, 196, 196, 196),
            fontSize: 15.0,
            fontFamily: "HelveticaCondensed",
          ),
        ),
      ),
    );

    List<String> selectedSociosIds = [];

    switch (selectedOption) {
      case '1':
        selectedSociosIds = SociosPorAnalista(analistaId: '1', socios: socios);
        break;
      case '2':
        selectedSociosIds = SociosPorAnalista(analistaId: '2', socios: socios);
        break;
      case '3':
        selectedSociosIds = SociosPorAnalista(analistaId: '3', socios: socios);
        break;
      case '4':
        selectedSociosIds = SociosPorAnalista(analistaId: '4', socios: socios);
        break;
      case '5':
        selectedSociosIds = SociosPorAnalista(analistaId: '5', socios: socios);
        break;
      case '6':
        selectedSociosIds = SociosPorAnalista(analistaId: '6', socios: socios);
        break;
      case '7':
        selectedSociosIds = SociosPorAnalista(analistaId: '7', socios: socios);
        break;
      case '8':
        selectedSociosIds = SociosPorAnalista(analistaId: '8', socios: socios);
        break;
      case '9':
        selectedSociosIds = SociosPorAnalista(analistaId: '9', socios: socios);
        break;

      // Repite este bloque para cada analista (hasta el '10')
      case '10':
        selectedSociosIds = SociosPorAnalista(analistaId: '10', socios: socios);
        break;
      default:
        // Handle default case if needed
        break;
    }
    for (Socio socio in socios) {
      if (selectedSociosIds.contains(socio.idSocio)) {
        // Verificar si el usuario está asignado a la fecha de hoy
        if (socioIsAssignedToToday(socio)) {
          sociosAssignedToToday.add(socio);
        } else {
          sociosNotAssignedToToday.add(socio);
        }
      }
    }

    return Scaffold(
      bottomNavigationBar: MediaQuery.of(context).size.width < 640
          ? const MenuSupervisorMobile(name: "CARTERA")
          : null,
      body: Stack(
        children: [
          Row(
            children: [
              if (MediaQuery.of(context).size.width >= 640)
                const MenuSupervisor(name: "CARTERA"),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25.0),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'CARTERA DE ANALISTAS',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 4, 54, 95),
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          container,
                          //const SizedBox(width: 0), // Ajuste del margen derecho
                        ],
                      ),
                      const SizedBox(height: 25.0),
                      Center(
                        child: _buildDataTable(
                            selectedOption, sociosAssignedToToday),
                      )
                    ],
                  ),
                  //),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  List<String> SociosPorAnalista({
    required String analistaId,
    required List<Socio> socios,
  }) {
    return socios
        .where((socio) => socio.idAnalista == analistaId)
        .map((socio) => socio.idSocio)
        .toList();
  }

  Widget _buildDataTable(String title, List<Socio> socioList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFFD9DEDA), width: 2.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 0,
        child: SizedBox(
          height: 400,
          width: 1000,
          child: SingleChildScrollView(
            child: DataTable(
              showCheckboxColumn: false,
              columnSpacing: 7.0,
              headingRowColor:
                  MaterialStateProperty.all(const Color(0xFFD9DEDA)),
              columns: const [
                DataColumn(
                  label: Text(
                    'DNI',
                    style: TextStyle(
                      fontFamily: "HelveticaCondensed",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                    label: Text(
                  'NOMBRE',
                  style: TextStyle(
                    fontFamily: "HelveticaCondensed",
                    fontWeight: FontWeight.bold,
                  ),
                )),
                DataColumn(
                    label: Text(
                  'DIRECCIÓN',
                  style: TextStyle(
                    fontFamily: "HelveticaCondensed",
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ],
              rows: socioList.map((socio) {
                return DataRow(
                  onSelectChanged: (isSelected) {
                    if (isSelected != null && isSelected) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListaSupervisor(
                            tabName: "CARTERA",
                            socio: socio,
                          ),
                        ),
                      );
                    }
                  },
                  cells: [
                    DataCell(
                      Text(
                        socio.dni,
                        style: const TextStyle(
                          fontFamily: "HelveticaCondensed",
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        "${socio.name} ${socio.lastName}",
                        style: const TextStyle(
                          fontFamily: "HelveticaCondensed",
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        socio.address,
                        style: const TextStyle(
                          fontFamily: "HelveticaCondensed",
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  bool socioIsAssignedToToday(Socio socio) {
    // Lógica para verificar si el usuario está asignado a la fecha de hoy
    return true;
  }
}
