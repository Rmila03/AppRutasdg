import 'package:flutter/material.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'package:ruta_sdg/views/promocion.dart';
import 'package:ruta_sdg/views/recuperacion.dart';
import 'package:ruta_sdg/views/seguimiento.dart';
import 'package:ruta_sdg/widgets/header.dart';
import 'package:ruta_sdg/widgets/tabbar.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 209, 200, 224)),
        useMaterial3: true,
      ),
      home: const MyPlanDiarioPage(title: ""),
    );
  }
}

class MyPlanDiarioPage extends StatefulWidget {
  const MyPlanDiarioPage({super.key, required this.title});
  final String title;

  @override
  State<MyPlanDiarioPage> createState() => _MyPlanDiarioPageState();
}

class _MyPlanDiarioPageState extends State<MyPlanDiarioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomAppBar(
        child: TabBarBottom(),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              height: 125,
              padding: const EdgeInsets.only(
                left: 20,
                right: 5,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.zero,
                ),
                color: Color.fromARGB(255, 0, 76, 128),
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      const Header(),
                      Container(
                        margin: const EdgeInsets.all(24),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Text(
                          "PLAN DEL DIA",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: Icon(
                          FontAwesomeIcons.user,
                          color: Color.fromARGB(255, 0, 76, 128),
                          size: 60.0,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Reemplaza con tu texto deseado
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PromocionPage()),
                );
              },
              child: const CustomTextContainer(
                text: "PROMOCIÓN",
                leftIcon: FontAwesomeIcons.bullhorn,
                shadowColor: Colors.orange,
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SeguimientoPage()),
                );
              },
              child: const CustomTextContainer(
                text: "SEGUIMIENTO",
                leftIcon: FontAwesomeIcons.fileCircleCheck,
                shadowColor: Color.fromARGB(255, 4, 58, 6),
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RecuperacionPage()),
                );
              },
              child: const CustomTextContainer(
                text: "RECUPERACIÓN",
                leftIcon: FontAwesomeIcons.wallet,
                shadowColor: Color.fromARGB(255, 114, 175, 76),
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}

class MapButton extends StatelessWidget {
  final String name;
  const MapButton({
    super.key,
    required this.name,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: GestureDetector(
        onTap: () {},
        child: Column(
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 0, 76, 128),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextContainer extends StatelessWidget {
  final String text;
  final IconData leftIcon;
  final IconData rightIcon;
  final Color shadowColor;

  const CustomTextContainer({
    Key? key,
    required this.text,
    required this.leftIcon,
    this.rightIcon = FontAwesomeIcons.greaterThan,
    this.shadowColor =
        const Color.fromRGBO(0, 0, 0, 0.3), // Valor predeterminado
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min, // Establecer mainAxisSize en min
          children: [
            Container(
              width: 15.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: shadowColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(
                      5.0), // Redondear la esquina superior derecha
                  bottomLeft: Radius.circular(
                      5.0), // Redondear la esquina inferior derecha
                ),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    spreadRadius: 1,
                    blurRadius: 1.5,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
            Container(
              width: 250.0,
              height: 50.0,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(
                      5.0), // Redondear la esquina superor derecha
                  bottomRight: Radius.circular(
                      5.0), // Redondear la esquina inferior derecha
                ),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        leftIcon,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        rightIcon,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
