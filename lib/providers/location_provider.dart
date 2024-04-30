import 'dart:async'; // Asegúrate de importar dart:async
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ruta_sdg/api.dart';
import 'package:http/http.dart' as http;

class UserData extends ChangeNotifier {
  String? _userId;
  String? _rol;
  // Método para actualizar el ID de usuario
  get userid {
    return _userId;
  }

  get rol {
    return _rol;
  }

  void setUser(String id, String rol) {
    _userId = id;
    _rol = rol;
    notifyListeners();
  }
}

class LocationProvider extends ChangeNotifier {
  final Geolocator _geolocator = Geolocator();
  StreamSubscription<Position>? _positionStream;
  String? userId = "asd";

  LocationProvider() {
    _initLocationUpdates();
  }

  void _initLocationUpdates() {
    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((position) {
      saveLocationToDatabase(position);
    });
  }

  void saveLocationToDatabase(Position position) {}
  Future<void> _fetchAnalistas(Position position) async {
    String token = await getToken();
    final url = Uri.parse(
        'https://wsdomingo.coopsantodomingo.com/laboratorio/creditos.php?codServicio=07');

    final headers = {
      'Content-Type': 'application/json',
      "Access-Control-Allow-Origin": "*",
      'Authorization': 'Bearer $token',
      'Accept': '*/*'
    };

    final body = {
      "idusuario": "12277",
      "fecha": "06/05/2024",
      "hora": "11:53:23",
      "longitud": position.longitude.toString(),
      "latitud": position.latitude.toString()
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(
          'Error al obtener los analistas. Código de estado: ${response.statusCode}');
    }
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }
}
