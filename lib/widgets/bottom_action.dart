import 'package:flutter/material.dart';
import 'package:ruta_sdg/views/home.dart';
import 'package:ruta_sdg/views/notificaciones.dart';
import 'package:ruta_sdg/views/reportes.dart';
import 'package:ruta_sdg/listasocio.dart';

class BottomAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final double iconSize;

  const BottomAction({
    Key? key,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Lógica que se ejecuta al hacer clic en el ícono
        if (label == "Inicio") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else if (label == "Notificaciones") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NotificacionPage(title: ''),
            ),
          );
        } else if (label == "Reportes") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ReportePage(title: ''),
            ),
          );
        } else if (label == "Nuevo") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ListaSocio(
                tabColorLeft: Colors.orange,
                tabName: 'NUEVO',
              ),
            ),
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
}
