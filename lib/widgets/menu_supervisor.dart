import 'package:flutter/material.dart';
import 'package:ruta_sdg/main.dart';
import 'package:ruta_sdg/supervisor/cartera/carterapage.dart';
import 'package:ruta_sdg/supervisor/dashboard_supervisor.dart';
import 'package:ruta_sdg/supervisor/historialSupervisor.dart';
import 'package:ruta_sdg/supervisor/homeSupervisor.dart';

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
    'REPORTES': const MyHomeSupervisorPage(),
    'CARTERA': const CarteraPage(),
    'DASHBOARD': const DashboardSupervisorPage(),
    'MORA': const MyHomeSupervisorPage(),
    'HISTORIAL': const HistorialSupervisorPage(),
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
    Color customColor = const Color(0xFFD9DEDA);
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
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ),
          buildMenuItem('PLAN DEL DÍA'),
          buildMenuItem('REPORTES'),
          buildMenuItem('CARTERA'),
          buildMenuItem('DASHBOARD'),
          buildMenuItem('MORA'),
          buildMenuItem('HISTORIAL'),
          buildMenuItem('CERRAR SESIÓN'),
        ],
      ),
    );
  }

  Widget buildMenuItem(String title) {
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
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: selectedMenu == title
              ? const Color(0xFFD9DEDA)
              : Colors.transparent,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selectedMenu == title ? Colors.orange : Colors.black,
            fontSize: 12.0,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
