import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State createState() => MapScreen();
}

class MapScreen extends State {
  GoogleMapController? mapController;
  final Set<Marker> markers = {};

  // Ejemplo de lista de direcciones
  final List<String> addresses = [
    "Dirección 1, Ciudad",
    "Dirección 2, Ciudad",
    // Agrega más direcciones si es necesario
  ];

  @override
  void initState() {
    super.initState();
    _addMarkers();
  }

  void _addMarkers() {
    int colorIndex = 0;
    for (String address in addresses) {
      // Cambia el color para cada marcador
      BitmapDescriptor markerColor = BitmapDescriptor.defaultMarkerWithHue(
        HSLColor.fromAHSL(1, colorIndex * 15 % 360, 1.0, 0.5).hue,
      );

      markers.add(
        Marker(
          markerId: MarkerId(address),
          position: const LatLng(0,
              0), // Aquí debes obtener la ubicación real a partir de las direcciones
          icon: markerColor,
        ),
      );
      colorIndex++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        /*appBar: AppBar(
          title: Text('Home'),
        ),*/
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              height: 150,
              padding: const EdgeInsets.only(
                left: 20,
                right: 5,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(60),
                ),
                color: Color.fromARGB(255, 0, 76, 128),
              ),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.format_list_bulleted,
                            color: Colors.white,
                            size: 42.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 8,
                            ),
                            child: Image.asset(
                              'assets/logo-sdg.png', // Ruta de la imagen en assets
                              width: 45, // Ancho de la imagen
                              height: 45, // Alto de la imagen
                              fit: BoxFit.cover, // Modo de ajuste de la imagen
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
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(24),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.orange,
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
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      width: 60.0, // Ancho del contenedor
                      height: 60.0, // Alto del contenedor
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle, // Forma circular del contenedor
                        color: Colors.white, // Color de fondo del círculo
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.person_sharp,
                          color: Color.fromARGB(255, 0, 76, 128),
                          size: 60.0,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MapButton(name: 'Promoción'),
                MapButton(name: 'Mantenimiento'),
                MapButton(name: 'Recuperación'),
              ],
            ),
            GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(
                    0, 0), // Cambia a la ubicación inicial deseada del mapa
                zoom: 12,
              ),
              markers: markers,
              onMapCreated: (GoogleMapController controller) {
                setState(() {
                  mapController = controller;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MapButton extends StatelessWidget {
  final String name;
  const MapButton({
    super.key,
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
            const Icon(
              Icons.shopping_bag_outlined,
              color: Color.fromARGB(255, 0, 76, 128),
              size: 40.0,
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 0, 76, 128),
                //fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
