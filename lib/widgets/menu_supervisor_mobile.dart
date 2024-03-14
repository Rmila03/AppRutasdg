import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ruta_sdg/main.dart';
import 'package:ruta_sdg/supervisor/cartera/carterapage.dart';
import 'package:ruta_sdg/supervisor/dashboard_supervisor.dart';
import 'package:ruta_sdg/supervisor/notificacionesSupervisor.dart';
import 'package:ruta_sdg/supervisor/homeSupervisor.dart';
import 'package:ruta_sdg/supervisor/moraSupervisor.dart';
import 'package:ruta_sdg/supervisor/reporteSupervisor.dart';
import 'package:ruta_sdg/supervisor/ubicacion_supervisor.dart';

class MenuSupervisorMobile extends StatefulWidget {
  final String? name;
  const MenuSupervisorMobile({super.key, this.name});

  @override
  State<MenuSupervisorMobile> createState() => _MenuSupervisorMobileState();
}

class _MenuSupervisorMobileState extends State<MenuSupervisorMobile> {
  String selectedMenu = 'PLAN DEL DÍA';
  int _selectedIndex = 0;
  Map<String, int> positions = {
    'PLAN DEL DÍA': 0,
    'REPORTES': 1,
    'CARTERA': 2,
    'DASHBOARD': 3,
    'MORA': 4,
    'NOTIFICACIONES': 5,
    'UBICACIÓN': 6,
    'CERRAR SESIÓN': 7,
    // Agrega las demás pantallas según sea necesario
  };
  final List<Widget> _screens = [
    const MyHomeSupervisorPage(),
    const ReporteSupervisorPage(),
    const CarteraPage(),
    const DashboardSupervisorPage(),
    const MoraSupervisorPage(),
    const NotificacionesSupervisorPage(),
    const UbicacionSupervisorPage(),
    const Login(title: ''),
  ];
  @override
  void initState() {
    super.initState();
    selectedMenu = widget.name ?? 'PLAN DEL DÍA';
    _selectedIndex = positions[selectedMenu]!;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      unselectedItemColor: Colors.grey,
      selectedItemColor: const Color.fromARGB(255, 0, 76, 128),
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => _screens[_selectedIndex],
            ),
          );
        });
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.note_alt_outlined), label: "Plan del día"),
        BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined), label: "Reportes"),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet), label: "Cartera"),
        BottomNavigationBarItem(
            icon: Icon(Icons.align_vertical_bottom), label: "Dashboard"),
        BottomNavigationBarItem(icon: Icon(Icons.access_alarm), label: "Mora"),
        BottomNavigationBarItem(
            icon: Icon(Icons.notification_important), label: "Notificaciones"),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.mapLocation), label: "Ubicacion"),
        BottomNavigationBarItem(
            icon: Icon(Icons.logout), label: "Cerrar Sesión")
      ],
    );
  }

  /*Widget buildMenuItem(String title) {
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
  }*/
}
