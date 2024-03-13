import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShowData extends StatefulWidget {
  const ShowData({super.key});

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  Future<String> getData() async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=Av.+La+cultura+322,+Cusco&key=AIzaSyB5C0RjRYWGrgft5JsGNN69xwqXhtLMzWU'));

    if (response.statusCode == 200) {
      // Si la solicitud es exitosa, devuelve el cuerpo de la respuesta
      json.decode(response.body);
      print("----------------------------------");
      //print(data['results'][0]['formatted_address']);
      //print(data['results'][0]['geometry']);
      print(response.body);
      return response.body;
    } else {
      // Si la solicitud no es exitosa, lanza una excepción
      throw Exception('Error al cargar datos desde la API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: FutureBuilder<String>(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Muestra un indicador de carga mientras se espera la respuesta de la API
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // Muestra un mensaje de error si ocurre algún problema
                return Text('Error: ${snapshot.error}');
              } else {
                // Muestra los datos obtenidos de la API
                return SingleChildScrollView(
                  child: Center(
                    child: Text('Datos de la API: ${snapshot.data}'),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
