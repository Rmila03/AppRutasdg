import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ruta_sdg/api.dart';
//import 'package:ruta_sdg/supervisor/widgets/reportes_page.dart';
import 'package:ruta_sdg/supervisor/widgets/menu_supervisor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ruta_sdg/supervisor/widgets/menu_supervisor_mobile.dart';

class ReporteSupervisorPage extends StatelessWidget {
  const ReporteSupervisorPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return const ReporteSupervisorContent();
  }
}

class ReporteSupervisorContent extends StatefulWidget {
  const ReporteSupervisorContent({Key? key});

  @override
  _ReporteSupervisorContentState createState() =>
      _ReporteSupervisorContentState();
}

class _ReporteSupervisorContentState extends State<ReporteSupervisorContent> {
  String selectedMenu = 'REPORTES';
  DateTime selectedDate = DateTime.now();
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  List<Analista> analistas = [];
  List<Analista> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    _fetchAnalistas();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset:
            false, // Cambia a true si deseas redimensionar el contenido cuando se muestra el teclado
        bottomNavigationBar: MediaQuery.of(context).size.width < 640
            ? MenuSupervisorMobile(name: selectedMenu)
            : null,
        body: Row(
          children: [
            if (MediaQuery.of(context).size.width >= 640)
              MenuSupervisor(name: selectedMenu),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildTitle(),
                  _buildDatePicker(context),
                  const SizedBox(height: 10.0),
                  _buildSearchBox(),
                  const SizedBox(height: 10.0),
                  _buildDataTable(filteredUsers),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.only(top: 25, bottom: 16),
      child: Text(
        'REPORTES',
        style: TextStyle(
          fontSize: 25.0,
          color: Color.fromARGB(255, 0, 76, 128),
          fontWeight: FontWeight.bold,
          fontFamily: 'HelveticaCondensed',
        ),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 50.0),
          child: IconButton(
            icon: const Icon(
              FontAwesomeIcons.calendarDay,
            ),
            color: const Color.fromARGB(255, 0, 76, 128),
            onPressed: () {
              _selectDate(context);
            },
          ),
        ),
        const SizedBox(width: 10.0),
        GestureDetector(
          onTap: () {
            _selectDate(context);
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 0, 76, 128),
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              selectedDate.toLocal().toString().split(' ')[0],
              style: const TextStyle(
                  fontFamily: 'HelveticaCondensed', fontSize: 16.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBox() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(searchFocusNode);
          },
          child: Stack(
            children: [
              Container(
                width: 400.0,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromARGB(255, 0, 76, 128),
                    ),
                  ),
                ),
                child: TextField(
                  controller: searchController,
                  focusNode: searchFocusNode,
                  cursorColor: const Color.fromARGB(255, 0, 76, 128),
                  decoration: InputDecoration(
                    labelText: 'Buscar',
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 15.0),
                    labelStyle: const TextStyle(
                      fontFamily: 'HelveticaCondensed',
                      color: Color.fromARGB(255, 0, 76, 128),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 0, 76, 128),
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear_outlined),
                      color: const Color.fromARGB(255, 0, 76, 128),
                      onPressed: () {
                        searchController.clear();
                        _updateSearchResults('');
                      },
                    ),
                  ),
                  onChanged: (value) {
                    _updateSearchResults(value);
                  },
                ),
              ),
              if (searchFocusNode.hasFocus && filteredUsers.isNotEmpty)
                Positioned(
                  top: 50.0,
                  child: Container(
                    width: 400.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 0, 76, 128)),
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: ListView.builder(
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(filteredUsers[index].analista,
                              style: const TextStyle(
                                fontFamily: 'HelveticaCondensed',
                              )),
                          onTap: () {
                            searchController.text =
                                filteredUsers[index].analista;
                            _updateSearchResults(filteredUsers[index].analista);
                            searchFocusNode.unfocus();
                          },
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            message,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              fontFamily: 'HelveticaCondensed',
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Aceptar',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color.fromARGB(255, 0, 74, 125),
                  fontFamily: 'HelveticaCondensed',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDataTable(List<Analista> userList) {
    List<DataRow> rows = userList.map((user) {
      return DataRow(
        cells: [
          DataCell(Text(user.idanalista,
              style: const TextStyle(
                fontFamily: 'HelveticaCondensed',
              ))),
          DataCell(Text(user.analista,
              style: const TextStyle(
                fontFamily: 'HelveticaCondensed',
              ))),
          DataCell(
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.download),
                  onPressed: () {
                    // Agrega aquí la lógica de descarga para este usuario
                  },
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.visibility),
                  onPressed: () {
                    // Agrega aquí la lógica para el nuevo icono de "ver"
                    //_navigateToReportesForm(context, user.idAnalista);
                  },
                ),
              ],
            ),
          ),
        ],
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
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
            physics: const NeverScrollableScrollPhysics(),
            child: DataTable(
              showCheckboxColumn: false,
              columnSpacing: 7.0,
              headingRowColor:
                  MaterialStateProperty.all(const Color(0xFFD9DEDA)),
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
                    label: Text('DESCARGAR',
                        style: TextStyle(
                          fontFamily: 'HelveticaCondensed',
                          fontWeight: FontWeight.bold,
                        ))),
              ],
              rows: rows,
            ),
          ),
        ),
      ),
    );
  }
/*
  void _navigateToReportesForm(BuildContext context, String idAnalista) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ReportesForm(idAnalista: idAnalista),
      ),
    );
  }*/

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2022),
          lastDate: DateTime(2025),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: const Color.fromARGB(255, 0, 76, 128),
                hintColor: const Color.fromARGB(255, 140, 178, 210),
                colorScheme: const ColorScheme.light(
                  primary: Color.fromARGB(255, 0, 76, 128),
                ),
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        )) ??
        selectedDate;
    if (picked != selectedDate && mounted) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _updateSearchResults(String query) {
    setState(() {
      filteredUsers = analistas
          .where((user) =>
              user.analista.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> _fetchAnalistas() async {
    String token = await getToken();

    final url = Uri.parse(
        'https://wsdomingo.coopsantodomingo.com/laboratorio/creditos.php?codServicio=04');

    final headers = {
      'Content-Type': 'application/json',
      "Access-Control-Allow-Origin": "*",
      'Authorization': 'Bearer $token',
      'Accept': '*/*'
    };

    final body = {
      'idusuario': '12279',
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final List<dynamic>? jsonResponse = json.decode(response.body);

      if (jsonResponse != null) {
        setState(() {
          analistas =
              jsonResponse.map((json) => Analista.fromJson(json)).toList();
          filteredUsers = analistas; // Actualiza la lista filtrada
        });
      } else {
        _showErrorDialog('La respuesta de la API fue nula.');
      }
    }
  }
}

class Analista {
  final String idanalista;
  final String analista;

  Analista({
    required this.idanalista,
    required this.analista,
  });

  factory Analista.fromJson(Map<String, dynamic> json) {
    return Analista(
      idanalista: json['idusuario'],
      analista: json['analista'],
    );
  }
}
