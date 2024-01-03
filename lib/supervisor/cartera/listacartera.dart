import 'package:flutter/material.dart';
import 'package:ruta_sdg/supervisor/cartera/cartera_form.dart';
import "package:ruta_sdg/user.dart";
import 'package:ruta_sdg/widgets/menu_supervisor.dart';

class ListaSupervisor extends StatefulWidget {
  final Color tabColorLeft;
  final String tabName;
  final UserData? user;
  const ListaSupervisor({
    Key? key,
    required this.tabColorLeft,
    required this.tabName,
    this.user,
  }) : super(key: key);

  @override
  ListaSupervisorState createState() => ListaSupervisorState();
}

class ListaSupervisorState extends State<ListaSupervisor> {
  // ignore: non_constant_identifier_names
  late Widget CasoFormWidget; // Declara la variable para la redirección

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
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 45,
                      padding: const EdgeInsets.only(
                        right: 5,
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: GestureDetector(
                          onTap: () {
                            // Navega de vuelta a TabNamePage() cuando se presiona el contenedor
                            Navigator.pop(context);
                          },
                          child: Tab(
                            colorLeft: widget.tabColorLeft,
                            name: widget.tabName,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(24),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: const Text(
                        "PERFIL DEL SOCIO",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    CasoFormWidget,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Tab extends StatelessWidget {
  final Color colorLeft;
  final String name;

  const Tab({
    Key? key,
    required this.colorLeft,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 55,
          width: 10,
          color: colorLeft,
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 8),
          width: 250,
          height: 55,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
            ),
          ),
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 23,
              fontFamily: 'Rockwell Extra Bold',
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
