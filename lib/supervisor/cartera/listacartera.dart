import 'package:flutter/material.dart';
import 'package:ruta_sdg/supervisor/cartera/cartera_form.dart';
import "package:ruta_sdg/user.dart";

class ListaSupervisor extends StatefulWidget {
  final Color tabColorLeft;
  final String tabName;
  final UserData? user;
  const ListaSupervisor({
    super.key,
    required this.tabColorLeft,
    required this.tabName,
    this.user,
  });

  @override
  ListaSupervisorState createState() => ListaSupervisorState();
}

class ListaSupervisorState extends State<ListaSupervisor> {
  // ignore: non_constant_identifier_names
  late Widget CasoFormWidget; // Declara la variable para la redirección
  // ignore: non_constant_identifier_names
  @override
  void initState() {
    super.initState();
    // Asigna la redirección según el valor de tabName
    if (widget.tabName == 'CARTERA') {
      CasoFormWidget = CarteraForm(
        user: widget.user!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "PERFIL DEL SOCIO",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CasoFormWidget,
            ],
          ),
        ),
      ),
    );
  }
}
