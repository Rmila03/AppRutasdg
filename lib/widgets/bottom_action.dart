import 'package:flutter/material.dart';
import 'package:ruta_sdg/views/home.dart';
import 'package:ruta_sdg/views/notificaciones.dart';
import 'package:ruta_sdg/views/reportes.dart';

class BottomAction extends StatelessWidget {
  String label;
  IconData icon;
  Color iconColor;
  double iconSize;
  BottomAction({
    super.key,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.iconSize,
  });

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
        }
        if (label == "Notificaciones") {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const NotificacionPage(
                      title: '',
                    )),
          );
        }
        if (label == "Reportes") {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ReportePage(
                      title: '',
                    )),
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
