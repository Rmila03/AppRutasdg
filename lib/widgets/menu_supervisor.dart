import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ruta_sdg/main.dart';
import 'package:ruta_sdg/supervisor/views/carterapage.dart';
import 'package:ruta_sdg/supervisor/views/dashboard_supervisor.dart';
import 'package:ruta_sdg/supervisor/views/notificacionesSupervisor.dart';
import 'package:ruta_sdg/supervisor/views/homeSupervisor.dart';
import 'package:ruta_sdg/supervisor/views/moraSupervisor.dart';
import 'package:ruta_sdg/supervisor/views/reporteSupervisor.dart';
import 'package:ruta_sdg/supervisor/views/ubicacion_supervisor.dart';

class MenuSupervisor extends StatefulWidget {
  final String? name;
  const MenuSupervisor({super.key, this.name});

  @override
  State<MenuSupervisor> createState() => _MenuSupervisorState();
}

class _MenuSupervisorState extends State<MenuSupervisor> {
  String selectedMenu = 'PLAN DEL DÍA';
  Map<String, Widget> screens = {
    'PLAN DEL DÍA': const MyHomeSupervisorPage(),
    'REPORTES': const ReporteSupervisorPage(),
    'CARTERA': const CarteraPage(),
    'DASHBOARD': const DashboardSupervisorPage(),
    'MORA': const MoraSupervisorPage(),
    'NOTIFICACIONES': const NotificacionesSupervisorPage(),
    'UBICACIÓN': const UbicacionSupervisorPage(),
    'CERRAR SESIÓN': const Login(title: ''),
    // Agrega las demás pantallas según sea necesario
  };
  @override
  void initState() {
    super.initState();
    selectedMenu = widget.name ?? 'PLAN DEL DÍA';
  }

  @override
  Widget build(BuildContext context) {
    Color customColor = const Color.fromARGB(255, 0, 76, 128);
    return Container(
      width: 250,
      color: customColor,
      //decoration: const BoxDecoration(
      //  border: Border(right: BorderSide(color: Colors.black, width: 2.0, style: BorderStyle.solid)),
      //),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Agregar la imagen y el texto arriba de los buildMenuItem
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo-sdg.png', width: 50, height: 50),
                const SizedBox(width: 8.0),
                const Text(
                  'RUTASDG',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "HelveticaCondensed",
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          buildMenuItem('PLAN DEL DÍA', Icons.note_alt_outlined),
          buildMenuItem('REPORTES', Icons.description_outlined),
          buildMenuItem('CARTERA', Icons.account_balance_wallet),
          buildMenuItem('DASHBOARD', Icons.align_vertical_bottom),
          buildMenuItem('MORA', Icons.access_alarm),
          buildMenuItem('NOTIFICACIONES', Icons.notification_important),
          buildMenuItem('UBICACIÓN', FontAwesomeIcons.mapLocation),
          buildMenuItem('CERRAR SESIÓN', Icons.logout),
        ],
      ),
    );
  }

  Widget buildMenuItem(String title, IconData icon) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedMenu = title;
        });

        // Redirigir a la pantalla correspondiente
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => screens[selectedMenu]!,
          ),
        );
      },
      child: Container(
        width: 250,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        decoration: BoxDecoration(
          color: selectedMenu == title
              ? const Color.fromARGB(255, 3, 57, 94)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Center(
              child: Text(
                title,
                style: TextStyle(
                  color: selectedMenu == title ? Colors.white : Colors.white,
                  fontSize: 12.0,
                  fontFamily: "HelveticaCondensed",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
