import 'package:flutter/material.dart';
import 'package:ruta_sdg/widgets/promotion_form.dart';

class Promotion extends StatefulWidget {
  const Promotion({super.key});

  @override
  // ignore: library_private_types_in_public_api
  PromotionState createState() => PromotionState();
}

class PromotionState extends State<Promotion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
          title: Text('Home'),
      ),*/
      //drawer: NavigationDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 100,
                padding: const EdgeInsets.only(
                  right: 5,
                ),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 0, 76, 128),
                ),
                child: const Align(
                  alignment: Alignment.bottomLeft,
                  child: Tab(
                    colorLeft: Color(0xffef8702),
                    name: 'PROMOCIÓN',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(24),
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 2,
                      offset: const Offset(6, 0), // Sombra hacia la derecha
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 2,
                      offset: const Offset(0, 6), // Sombra hacia abajo
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
              const PromotionForm(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(),
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
            /*boxShadow: [
              BoxShadow(
                color: Color(0x3f000000),
                offset: Offset(0, 4),
                blurRadius: 2,
              )
            ],*/
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
