/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ruta_sdg/supervisor/views/reporteSupervisor.dart';
import 'package:ruta_sdg/socio.dart';

import 'package:ruta_sdg/analista.dart';
import 'package:ruta_sdg/supervisor/widgets/menu_supervisor.dart';
import 'package:ruta_sdg/supervisor/widgets/menu_supervisor_mobile.dart';

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

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: MediaQuery.of(context).size.width < 640
            ? const MenuSupervisorMobile(name: "REPORTES")
            : null,
        body: Stack(
          children: [
            Row(
              children: [
                if (MediaQuery.of(context).size.width >= 640)
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
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
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
                                  fontFamily: "HelveticaCondensed",
                                  fontSize: 25,
                                  color: Color.fromARGB(255, 0, 76, 128),
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
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Image.asset(
                                  'assets/xD.png',
                                  height: 150.0,
                                ),
                              ),
                            ),
                          ],
                        ),
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
      ),
    );
  }

  Widget _DataTable() {
    // Obtener nombre del analista y fecha actual en formato "dd/MM/yyyy"
    String nombreAnalista = getAnalistaName(widget.idAnalista);
    String fechaActual = DateFormat('dd/MM/yyyy').format(selectedDate);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Card(
        shape: const RoundedRectangleBorder(
          side:
              BorderSide(color: Color.fromARGB(255, 212, 212, 212), width: 2.0),
        ),
        color: Colors.white,
        elevation: 0,
        child: SizedBox(
          height: 130,
          width: 400,
          child: SingleChildScrollView(
            child: DataTable(
              showCheckboxColumn: false,
              columnSpacing: 0,
              headingRowHeight: 25,
              headingRowColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 255, 255, 255)),
              columns: const [
                DataColumn(
                    label: Text(
                  'HOJA DE RUTA DIARIA',
                  style: TextStyle(fontFamily: "HelveticaCondensed"),
                )),
              ],
              dataRowHeight: 25,
              rows: [
                DataRow(cells: [
                  DataCell(Text(
                    'ANALISTA: $nombreAnalista',
                    style: const TextStyle(fontFamily: "HelveticaCondensed"),
                  )),
                ]),
                DataRow(cells: [
                  DataCell(Text(
                    'FECHA: $fechaActual',
                    style: const TextStyle(fontFamily: "HelveticaCondensed"),
                  )),
                ]),
                const DataRow(cells: [
                  DataCell(Text(
                    'AGENCIA: Cusco',
                    style: TextStyle(fontFamily: "HelveticaCondensed"),
                  )), // Puedes cambiar 'Cusco' según tus necesidades
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

 /* String getAnalistaName(String idAnalista) {
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
*/
  Widget _buildDataTable(List<Socio> socioList) {
    Set<String> tiposSet = {};
    Set<String> opcionesSet = {};

    for (var socio in socioList) {
      tiposSet.add(socio.clasificacionSocio);
      opcionesSet.add(socio.tipoGrupo);
    }

    List<String> tipos = tiposSet.toList();
    List<String> opciones = opcionesSet.toList();
    tipos.insert(0, 'TODOS');
    opciones.insert(0, 'TODOS');

    String selectedTipo = 'TODOS';
    String selectedOpcion = 'TODOS';
    var tipoContainer = Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DropdownButton<String>(
        value: selectedTipo,
        items: tipos.map((String tipo) {
          return DropdownMenuItem<String>(
            value: tipo,
            child: Text(
              tipo,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontFamily: 'HelveticaCondensed',
              ),
            ),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            selectedTipo = value ?? '';
          });
        },
        hint: const Text(
          'TIPO DE SOCIO',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontFamily: 'HelveticaCondensed',
          ),
        ),
      ),
    );

    var opcionContainer = Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DropdownButton<String>(
        value: selectedOpcion,
        items: opciones.map((String opcion) {
          return DropdownMenuItem<String>(
            value: opcion,
            child: Text(
              opcion,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontFamily: 'HelveticaCondensed',
              ),
            ),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            selectedOpcion = value ?? '';
          });
        },
        hint: const Text(
          'ESTADO DE SOCIO',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontFamily: 'HelveticaCondensed',
          ),
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Color(0xFFD9DEDA), width: 2.0),
        ),
        color: Colors.white,
        elevation: 0,
        child: SizedBox(
          height: 150,
          width: 1200,
          child: SingleChildScrollView(
            child: DataTable(
              showCheckboxColumn: false,
              columnSpacing: 7.0,
              headingRowHeight: 50,
              headingRowColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 255, 255, 255),
              ),
              dataRowHeight: 30,
              columns: [
                const DataColumn(
                    label: Text(
                  'Hora',
                  style: TextStyle(fontFamily: "HelveticaCondensed"),
                )),
                const DataColumn(
                    label: Text(
                  'Apellidos y Nombres',
                  style: TextStyle(fontFamily: "HelveticaCondensed"),
                )),
                const DataColumn(
                    label: Text(
                  'DNI',
                  style: TextStyle(fontFamily: "HelveticaCondensed"),
                )),
                const DataColumn(
                    label: Text(
                  'Celular',
                  style: TextStyle(fontFamily: "HelveticaCondensed"),
                )),
                const DataColumn(
                    label: Text(
                  'Dirección',
                  style: TextStyle(fontFamily: "HelveticaCondensed"),
                )),
                DataColumn(label: tipoContainer),
                DataColumn(label: opcionContainer),
                const DataColumn(
                  label: Text(
                    'Resultados de Visita (Analista)',
                    style: TextStyle(fontFamily: "HelveticaCondensed"),
                  ),
                ),
              ],
              rows: socioList
                  /*.where((socio) =>
                    (selectedTipo == 'TODOS' ||
                        socio.clasificacionSocio == selectedTipo) &&
                    (selectedOpcion == 'TODOS' ||
                        socio.tipoGrupo == selectedOpcion))*/
                  .map((socio) {
                return DataRow(
                  cells: [
                    const DataCell(Text(
                      "Hora",
                      style: TextStyle(fontFamily: "HelveticaCondensed"),
                    )),
                    DataCell(
                      Text(
                        '${socio.lastName}, ${socio.name}',
                        style:
                            const TextStyle(fontFamily: "HelveticaCondensed"),
                      ),
                    ),
                    DataCell(Text(
                      socio.dni,
                      style: const TextStyle(fontFamily: "HelveticaCondensed"),
                    )),
                    DataCell(Text(
                      socio.cellphone,
                      style: const TextStyle(fontFamily: "HelveticaCondensed"),
                    )),
                    DataCell(Text(
                      socio.address,
                      style: const TextStyle(fontFamily: "HelveticaCondensed"),
                    )),
                    DataCell(Text(
                      socio.clasificacionSocio,
                      style: const TextStyle(fontFamily: "HelveticaCondensed"),
                    )),
                    DataCell(Text(
                      socio.tipoGrupo,
                      style: const TextStyle(fontFamily: "HelveticaCondensed"),
                    )),
                    const DataCell(Text(
                      "Feedback",
                      style: TextStyle(fontFamily: "HelveticaCondensed"),
                    )),
                  ],
                );
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
    return true;
  }
}

class TextForm extends StatefulWidget {
  final String label;
  final TextInputType inputType;
  final String content;

  const TextForm({
    super.key,
    required this.label,
    required this.inputType,
    required this.content,
  });

  @override
  _TextForm createState() => _TextForm();
}

class _TextForm extends State<TextForm> {
  final TextEditingController _controller = TextEditingController();

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
          style: const TextStyle(
              fontFamily: "HelveticaCondensed", color: Colors.black),
        ),
        Text(
          widget.label,
          style: const TextStyle(
            fontFamily: "HelveticaCondensed",
            fontSize: 12,
            color: Color.fromARGB(255, 102, 102, 102),
          ),
        ),
      ],
    );
  }
}

class clasificacionSocio {
  final String nuevo;

  DateTime? assignedDate;
  clasificacionSocio(this.nuevo, {this.assignedDate});
}

List<clasificacionSocio> getclasificacion() {
  final List<clasificacionSocio> clasificacion = [
    clasificacionSocio('NUEVO'),
    clasificacionSocio('REFERIDO ')
  ];
  return clasificacion;
}
*/