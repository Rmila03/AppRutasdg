import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ruta_sdg/plandia.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ruta_sdg/widgets/bottom_action.dart';
import 'package:ruta_sdg/widgets/header.dart';
import 'package:ruta_sdg/widgets/navigation_drawer.dart';
import 'package:ruta_sdg/widgets/tabbar.dart';
import '../mapa/locations.dart' as locations;
import 'package:ruta_sdg/views/promocion.dart';

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
    );
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
            const Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                BottomAction(
                  label: "Promoción",
                  icon: FontAwesomeIcons.bagShopping,
                  iconColor: Color.fromARGB(255, 4, 54, 95),
                  iconSize: 30.0,
                ),
                BottomAction(
                  label: "Seguimiento",
                  icon: FontAwesomeIcons.bagShopping,
                  iconColor: Color.fromARGB(255, 4, 54, 95),
                  iconSize: 30.0,
                ),
                BottomAction(
                  label: "Recuperación",
                  icon: FontAwesomeIcons.bagShopping,
                  iconColor: Color.fromARGB(255, 4, 54, 95),
                  iconSize: 30.0,
                ),
                BottomAction(
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
