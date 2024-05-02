import 'package:flutter/material.dart';
import 'package:ruta_sdg/analista.dart';
import 'package:ruta_sdg/socio.dart';
import 'package:ruta_sdg/supervisor/listacartera.dart';
import 'package:ruta_sdg/supervisor/widgets/menu_supervisor.dart';
import 'package:ruta_sdg/supervisor/widgets/menu_supervisor_mobile.dart';

class CarteraPage extends StatefulWidget {
  const CarteraPage({Key? key}) : super(key: key);

  @override
  _CarteraPageState createState() => _CarteraPageState();
}

class _CarteraPageState extends State<CarteraPage> {
  late String selectedOption;
  final List<Analista> analistas = getAnalistas();
  final List<Socio> socios = getSocios();

  @override
  void initState() {
    super.initState();
    selectedOption = '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: MediaQuery.of(context).size.width < 640
            ? const MenuSupervisorMobile(name: "CARTERA")
            : null,
        body: Row(
          children: [
            if (MediaQuery.of(context).size.width >= 640)
              const MenuSupervisor(name: "CARTERA"),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'CARTERA DE ANALISTAS',
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Color.fromARGB(255, 0, 76, 128),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'HelveticaCondensed',
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildDropdown(),
                    SizedBox(height: 25.0),
                    if (selectedOption.isNotEmpty)
                      _buildDataTable(
                          "CARTERA", SociosPorAnalista(selectedOption)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButton<String>(
        dropdownColor: Colors.white,
        focusColor: Colors.transparent,
        value: selectedOption.isNotEmpty ? selectedOption : null,
        items: analistas.map((analista) {
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
        onChanged: (value) {
          setState(() {
            selectedOption = value!;
          });
        },
        hint: const Text(
          'Seleccionar analista',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 74, 125),
            fontSize: 15.0,
            fontFamily: "HelveticaCondensed",
          ),
        ),
      ),
    );
  }

  List<String> SociosPorAnalista(String analistaId) {
    return socios
        .where((socio) => socio.idAnalista == analistaId)
        .map((socio) => socio.idSocio)
        .toList();
  }

  Widget _buildDataTable(String title, List<String> socioList) {
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
              rows: socioList.map((socioId) {
                var socio = socios.firstWhere((s) => s.idSocio == socioId);
                return DataRow(
                  onSelectChanged: (_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListaSupervisor(
                          tabName: title,
                          socio: socio,
                        ),
                      ),
                    );
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
}
