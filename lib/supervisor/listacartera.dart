import 'package:flutter/material.dart';
import 'package:ruta_sdg/supervisor/widgets/cartera_form.dart';
import 'package:ruta_sdg/socio.dart';
import 'package:ruta_sdg/widgets/menu_supervisor.dart';

class ListaSupervisor extends StatefulWidget {
  final Socio? socio;
  final String tabName;

  const ListaSupervisor({
    super.key,
    required this.tabName,
    this.socio,
  });

  @override
  ListaSupervisorState createState() => ListaSupervisorState();
}

class ListaSupervisorState extends State<ListaSupervisor> {
  late Widget CasoFormWidget; // Declara la variable para la redirección

  @override
  void initState() {
    super.initState();
    // Asigna la redirección según el valor de tabName
    if (widget.tabName == 'CARTERA') {
      CasoFormWidget = CarteraForm(
        socio: widget.socio!,
      );
    }
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
              child: CasoFormWidget,
            ),
          ],
        ),
      ),
    );
  }
}
