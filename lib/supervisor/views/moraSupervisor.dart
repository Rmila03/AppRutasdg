import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ruta_sdg/api.dart';
import 'package:ruta_sdg/supervisor/widgets/menu_supervisor.dart';
import 'package:ruta_sdg/supervisor/widgets/menu_supervisor_mobile.dart';

class MoraSupervisorPage extends StatelessWidget {
  const MoraSupervisorPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return MoraSupervisorContent();
  }
}

class MoraSupervisorContent extends StatefulWidget {
  const MoraSupervisorContent({Key? key});

  @override
  _MoraSupervisorContentState createState() => _MoraSupervisorContentState();
}

class _MoraSupervisorContentState extends State<MoraSupervisorContent> {
  String selectedMenu = 'MORA';
  List<Socio> filteredSocio = [];
  List<Analista> analistas = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      loading = true;
    });
    try {
      await _fetchAnalistas();
      await _fetchSociosEnMora();
    } catch (e) {
      _showErrorDialog(e.toString());
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: MediaQuery.of(context).size.width < 640
            ? const MenuSupervisorMobile(name: "MORA")
            : null,
        body: Row(
          children: [
            if (MediaQuery.of(context).size.width >= 640)
              MenuSupervisor(name: selectedMenu),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildTitle(),
                    const SizedBox(height: 10.0),
                    if (loading)
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 0, 74, 125)),
                      )
                    else
                      _buildAnalistasDropdown(),
                    const SizedBox(height: 10.0),
                    _buildDataTable(filteredSocio),
                  ],
                ),
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
        'SOCIOS EN MORA',
        style: TextStyle(
          fontSize: 25.0,
          color: Color.fromARGB(255, 0, 74, 125),
          fontWeight: FontWeight.bold,
          fontFamily: 'HelveticaCondensed',
        ),
      ),
    );
  }

  Widget _buildAnalistasDropdown() {
    return SizedBox(
      width: 270,
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
            child: Text(analista.analista),
          );
        }).toList(),
        onChanged: (Analista? selectedAnalista) {
          if (selectedAnalista != null) {
            _fetchSociosEnMora(selectedAnalista.idanalista);
          }
        },
        decoration: InputDecoration(
          labelText: 'Seleccionar Analista',
          contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
          labelStyle: const TextStyle(
            fontFamily: 'HelveticaCondensed',
            color: Color.fromARGB(255, 0, 74, 125),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 0, 74, 125),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 0, 74, 125),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataTable(List<Socio> userList) {
    List<DataRow> rows = userList.map((user) {
      return DataRow(
        cells: [
          DataCell(Text(user.dni,
              style: const TextStyle(
                fontFamily: 'HelveticaCondensed',
              ))),
          DataCell(Text(user.fullnombre,
              style: const TextStyle(
                fontFamily: 'HelveticaCondensed',
              ))),
          DataCell(Text(user.direccion,
              style: const TextStyle(
                fontFamily: 'HelveticaCondensed',
              ))),
          DataCell(Text(user.diasAtraso.toString(),
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
            columnSpacing: 10.0,
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
        analistas =
            jsonResponse.map((json) => Analista.fromJson(json)).toList();
      } else {
        //print('La respuesta de la API fue nula.');
        _showErrorDialog('La respuesta de la API fue nula.');
      }
    } else {
      //print('La respuesta de la API fue nula.');
      _showErrorDialog(
          'Error al obtener los analistas. Código de estado: ${response.statusCode}');
    }
  }

  Future<void> _fetchSociosEnMora([String? idanalista]) async {
    String token = await getToken();

    final url = Uri.parse(
        'https://wsdomingo.coopsantodomingo.com/laboratorio/creditos.php?codServicio=02');

    final headers = {
      'Content-Type': 'application/json',
      "Access-Control-Allow-Origin": "*",
      'Authorization': 'Bearer $token',
      'Accept': '*/*'
    };

    final body = {
      'idusuario': idanalista ?? '12542',
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final List<dynamic>? jsonResponse = json.decode(response.body);

      if (jsonResponse != null) {
        List<Socio> fetchedSocios =
            jsonResponse.map((json) => Socio.fromJson(json)).toList();

        setState(() {
          filteredSocio = fetchedSocios;
          filteredSocio.sort((a, b) => b.diasAtraso.compareTo(a.diasAtraso));
        });
      } else {
        //print('La respuesta de la API fue nula.');
        _showErrorDialog('La respuesta de la API fue nula.');
      }
    } else {
      //print('La respuesta de la API fue nula.');
      _showErrorDialog(
          'Error al obtener los analistas. Código de estado: ${response.statusCode}');
    }
  }
}

class Socio {
  final String dni;
  final String fullnombre;
  final String direccion;
  final int diasAtraso;

  Socio({
    required this.dni,
    required this.fullnombre,
    required this.direccion,
    required this.diasAtraso,
  });

  factory Socio.fromJson(Map<String, dynamic> json) {
    return Socio(
      dni: json['dni'],
      fullnombre: json['fullnombre'],
      direccion: json['direccion'],
      diasAtraso: int.parse(json['dias_Atraso']),
    );
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
