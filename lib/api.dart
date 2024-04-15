import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

Future<String> getToken() async {
  var url = Uri.parse(
      "https://wsdomingo.coopsantodomingo.com/laboratorio/autenticacion.php");

  try {
    final response = await http.post(
      url,
      body: jsonEncode({"usuario": "LABO_PRU", "clave": "Coop_S4nt0D0m1ng0"}),
      headers: <String, String>{'Content-Type': 'application/json'},
    );
    print(response);
    if (response.statusCode == 200) {
      String responseBody = utf8.decoder.convert(response.bodyBytes);
      var res = jsonDecode(responseBody);
      String token = res["token"];
      return token;
    } else {
      return "-1";
    }
  } catch (e) {
    print('Error: $e');
  }
  return "-1";
}

void getData() async {
  String token = await getToken();

  //var url = Uri.https('wsdomingo.coopsantodomingo.com',
  //    '/laboratorio/creditos.php', {'codServicio': '01'});
  var url = Uri.parse(
      "https://wsdomingo.coopsantodomingo.com/laboratorio/creditos.php?codServicio=01");
  try {
    final response = await http.post(
      url,
      body: jsonEncode({"idusuario": "17935"}),
      headers: {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
        'Accept': '*/*'
      },
    );
    print(response);
    if (response.statusCode == 200) {
      String responseBody = utf8.decoder.convert(response.bodyBytes);

      print('Response: $responseBody');
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
