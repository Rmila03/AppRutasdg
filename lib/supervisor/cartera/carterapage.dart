import 'package:flutter/material.dart';
import 'package:ruta_sdg/supervisor/cartera/listacartera.dart';
import 'package:ruta_sdg/widgets/menu_supervisor.dart';
import 'package:ruta_sdg/socio.dart';

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
  List<String> menuOptions = [
    'Juan Perez Garcia',
    'Ruth Milagros Arce Quispe',
    'Yolmy Milagros Cahuata Lavilla',
    'Stiward Maldonado',
    'Justino Ferro'
  ];
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
        items: menuOptions.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontFamily: 'Unna-Bold',
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
          'Seleccionar opción',
          style: TextStyle(
            color: Color.fromARGB(255, 196, 196, 196),
            fontSize: 15.0,
            fontFamily: 'Unna-Bold',
          ),
        ),
      ),
    );

    List<String> selectedSociosIds = [];

    switch (selectedOption) {
      case 'Juan Perez Garcia':
        selectedSociosIds = ['1'];
        break;
      case 'Ruth Milagros Arce Quispe':
        selectedSociosIds = ['1', '2', '3'];
        break;
      case 'Yolmy Milagros Cahuata Lavilla':
        selectedSociosIds = ['4', '5'];
        break;
      case 'Stiward Maldonado':
        selectedSociosIds = ['6', '7'];
        break;
      case 'Justino Ferro':
        selectedSociosIds = ['8', '9', '10'];
        break;
      default:
        // Handle default case if needed
        break;
    }
    for (Socio socio in socios) {
      if (selectedSociosIds.contains(socio.number)) {
        // Verificar si el usuario está asignado a la fecha de hoy
        if (socioIsAssignedToToday(socio)) {
          sociosAssignedToToday.add(socio);
        } else {
          sociosNotAssignedToToday.add(socio);
        }
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              const MenuSupervisor(name: "CARTERA"),
              Expanded(
                //child: SingleChildScrollView(
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
                            color: Colors.orange,
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
                DataColumn(label: Text('DNI')),
                DataColumn(label: Text('NOMBRE')),
                DataColumn(label: Text('DIRECCIÓN')),
              ],
              rows: socioList.map((socio) {
                return DataRow(
                  onSelectChanged: (isSelected) {
                    if (isSelected != null && isSelected) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListaSupervisor(
                            socio: socio,
                          ),
                        ),
                      );
                    }
                  },
                  cells: [
                    DataCell(Text(socio.dni)),
                    DataCell(Text("${socio.name} ${socio.lastName}")),
                    DataCell(Text(socio.address)),
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
    return socio.assignedDate != null &&
        socio.assignedDate!.toLocal().isAtSameMomentAs(selectedDate);
  }
}
