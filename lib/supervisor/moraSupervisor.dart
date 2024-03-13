import 'package:flutter/material.dart';
import 'package:ruta_sdg/widgets/menu_supervisor.dart';
import 'package:ruta_sdg/socio.dart';
import 'package:ruta_sdg/analista.dart';
import 'package:ruta_sdg/widgets/menu_supervisor_mobile.dart';

class MoraSupervisorPage extends StatelessWidget {
  const MoraSupervisorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MoraSupervisorContent();
  }
}

class MoraSupervisorContent extends StatefulWidget {
  const MoraSupervisorContent({Key? key}) : super(key: key);

  @override
  _MoraSupervisorContentState createState() => _MoraSupervisorContentState();
}

class _MoraSupervisorContentState extends State<MoraSupervisorContent> {
  String selectedMenu = 'MORA';
  DateTime selectedDate = DateTime.now();

  String selectedAnalistaId = '';
  List<Socio> socios = getSocios();
  int filterDays = 0;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    selectedAnalistaId = getAnalistas().first.idAnalista;
    updateSocios(selectedAnalistaId);
  }

  void updateSocios(String analistaId) {
    setState(() {
      socios = getSociosByAnalistaId(analistaId);
    });
  }

  List<Socio> getSociosByAnalistaId(String analistaId) {
    return getSocios()
        .where((socio) =>
            socio.idAnalista == analistaId &&
            (filterDays == 0 || socio.daysLate == filterDays))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MediaQuery.of(context).size.width < 640
          ? MenuSupervisorMobile(name: selectedMenu)
          : null,
      body: Row(
        children: [
          // Left side menu
          if (MediaQuery.of(context).size.width >= 640)
            MenuSupervisor(name: selectedMenu),

          // Expanded section for the main content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 40.0),
                _buildTitle(),

                // Filter widgets
                const SizedBox(height: 20.0),
                _buildAnalistaFilter(),
                const SizedBox(height: 20.0),
                _buildDiasFilter(),

                // Data table widget
                const SizedBox(height: 20.0),
                _buildDataTable(socios),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalistaFilter() {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 210),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: const Color(0xFFD9DEDA),
            width: 2.0,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Analista:',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
                width: 10), // Espacio entre el texto y el DropdownButton
            DropdownButton<String>(
              value: selectedAnalistaId,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedAnalistaId = newValue;
                    updateSocios(selectedAnalistaId);
                  });
                }
              },
              items: getAnalistas().map((analista) {
                return DropdownMenuItem<String>(
                  value: analista.idAnalista,
                  child: Text(
                    analista.name,
                    style: const TextStyle(
                      fontSize:
                          15, // Tamaño de fuente igual al del texto "Analista"
                      fontWeight: FontWeight.normal, // Eliminar la negrita
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiasFilter() {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 210),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: const Color(0xFFD9DEDA),
            width: 2.0,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Días de Mora:',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 10),
            DropdownButton<int>(
              value: filterDays,
              focusColor: Colors.transparent,
              onChanged: (int? value) {
                if (value != null) {
                  setState(() {
                    filterDays = value;
                    updateSocios(selectedAnalistaId);
                  });
                }
              },
              items: List.generate(
                11,
                (index) => DropdownMenuItem<int>(
                  value: index,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      index == 0 ? 'Todos' : '$index',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'SOCIOS EN MORA',
      style: TextStyle(
        fontSize: 25.0,
        color: Color.fromARGB(255, 0, 76, 128),
        fontWeight: FontWeight.bold,
        fontFamily: 'Montserrat',
      ),
    );
  }

  Widget _buildDataTable(List<Socio> userList) {
    List<DataRow> rows = userList.map((user) {
      return DataRow(
        cells: [
          DataCell(Text(user.dni)),
          DataCell(Text("${user.name} ${user.lastName}")),
          DataCell(Text(user.address)),
          DataCell(Text(user.daysLate.toString())),
        ],
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color.fromRGBO(255, 255, 255, 1),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        child: SizedBox(
          height: 300,
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
                DataColumn(label: Text('DÍAS DE ATRASO')),
              ],
              rows: rows,
            ),
          ),
        ),
      ),
    );
  }
}
