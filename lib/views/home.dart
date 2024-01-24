import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ruta_sdg/plandia.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ruta_sdg/socio.dart';
import 'package:ruta_sdg/widgets/bottom_action.dart';
import 'package:ruta_sdg/widgets/header.dart';
import 'package:ruta_sdg/widgets/navigation_drawer.dart';
import 'package:ruta_sdg/widgets/tabbar.dart';
import 'package:ruta_sdg/views/promocion.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
//import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() => MapScreen();
}

class MapScreen extends State {
  String groupSelected = "All";
  Color colorButton = const Color.fromARGB(255, 4, 54, 95);
  Future<List<Socio>> getSociosGroup() async {
    final socios = getSocios();
    if (groupSelected == "All") return socios;
    return socios.where((socio) => socio.tipoGrupo == groupSelected).toList();
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
    final users = await getSociosGroup();
    final newMarkers = <Marker>{};

    await Future.wait(users.map((user) async {
      BitmapDescriptor color = await createCustomMarker(255, 0, 0);
      Map<String, dynamic> locationData = await fetchData(
          "${user.address} ${user.district} ${user.province} ${user.region} Peru");
      if (user.tipoGrupo == 'Promoción') {
        color = await createCustomMarker(255, 152, 12);
      }
      if (user.tipoGrupo == 'Seguimiento') {
        color = await createCustomMarker(4, 58, 6);
      }
      if (user.tipoGrupo == 'Recuperación') {
        color = await createCustomMarker(114, 175, 76);
      }
      final marker = Marker(
        markerId: MarkerId(user.idSocio),
        position: LatLng(locationData['latitud'], locationData['longitud']),
        infoWindow: InfoWindow(
          title: user.name,
          snippet: locationData['address'],
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
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
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
    ));
  }

  Widget _bottomActionIcon(IconData icon) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          color: Colors.white,
          size: 30.0,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return const PromocionPage();
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(-1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOutCubic;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
        );
      },
    );
  }

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
                height: 400,
                width: 300,
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
}
