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
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  _screens[_selectedIndex],
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
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
}
