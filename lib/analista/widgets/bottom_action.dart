import 'package:flutter/material.dart';
import 'package:ruta_sdg/analista/views/home.dart';
import 'package:ruta_sdg/analista/views/notificaciones.dart';
import 'package:ruta_sdg/analista/views/reportes.dart';
import 'package:ruta_sdg/listasocio.dart';
import 'package:ruta_sdg/analista/views/sugerencias.dart';
import 'package:ruta_sdg/analista/views/cartera.dart';

class BottomAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final VoidCallback? onTapCallback;

  const BottomAction({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.iconSize,
    this.onTapCallback,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapCallback ??
          () {
            // Lógica que se ejecuta al hacer clic en el ícono
            if (label == "Inicio") {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const HomePage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            } else if (label == "Notificaciones") {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const NotificacionPage(title: ''),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            } else if (label == "Cartera") {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const CarteraPage(title: ''),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            } else if (label == "Reportes") {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const ReportePage(title: ''),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            } /* else if (label == "Sugerencias") {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const SugerenciaPage(title: ''),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            }*/
            else if (label == "Nuevo") {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const ListaSocio(
                    tabColorLeft: Colors.orange,
                    tabName: 'NUEVO',
                  ),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
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
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: "HelveticaCondensed",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
