import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ruta_sdg/api.dart';
import 'package:ruta_sdg/supervisor/widgets/menu_supervisor.dart';
import 'package:ruta_sdg/supervisor/widgets/menu_supervisor_mobile.dart';

class NotificacionesSupervisorPage extends StatelessWidget {
  const NotificacionesSupervisorPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return const NotificacionesSupervisorContent();
  }
}

class NotificacionesSupervisorContent extends StatefulWidget {
  const NotificacionesSupervisorContent({Key? key});

  @override
  _NotificacionesSupervisorContentState createState() =>
      _NotificacionesSupervisorContentState();
}

class _NotificacionesSupervisorContentState
    extends State<NotificacionesSupervisorContent> {
  String selectedMenu = 'Notificaciones';
  DateTime selectedDate = DateTime.now();
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  List<Socio> filteredSocio = [];
  List<Analista> analistas = [];

  @override
  void initState() {
    super.initState();
    _fetchAnalistas();
    _fetchSocios();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Row(
              children: [
                if (MediaQuery.of(context).size.width >= 640)
                  const MenuSupervisor(name: 'NOTIFICACIONES'),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildTitle(),
                      _buildSearchBox(),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredSocio.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildNotificationCard(filteredSocio[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: MediaQuery.of(context).size.width < 640
            ? const MenuSupervisorMobile(name: 'NOTIFICACIONES')
            : null,
      ),
    );
  }

  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.only(top: 25, bottom: 16),
      child: Text(
        'NOTIFICACIONES DE CAMBIOS',
        style: TextStyle(
          fontSize: 25.0,
          color: Color.fromARGB(255, 0, 76, 128),
          fontWeight: FontWeight.bold,
          fontFamily: 'HelveticaCondensed',
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
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
            _fetchSocios(selectedAnalista.idusuario);
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

  Widget _buildNotificationCard(Socio socio) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 0, 76, 128),
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.notifications,
            color: Colors.red,
            size: 24.0,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${socio.fullnombre}',
                      style: const TextStyle(
                        fontFamily: 'HelveticaCondensed',
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      'Fecha: ${selectedDate.toString().split(' ')[0]}',
                      style: const TextStyle(
                        fontFamily: 'HelveticaCondensed',
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                const Text(
                  'Descripción del cambio:',
                  style: TextStyle(
                    fontFamily: 'HelveticaCondensed',
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 76, 128),
                  ),
                ),
                const SizedBox(height: 4.0),
                const Text(
                  'Aquí va la descripción detallada del cambio...',
                  style: TextStyle(
                    fontFamily: 'HelveticaCondensed',
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        ],
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
              fontSize: 14.0, // Tamaño de fuente
              color: Colors.black, // Color de texto
              fontFamily: 'HelveticaCondensed', // Tipo de letra
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Aceptar',
                style: TextStyle(
                  fontSize: 16.0, // Tamaño de fuente
                  color:
                      Color.fromARGB(255, 0, 74, 125), // Color de texto en azul
                  fontFamily: 'HelveticaCondensed',
                  fontWeight: FontWeight.bold, // Tipo de letra
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

// LLAMADAS HACIA LAS APIS
// ----------------------

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
      print(
          'Error al obtener los analistas. Código de estado: ${response.statusCode}');
    }
  }

  Future<void> _fetchSocios([String? idUsuario]) async {
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
      'idusuario': idUsuario ?? '12542',
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
        _showErrorDialog('No existen datos de socios de este analista');
      }
    } else {
      print(
          'Error al obtener los socios en mora. Código de estado: ${response.statusCode}');
    }
  }
}

// CLASES
// --------
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
  final String idusuario;
  final String analista;

  Analista({
    required this.idusuario,
    required this.analista,
  });

  factory Analista.fromJson(Map<String, dynamic> json) {
    return Analista(
      idusuario: json['idusuario'],
      analista: json['analista'],
    );
  }
}
