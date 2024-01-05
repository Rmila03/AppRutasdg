import 'package:flutter/material.dart';
import 'package:ruta_sdg/supervisor/cartera/cartera_form.dart';
import "package:ruta_sdg/user.dart";
import 'package:ruta_sdg/widgets/menu_supervisor.dart';

class ListaSupervisor extends StatefulWidget {
  final UserData user;

  const ListaSupervisor({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  ListaSupervisorState createState() => ListaSupervisorState();
}

class ListaSupervisorState extends State<ListaSupervisor> {
  late Widget casoFormWidget; // Declara la variable para la redirección

  @override
  void initState() {
    super.initState();
    casoFormWidget = CarteraForm(user: widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Row(
          children: [
            const MenuSupervisor(name: "CARTERA"),
            Expanded(
              child: casoFormWidget,
            ),
          ],
        ),
      ),
    );
  }
}
