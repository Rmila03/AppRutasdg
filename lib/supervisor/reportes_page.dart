import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ruta_sdg/supervisor/reporteSupervisor.dart';
import 'package:ruta_sdg/socio.dart';
import 'package:ruta_sdg/widgets/menu_supervisor.dart';
import 'package:ruta_sdg/analista.dart';

class MyApp extends StatelessWidget {
  final String idAnalista;

  // Añade el constructor para recibir idAnalista
  const MyApp({Key? key, required this.idAnalista}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ReportesForm(idAnalista: idAnalista), // Pasa idAnalista aquí
    );
  }
}

class ReportesForm extends StatefulWidget {
  final String idAnalista;

  const ReportesForm({Key? key, required this.idAnalista}) : super(key: key);

  @override
  ReportesFormState createState() => ReportesFormState();
}

class ReportesFormState extends State<ReportesForm> {
  DateTime selectedDate = DateTime.now();
  final List<Socio> users = getSocios();

  @override
  Widget build(BuildContext context) {
    List<Socio> usersAssignedToToday = [];
    List<Socio> usersNotAssignedToToday = [];

    for (Socio user in users) {
      if (userIsAssignedToToday(user)) {
        usersAssignedToToday.add(user);
      } else {
        usersNotAssignedToToday.add(user);
      }
    }

    // Filtra los socios por el ID del analista
    List<Socio> sociosAsociados = getSociosForAnalista(widget.idAnalista);

    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              const MenuSupervisor(name: "REPORTES"),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 20),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ReporteSupervisorPage(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.arrow_back),
                            ),
                          ),
                          const Expanded(
                            child: Text(
                              "HOJA DE RUTA",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: _DataTable(),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 100),
                                child: Image.asset(
                                  'assets/primer.png',
                                  height: 100.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 100),
                                child: Image.asset(
                                  'assets/segundo.png',
                                  height: 100,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Center(
                            child: _buildDataTable(sociosAsociados),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _DataTable() {
    // Obtener nombre del analista y fecha actual en formato "dd/MM/yyyy"
    String nombreAnalista = getAnalistaName(widget.idAnalista);
    String fechaActual = DateFormat('dd/MM/yyyy').format(selectedDate);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        shape: const RoundedRectangleBorder(
          side:
              BorderSide(color: Color.fromARGB(255, 212, 212, 212), width: 2.0),
        ),
        color: Colors.white,
        elevation: 0,
        child: SizedBox(
          height: 200,
          width: 400,
          child: SingleChildScrollView(
            child: DataTable(
              showCheckboxColumn: false,
              columnSpacing: 7.0,
              headingRowColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 255, 255, 255)),
              columns: const [
                DataColumn(label: Text('HOJA DE RUTA DIARIA')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('ANALISTA: $nombreAnalista')),
                ]),
                DataRow(cells: [
                  DataCell(Text('FECHA: $fechaActual')),
                ]),
                DataRow(cells: [
                  DataCell(Text(
                      'AGENCIA: Cusco')), // Puedes cambiar 'Cusco' según tus necesidades
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getAnalistaName(String idAnalista) {
    // Lógica para obtener el nombre del analista según el id
    Analista analista = getAnalistaById(idAnalista);
    return '${analista.name} ${analista.lastName}';
  }

  Analista getAnalistaById(String idAnalista) {
    // Implementa la lógica para obtener el objeto Analista según el id
    // Puedes usar una función similar a getSociosForAnalista o adaptarla según tus necesidades
    return getAnalistas()
        .firstWhere((analista) => analista.idAnalista == idAnalista);
  }

  Widget _buildDataTable(List<Socio> socioList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Color(0xFFD9DEDA), width: 2.0),
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
              headingRowColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 255, 255, 255)),
              columns: const [
                DataColumn(label: Text('Hora')),
                DataColumn(label: Text('Apellidos y Nombres')),
                DataColumn(label: Text('DNI')),
                DataColumn(label: Text('Celular')),
                DataColumn(label: Text('Dirección')),
                DataColumn(label: Text('Motivo de Visita')),
                DataColumn(label: Text('Resultados de Visita (Analista)')),
              ],
              rows: socioList.expand((socio) {
                return [
                  DataRow(
                    cells: [
                      const DataCell(Text("15:25")),
                      DataCell(
                        Text('${socio.lastName}, ${socio.name}'),
                      ),
                      DataCell(Text(socio.dni)),
                      DataCell(Text(socio.cellphone)),
                      DataCell(Text(socio.address)),
                      const DataCell(Text("Socio - mora")),
                      const DataCell(Text("Feedback")),
                    ],
                  ),
                ];
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  List<Socio> getSociosForAnalista(String idAnalista) {
    // Esta función debería devolver la lista de socios asociados al idAnalista
    // Puedes implementar la lógica de filtrado según tu estructura de datos
    return getSocios()
        .where((socio) => socio.idAnalista == idAnalista)
        .toList();
  }

  bool userIsAssignedToToday(Socio user) {
    return user.assignedDate != null &&
        user.assignedDate!.toLocal().isAtSameMomentAs(selectedDate);
  }
}

class TextForm extends StatefulWidget {
  final String label;
  final TextInputType inputType;
  final String content;

  const TextForm({
    Key? key,
    required this.label,
    required this.inputType,
    required this.content,
  }) : super(key: key);

  @override
  _TextForm createState() => _TextForm();
}

class _TextForm extends State<TextForm> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.content;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: _controller,
          enabled: false,
          keyboardType: widget.inputType,
          decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 102, 102, 102)),
            ),
          ),
          style: const TextStyle(color: Colors.black),
        ),
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 12,
            color: Color.fromARGB(255, 102, 102, 102),
          ),
        ),
      ],
    );
  }
}
