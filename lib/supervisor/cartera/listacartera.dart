import 'package:flutter/material.dart';
import 'package:ruta_sdg/supervisor/cartera/cartera_form.dart';
import 'package:ruta_sdg/socio.dart';
import 'package:ruta_sdg/widgets/menu_supervisor.dart';

class ListaSupervisor extends StatefulWidget {
  final Socio socio;

  const ListaSupervisor({
    Key? key,
    required this.socio,
  }) : super(key: key);

  @override
  ListaSupervisorState createState() => ListaSupervisorState();
}

class ListaSupervisorState extends State<ListaSupervisor> {
  late Widget casoFormWidget; // Declara la variable para la redirección

  @override
  void initState() {
    super.initState();
    casoFormWidget = CarteraForm(socio: widget.socio);
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
