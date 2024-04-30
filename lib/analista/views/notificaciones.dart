import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ruta_sdg/api.dart';
import 'package:ruta_sdg/analista/widgets/header.dart';
import 'package:ruta_sdg/analista/widgets/navigation_drawer.dart';
import 'package:ruta_sdg/analista/widgets/tabbar.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 209, 200, 224)),
        useMaterial3: true,
      ),
      home: const NotificacionPage(title: ""),
    );
  }
}

class NotificacionPage extends StatefulWidget {
  const NotificacionPage({Key? key, required this.title});
  final String title;

  @override
  State<NotificacionPage> createState() => _NotificacionPageState();
}

class _NotificacionPageState extends State<NotificacionPage> {
  List<Socio> filteredSocio = [];
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
      await _fetchSocios();
    } catch (e) {
      _showErrorDialog(e.toString());
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BottomAppBar(
          child: TabBarBottom(),
        ),
        body: _body(),
        appBar: AppBar(
          title: const Header(),
          backgroundColor: const Color.fromARGB(255, 0, 76, 128),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: const MenuDrawer(),
      ),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: loading
            ? Center(
                child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 0, 74, 125)),
              ))
            : filteredSocio.isNotEmpty
                ? Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredSocio.length,
                          itemBuilder: (BuildContext context, int index) {
                            final socio = filteredSocio[index];
                            return _item(socio.fullnombre, socio.diasAtraso);
                          },
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text('No hay datos de socios'),
                  ),
      ),
    );
  }

  Widget _item(String nameSocio, int dias) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(
            color: const Color.fromARGB(255, 0, 76, 128), width: 2.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(8),
          child: Icon(
            FontAwesomeIcons.bell,
            color: Colors.red,
          ),
        ),
        title: Text(
          nameSocio,
          style: const TextStyle(
            fontFamily: "HelveticaCondensed",
            fontSize: 12.0,
            color: Colors.black87,
          ),
        ),
        trailing: Chip(
          label: Text(
            "$dias días",
            style: const TextStyle(
              fontFamily: "HelveticaCondensed",
              fontSize: 12.0,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 76, 128),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
                color: const Color.fromARGB(255, 0, 76, 128), width: 2.0),
          ),
        ),
        onTap: () {
          // Acción al hacer clic en el socio, si es necesario
        },
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
              color: Color.fromARGB(255, 179, 10, 10), // Color de texto
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

  Future<void> _fetchSocios() async {
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
      'idusuario': '17935',
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);

        List<Socio> fetchedSocios =
            jsonResponse.map((json) => Socio.fromJson(json)).toList();

        setState(() {
          filteredSocio = fetchedSocios;
          filteredSocio.sort((a, b) => b.diasAtraso.compareTo(a.diasAtraso));
        });
      } else {
        _showErrorDialog(
            'Error al obtener los socios en mora. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorDialog('Error: $e');
    }
  }
}

class MapButton extends StatelessWidget {
  final String name;
  const MapButton({
    Key? key,
    required this.name,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: GestureDetector(
        onTap: () {},
        child: Column(
          children: [
            Text(
              name,
              style: const TextStyle(
                fontFamily: "HelveticaCondensed",
                fontSize: 14,
                color: Color.fromARGB(255, 0, 76, 128),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextContainer extends StatelessWidget {
  final String text;
  final IconData leftIcon;
  final IconData rightIcon;
  final Color shadowColor;

  const CustomTextContainer({
    Key? key,
    required this.text,
    required this.leftIcon,
    this.rightIcon = FontAwesomeIcons.greaterThan,
    this.shadowColor =
        const Color.fromRGBO(0, 0, 0, 0.3), // Valor predeterminado
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270.0,
      height: 50.0,
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.zero,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                leftIcon,
                color: Colors.black,
              ),
              const SizedBox(width: 8),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: "HelveticaCondensed",
                  fontSize: 18,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                rightIcon,
                color: Colors.black,
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
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
