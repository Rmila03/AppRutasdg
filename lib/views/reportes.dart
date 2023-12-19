import 'package:flutter/material.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'package:ruta_sdg/widgets/navigation_drawer.dart';
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
      home: const ReportePage(title: ""),
    );
  }
}

class ReportePage extends StatefulWidget {
  const ReportePage({super.key, required this.title});
  final String title;

  @override
  State<ReportePage> createState() => _ReportePageState();
}

class _ReportePageState extends State<ReportePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              _body(),
              Positioned(
                top: 5,
                left: 0,
                right: 0,
                child: AppBar(
                  backgroundColor: const Color.fromARGB(255, 0, 76, 128),
                  iconTheme: const IconThemeData(color: Colors.white),
                  title: Row(
                    children: [
                      const Text(
                        '               ',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 20),
                      Image.asset(
                        'assets/logo-sdg.png',
                        height: 45,
                        width: 45,
                      ),
                      const Text(
                        'RUTASDG',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomAppBar(
          child: TabBarBottom(),
        ),
        drawer: const menuDrawer(),
      ),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              height: 50,
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
              child: const Row(
                children: [
                  Column(
                    children: [],
                  ),
                ],
              ),
            ),
            const FechaSelector(),
          ],
        ),
      ),
    );
  }
}

class FechaSelector extends StatefulWidget {
  const FechaSelector({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FechaSelectorState createState() => _FechaSelectorState();
}

class _FechaSelectorState extends State<FechaSelector> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2024),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor:
                const Color.fromARGB(255, 4, 56, 99), // Define el color azul
            hintColor: const Color.fromARGB(
                255, 140, 178, 210), // Define el color azul
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 4, 56, 99), // Define el color azul
            ),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    ))!;
    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Transform.translate(
                offset: const Offset(
                    0.0, 20.0), // Ajusta el valor Y según sea necesario
                child: const Text(
                  "Fecha  :  ",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(
                    0.0, 21.0), // Ajusta el valor Y según sea necesario
                child: GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: Color.fromARGB(255, 4, 56, 99),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        height: 24,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        padding: const EdgeInsets.all(0.0),
                        alignment: Alignment.center,
                        child: Text(
                          "${selectedDate.toLocal()}".split(' ')[0],
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Transform.translate(
            offset: const Offset(
                0.0, 15.0), // Ajusta el valor Y según sea necesario
            child: const Text(
              "Hoja de ruta generada :  ",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
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
      width: 270.0,
      height: 50.0,
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.zero,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 3),
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
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
