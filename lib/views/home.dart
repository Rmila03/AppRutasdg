import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ruta_sdg/plandia.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ruta_sdg/widgets/bottom_action.dart';
import 'package:ruta_sdg/widgets/tabbar.dart';
import '../mapa/locations.dart' as locations;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() => MapScreen();
}

class MapScreen extends State {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        BitmapDescriptor markerColor = BitmapDescriptor.defaultMarkerWithHue(
          const HSLColor.fromAHSL(1, 3 * 15 % 360, 1.0, 0.5).hue,
        );
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
          icon: markerColor,
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomAppBar(
        child: TabBarBottom(),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
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
                      Row(
                        children: [
                          const Icon(
                            Icons.format_list_bulleted,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 8,
                            ),
                            child: Image.asset(
                              'assets/logo-sdg.png',
                              width: 45,
                              height: 45,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Text(
                            'RUTASDG',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
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
                  iconColor: const Color.fromARGB(255, 4, 54, 95),
                  iconSize: 30.0,
                ),
                BottomAction(
                  label: "Seguimiento",
                  icon: FontAwesomeIcons.bagShopping,
                  iconColor: const Color.fromARGB(255, 4, 54, 95),
                  iconSize: 30.0,
                ),
                BottomAction(
                  label: "Recuperación",
                  icon: FontAwesomeIcons.bagShopping,
                  iconColor: const Color.fromARGB(255, 4, 54, 95),
                  iconSize: 30.0,
                ),
                BottomAction(
                  label: "Nuevo",
                  icon: FontAwesomeIcons.bagShopping,
                  iconColor: const Color.fromARGB(255, 4, 54, 95),
                  iconSize: 30.0,
                ),
              ],
            ),
            SizedBox(
              height: 30,
              width: 10,
            ),
            SizedBox(
              height: 400,
              width: 300,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(0, 0),
                  zoom: 2,
                ),
                markers: _markers.values.toSet(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
