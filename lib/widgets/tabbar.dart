import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ruta_sdg/widgets/bottom_action.dart';

class TabBarBottom extends StatelessWidget {
  const TabBarBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        BottomAction(
          label: "Inicio",
          icon: FontAwesomeIcons.house,
          iconColor: const Color.fromARGB(255, 4, 54, 95),
          iconSize: 20.0,
        ),
        BottomAction(
          label: "Notificaciones",
          icon: FontAwesomeIcons.solidBell,
          iconColor: const Color.fromARGB(255, 4, 54, 95),
          iconSize: 20.0,
        ),
        BottomAction(
          label: "Reportes",
          icon: FontAwesomeIcons.newspaper,
          iconColor: const Color.fromARGB(255, 4, 54, 95),
          iconSize: 20.0,
        ),
      ],
    );
  }
}
