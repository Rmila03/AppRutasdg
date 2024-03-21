import 'package:flutter/material.dart';
import 'package:ruta_sdg/socio.dart';
import 'package:ruta_sdg/widgets/header.dart';
import "package:ruta_sdg/widgets/navigation_drawer.dart";
import 'package:ruta_sdg/widgets/tabbar.dart';
import "package:ruta_sdg/widgets/promotion_form.dart";
import "package:ruta_sdg/widgets/ampliacion_form.dart";
import "package:ruta_sdg/widgets/seguimiento_form.dart";
import "package:ruta_sdg/widgets/recuperacion_form.dart";
import "package:ruta_sdg/widgets/nuevo_form.dart";

class ListaSocio extends StatefulWidget {
  final Color tabColorLeft;
  final String tabName;
  final Socio? socio;
  const ListaSocio({
    super.key,
    required this.tabColorLeft,
    required this.tabName,
    this.socio,
  });

  @override
  ListaSocioState createState() => ListaSocioState();
}

class ListaSocioState extends State<ListaSocio> {
  late Widget CasoFormWidget; // Declara la variable para la redirección

  @override
  void initState() {
    super.initState();
    // Asigna la redirección según el valor de tabName
    if (widget.tabName == 'PROMOCIÓN') {
      CasoFormWidget = PromotionForm(
        socio: widget.socio!,
      );
    } else if (widget.tabName == 'AMPLIACIÓN') {
      CasoFormWidget = AmpliacionForm(
        socio: widget.socio!,
      );
    } else if (widget.tabName == 'SEGUIMIENTO') {
      CasoFormWidget = SeguimientoForm(
        socio: widget.socio!,
      );
    } else if (widget.tabName == 'RECUPERACIÓN') {
      CasoFormWidget = RecuperacionForm(
        socio: widget.socio!,
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
                    // Uso seguro de CasoFormWidget
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
    Key? key,
    required this.colorLeft,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, bottom: 10),
          width: 170,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 18,
                //fontFamily: 'Rockwell Extra Bold',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
