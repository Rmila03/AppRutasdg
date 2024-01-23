import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ruta_sdg/analista.dart';
import 'package:ruta_sdg/plandia.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ruta_sdg/widgets/bottom_action.dart';
import 'package:ruta_sdg/widgets/header.dart';
import 'package:ruta_sdg/widgets/menu_supervisor.dart';
import 'package:ruta_sdg/widgets/navigation_drawer.dart';
import 'package:ruta_sdg/widgets/tabbar.dart';
import 'package:ruta_sdg/views/promocion.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

class UbicacionSupervisorPage extends StatefulWidget {
  const UbicacionSupervisorPage({super.key});

  @override
  State createState() => _UbicacionSupervisorPage();
}

class _UbicacionSupervisorPage extends State {
  String groupSelected = "All";
  String selectedOption = '';
  Color colorButton = const Color.fromARGB(255, 4, 54, 95);
  Future<List<Analista>> getCurrentAnalistas() async {
    final analistas = getAnalistas();
    if (selectedOption == '') return analistas;
    return analistas
        .where((analista) => analista.idAnalista == selectedOption)
        .toList();
  }

  Future<Map<String, dynamic>> fetchData(String direccion) async {
    String encoded = Uri.encodeQueryComponent(direccion);
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=${encoded}&key=AIzaSyB5C0RjRYWGrgft5JsGNN69xwqXhtLMzWU'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      if (data['status'] == 'OK' && data['results'].isNotEmpty) {
        double latitud = data['results'][0]['geometry']['location']['lat'];
        double longitud = data['results'][0]['geometry']['location']['lng'];
        String formattedAddress = data['results'][0]['formatted_address'];
        return {
          'latitud': latitud,
          'longitud': longitud,
          'address': formattedAddress,
        };
      } else {
        throw Exception(
            'No se encontraron resultados para la dirección proporcionada');
      }
    } else {
      throw Exception('Error al cargar datos desde la API');
    }
  }

  final Map<String, Marker> _markers = {};
  Future<BitmapDescriptor> createCustomMarker(int r, int g, int b) async {
    const iconData = Icons.location_on;
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final iconStr = String.fromCharCode(iconData.codePoint);
    textPainter.text = TextSpan(
        text: iconStr,
        style: TextStyle(
          letterSpacing: 0.0,
          fontSize: 48.0,
          fontFamily: iconData.fontFamily,
          color: Color.fromARGB(255, r, g, b),
        ));
    textPainter.layout();
    textPainter.paint(canvas, const Offset(0.0, 0.0));
    final picture = pictureRecorder.endRecording();
    final image = await picture.toImage(48, 48);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _updateMarkers();
  }

  Future<void> _updateMarkers() async {
    final analistas = await getCurrentAnalistas();
    final newMarkers = <Marker>{};

    await Future.wait(analistas.map((analista) async {
      BitmapDescriptor color = await createCustomMarker(255, 0, 0);
      final marker = Marker(
        markerId: MarkerId(analista.name),
        position: LatLng(analista.latitud ?? 0.0, analista.longitud ?? 0.0),
        infoWindow: InfoWindow(
          title: analista.name,
          snippet: analista.address,
        ),
        icon: color,
      );
      newMarkers.add(marker);
    }));

    setState(() {
      _markers.clear();
      _markers.addAll(Map.fromIterable(newMarkers,
          key: (marker) => marker.markerId.toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Row(
                children: [
                  const MenuSupervisor(name: "UBICACIÓN"),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 25.0),
                            Container(
                              alignment: Alignment.center,
                              child: const Text(
                                'UBICACIÓN',
                                style: TextStyle(
                                  color: Color(0xFF0E813C),
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Unna-Bold',
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              alignment: Alignment.bottomLeft,
                              padding: const EdgeInsets.all(8.0),
                              width: 450,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: DropdownButton<String>(
                                value: selectedOption.isNotEmpty
                                    ? selectedOption
                                    : null,
                                items: getAnalistas().map((Analista analista) {
                                  return DropdownMenuItem<String>(
                                    value: analista.idAnalista,
                                    child: Text(
                                      '${analista.name} ${analista.lastName}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontFamily: 'Unna-Bold',
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedOption = value ?? '';
                                    _updateMarkers();
                                  });
                                },
                                hint: const Text(
                                  'Seleccionar analista',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 196, 196, 196),
                                    fontSize: 15.0,
                                    fontFamily: 'Unna-Bold',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 25.0),
                            Center(
                              child: SizedBox(
                                height: 500,
                                width: 1000,
                                child: GoogleMap(
                                  onMapCreated: _onMapCreated,
                                  initialCameraPosition: const CameraPosition(
                                    target: LatLng(-13.530757, -71.9395927),
                                    zoom: 11,
                                  ),
                                  markers: _markers.values.toSet(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
/*
  Widget _body() {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 135,
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 5,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.zero,
                  ),
                  color: Color.fromARGB(255, 0, 76, 128),
                ),
                child: Row(
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Hola RAMÓN',
                          style: TextStyle(fontSize: 17, color: Colors.yellow),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyPlanDiarioPage(
                                        title: '',
                                      )),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.all(15),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Text(
                              "PLAN DEL DIA",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 4, 54, 95),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Center(
                          child: Icon(
                            FontAwesomeIcons.user,
                            color: Color.fromARGB(255, 0, 76, 128),
                            size: 60.0,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  BottomAction(
                      label: "Promoción",
                      icon: FontAwesomeIcons.bagShopping,
                      iconColor: groupSelected == "Promoción"
                          ? Colors.orange
                          : const Color.fromARGB(255, 4, 54, 95),
                      iconSize: 30.0,
                      onTapCallback: () {
                        setState(() {
                          if (groupSelected == "Promoción") {
                            groupSelected = "All";
                          } else {
                            groupSelected = "Promoción";
                          }
                          _updateMarkers();
                        });
                      }),
                  BottomAction(
                      label: "Seguimiento",
                      icon: FontAwesomeIcons.bagShopping,
                      iconColor: groupSelected == "Seguimiento"
                          ? const Color.fromARGB(255, 4, 58, 6)
                          : const Color.fromARGB(255, 4, 54, 95),
                      iconSize: 30.0,
                      onTapCallback: () {
                        setState(() {
                          if (groupSelected == "Seguimiento") {
                            groupSelected = "All";
                          } else {
                            groupSelected = "Seguimiento";
                          }

                          _updateMarkers();
                        });
                      }),
                  BottomAction(
                      label: "Recuperación",
                      icon: FontAwesomeIcons.bagShopping,
                      iconColor: groupSelected == "Recuperación"
                          ? const Color.fromARGB(255, 114, 175, 76)
                          : const Color.fromARGB(255, 4, 54, 95),
                      iconSize: 30.0,
                      onTapCallback: () {
                        setState(() {
                          if (groupSelected == "Recuperación") {
                            groupSelected = "All";
                          } else {
                            groupSelected = "Recuperación";
                          }
                          _updateMarkers();
                        });
                      }),
                  const BottomAction(
                    label: "Nuevo",
                    icon: FontAwesomeIcons.bagShopping,
                    iconColor: Color.fromARGB(255, 4, 54, 95),
                    iconSize: 30.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
                width: 10,
              ),
              SizedBox(
                height: 500,
                width: 500,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(-13.530757, -71.9395927),
                    zoom: 13,
                  ),
                  markers: _markers.values.toSet(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
*/
}
