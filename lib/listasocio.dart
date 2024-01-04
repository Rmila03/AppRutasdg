import 'package:flutter/material.dart';
import "package:ruta_sdg/user.dart";
import 'package:ruta_sdg/widgets/header.dart';
import "package:ruta_sdg/widgets/navigation_drawer.dart";
import 'package:ruta_sdg/widgets/tabbar.dart';
import "package:ruta_sdg/widgets/promotion_form.dart";
import "package:ruta_sdg/widgets/seguimiento_form.dart";
import "package:ruta_sdg/widgets/recuperacion_form.dart";
import "package:ruta_sdg/widgets/nuevo_form.dart";

class ListaSocio extends StatefulWidget {
  final Color tabColorLeft;
  final String tabName;
  final UserData? user;
  const ListaSocio({
    super.key,
    required this.tabColorLeft,
    required this.tabName,
    this.user,
  });

  @override
  ListaSocioState createState() => ListaSocioState();
}

class ListaSocioState extends State<ListaSocio> {
  // ignore: non_constant_identifier_names
  late Widget CasoFormWidget; // Declara la variable para la redirección

  @override
  void initState() {
    super.initState();
    // Asigna la redirección según el valor de tabName
    if (widget.tabName == 'PROMOCIÓN') {
      CasoFormWidget = PromotionForm(
        user: widget.user!,
      );
    } else if (widget.tabName == 'SEGUIMIENTO') {
      CasoFormWidget = SeguimientoForm(
        user: widget.user!,
      );
    } else if (widget.tabName == 'RECUPERACIÓN') {
      CasoFormWidget = RecuperacionForm(
        user: widget.user!,
      );
    } else if (widget.tabName == 'NUEVO') {
      CasoFormWidget = const NuevoForm();
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
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 0, 76, 128),
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
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 2,
                            offset: const Offset(6, 0),
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 2,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Text(
                        "DATOS DEL SOCIO",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
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
        bottomNavigationBar: const BottomAppBar(
          child: TabBarBottom(),
        ),
        appBar: AppBar(
          title: const Header(),
          backgroundColor: const Color.fromARGB(255, 0, 76, 128),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: const MenuDrawer(),
      ),
    );
  }
}

class Tab extends StatelessWidget {
  final Color colorLeft;
  final String name;

  const Tab({
    super.key,
    required this.colorLeft,
    required this.name,
  });

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
              color: Colors.black,
              shadows: [
                Shadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 3.0,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
