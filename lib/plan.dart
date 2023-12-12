import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ruta_sdg/plandia.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/locations.dart' as locations;

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

  Widget _bottomAction(
      String label, IconData icon, Color iconColor, double iconSize) {
    return InkWell(
      onTap: () {
        // Lógica que se ejecuta al hacer clic en el ícono
        if (label == "Inicio") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(label),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _bottomAction("Inicio", FontAwesomeIcons.house,
                const Color.fromARGB(255, 4, 54, 95), 20.0),
            _bottomAction("Notificaciones", FontAwesomeIcons.bell,
                const Color.fromARGB(255, 4, 54, 95), 20.0),
            _bottomAction("Reportes", FontAwesomeIcons.newspaper,
                const Color.fromARGB(255, 4, 54, 95), 20.0),
          ],
        ),
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
              height: 140,
              padding: const EdgeInsets.only(
                left: 20,
                right: 5,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
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
                _bottomAction("Promoción", FontAwesomeIcons.bagShopping,
                    const Color.fromARGB(255, 4, 54, 95), 30.0),
                _bottomAction("Seguimiento", FontAwesomeIcons.bagShopping,
                    const Color.fromARGB(255, 4, 54, 95), 30.0),
                _bottomAction("Recuperación", FontAwesomeIcons.bagShopping,
                    const Color.fromARGB(255, 4, 54, 95), 30.0),
                _bottomAction("Nuevo", FontAwesomeIcons.bagShopping,
                    const Color.fromARGB(255, 4, 54, 95), 30.0),
              ],
            ),
            SizedBox(
              height: 300,
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
