import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ruta_sdg/widgets/bottom_action.dart';

class TabBarBottom extends StatelessWidget {
  const TabBarBottom({
    super.key,
  });

  // Definimos una constante para el color común de los íconos
  static const Color iconColor = Color.fromARGB(255, 0, 76, 128);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        BottomAction(
          label: "Inicio",
          icon: FontAwesomeIcons.house,
          iconColor: iconColor,
          iconSize: 18.0,
        ),
        BottomAction(
          label: "Cartera",
          icon: FontAwesomeIcons.folderOpen,
          iconColor: iconColor,
          iconSize: 18.0,
        ),
        BottomAction(
          label: "Notificaciones",
          icon: FontAwesomeIcons.solidBell,
          iconColor: iconColor,
          iconSize: 18.0,
        ),
        BottomAction(
          label: "Sugerencias",
          icon: FontAwesomeIcons.plus,
          iconColor: iconColor,
          iconSize: 18.0,
        ),
        BottomAction(
          label: "Reportes",
          icon: FontAwesomeIcons.newspaper,
          iconColor: iconColor,
          iconSize: 18.0,
        ),
      ],
    );
  }
}
