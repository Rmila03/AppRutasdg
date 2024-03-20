import 'package:flutter/material.dart';
import 'package:ruta_sdg/main.dart';
import 'package:ruta_sdg/views/home.dart';
import '../views/reportes.dart';
import '../views/notificaciones.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  "RAMÓN PEREZ",
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              accountEmail: Text(
                "ramonp123@coopacsdg.com",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14.0,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              decoration: BoxDecoration(color: Color.fromARGB(255, 0, 76, 128)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(
                'Inicio',
                style: TextStyle(fontFamily: "Poppins", fontSize: 20.0),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.newspaper),
              title: const Text(
                'Notificaciones',
                style: TextStyle(fontFamily: "Poppins", fontSize: 20.0),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificacionPage(
                      title: '',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text(
                'Configuración',
                style: TextStyle(fontFamily: "Poppins", fontSize: 20.0),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf_rounded),
              title: const Text(
                'Reporte',
                style: TextStyle(fontFamily: "Poppins", fontSize: 20.0),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReportePage(
                      title: '',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text(
                'Ayuda o Soporte',
                style: TextStyle(fontFamily: "Poppins", fontSize: 20.0),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(
                      title: '',
                    ),
                  ),
                );
              },
              child: const ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text(
                  'Cerrar Sesión',
                  style: TextStyle(fontFamily: "Poppins", fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
