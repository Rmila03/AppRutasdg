import 'package:flutter/material.dart';
import 'package:ruta_sdg/analista.dart';
import 'package:ruta_sdg/socio.dart';
import 'package:ruta_sdg/supervisor/listacartera.dart';
import 'package:ruta_sdg/widgets/menu_supervisor.dart';
import 'package:ruta_sdg/widgets/menu_supervisor_mobile.dart';

class MoraSupervisorPage extends StatelessWidget {
  const MoraSupervisorPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MoraSupervisorContent();
  }
}

class MoraSupervisorContent extends StatefulWidget {
  const MoraSupervisorContent({Key? key});

  @override
  _MoraSupervisorContentState createState() => _MoraSupervisorContentState();
}

class _MoraSupervisorContentState extends State<MoraSupervisorContent> {
  String selectedMenu = 'MORA';
  DateTime selectedDate = DateTime.now();
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  final List<Analista> analistas = getAnalistas();
  final List<Socio> socios = getSocios();

  List<Analista> filteredAnalista = [];
  List<Socio> filteredSocio = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MediaQuery.of(context).size.width < 640
          ? const MenuSupervisorMobile(name: "MORA")
          : null,
      body: Row(
        children: [
          // Left side menu
          if (MediaQuery.of(context).size.width >= 640)
            MenuSupervisor(name: selectedMenu),

          // Expanded section for the main content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40.0),
                  _buildTitle(),
                  const SizedBox(height: 20.0),
                  _buildSearchBox(),
                  const SizedBox(height: 10.0),
                  _buildDataTable(filteredSocio),
                ],
              ),
            ),
          ),
        ],
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
        fontFamily: 'HelveticaCondensed',
      ),
    );
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 250, // Establece el ancho deseado aquí
            child: DropdownButtonFormField<Analista>(
              isExpanded: true,
              dropdownColor: Colors.white,
              focusColor: Colors.transparent,
              style: const TextStyle(
                fontFamily: 'HelveticaCondensed',
                color: Colors.black,
              ),
              items: analistas.map((Analista analista) {
                return DropdownMenuItem<Analista>(
                  value: analista,
                  child: Text("${analista.name} ${analista.lastName}"),
                );
              }).toList(),
              onChanged: (Analista? selectedAnalista) {
                if (selectedAnalista != null) {
                  searchController.text =
                      "${selectedAnalista.name} ${selectedAnalista.lastName}";
                  _updateSearchResults(selectedAnalista.idAnalista);
                }
              },
              decoration: InputDecoration(
                labelText: 'Seleccionar Analista',
                contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                labelStyle: const TextStyle(
                  fontFamily: 'HelveticaCondensed',
                  color: Color.fromARGB(255, 0, 76, 128),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 4, 56, 99),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 4, 56, 99),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable(List<Socio> userList) {
    List<DataRow> rows = userList.map((user) {
      return DataRow(
        onSelectChanged: (isSelected) {
          if (isSelected != null && isSelected) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListaSupervisor(
                  tabName: "MORA",
                  socio: user,
                ),
              ),
            );
          }
        },
        cells: [
          DataCell(Text(user.dni,
              style: const TextStyle(
                fontFamily: 'HelveticaCondensed',
              ))),
          DataCell(Text("${user.name} ${user.lastName}",
              style: const TextStyle(
                fontFamily: 'HelveticaCondensed',
              ))),
          DataCell(Text(user.address,
              style: const TextStyle(
                fontFamily: 'HelveticaCondensed',
              ))),
          DataCell(Text(user.daysLate.toString(),
              style: const TextStyle(
                fontFamily: 'HelveticaCondensed',
              ))),
        ],
      );
    }).toList();

    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color(0xFFD9DEDA),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(2.0),
      ),
      color: const Color.fromARGB(255, 255, 255, 255),
      elevation: 0,
      child: SizedBox(
        height: 300,
        width: 1000,
        child: SingleChildScrollView(
          child: DataTable(
            showCheckboxColumn: false,
            columnSpacing: 0.0,
            headingRowColor: MaterialStateProperty.all(const Color(0xFFD9DEDA)),
            columns: const [
              DataColumn(
                  label: Text('DNI',
                      style: TextStyle(
                        fontFamily: 'HelveticaCondensed',
                        fontWeight: FontWeight.bold,
                      ))),
              DataColumn(
                  label: Text('NOMBRE',
                      style: TextStyle(
                        fontFamily: 'HelveticaCondensed',
                        fontWeight: FontWeight.bold,
                      ))),
              DataColumn(
                  label: Text('DIRECCIÓN',
                      style: TextStyle(
                        fontFamily: 'HelveticaCondensed',
                        fontWeight: FontWeight.bold,
                      ))),
              DataColumn(
                  label: Text('DÍAS',
                      style: TextStyle(
                        fontFamily: 'HelveticaCondensed',
                        fontWeight: FontWeight.bold,
                      ))),
            ],
            rows: rows,
          ),
        ),
      ),
    );
  }

  void _updateSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        // Si no se ha seleccionado ningún analista, mostramos todos los socios
        filteredAnalista = analistas;
      } else {
        // Filtramos los analistas por nombre que coincida con la búsqueda
        filteredAnalista = analistas
            .where(
                (user) => user.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }

      // Si se ha seleccionado un analista, filtramos los socios asociados y los ordenamos por días de mora
      filteredSocio = query.isEmpty
          ? []
          : socios.where((socio) => socio.idAnalista == query).toList();
      filteredSocio.sort((a, b) => b.daysLate.compareTo(a.daysLate));
    });
  }
}
