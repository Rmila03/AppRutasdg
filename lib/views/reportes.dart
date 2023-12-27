import 'package:flutter/material.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'package:ruta_sdg/widgets/header.dart';
import 'package:ruta_sdg/widgets/navigation_drawer.dart';
import 'package:ruta_sdg/widgets/tabbar.dart';
import 'package:intl/intl.dart';

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
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BottomAppBar(
          child: TabBarBottom(),
        ),
        body: _body(),
        appBar: AppBar(
          title: const Header(),
          backgroundColor: const Color.fromARGB(255, 0, 76, 128),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: const MenuDrawer(),
      ),
    );
  }

  Widget _body() {
    return const SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            FechaSelector(),
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
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2024),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color.fromARGB(255, 4, 56, 99),
            hintColor: const Color.fromARGB(255, 140, 178, 210),
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 4, 56, 99),
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
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0, top: 20),
                      child: Text(
                        "FECHA :  ",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0, top: 20),
                      child: Container(
                        height: 24,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.all(0.0),
                        alignment: Alignment.center,
                        child: Text(
                          _dateFormat.format(selectedDate),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 20),
                      child: Icon(
                        Icons.calendar_today,
                        color: Color.fromARGB(255, 4, 56, 99),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10.0, top: 20),
            child: Text(
              "Hoja de ruta generada :  ",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  // Lógica para mostrar la ventana emergente del PDF
                  // Puedes utilizar showDialog para mostrar un AlertDialog o cualquier otra lógica que prefieras.
                  // Aquí hay un ejemplo de cómo usar showDialog:
                  showDialog(
                    context:
                        context, // Asegúrate de tener una referencia al contexto actual
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                            "Hoja de ruta del ${_dateFormat.format(selectedDate)}"),
                        content: const Text("Contenido de la Hoja de Ruta"),
                        actions: [
                          TextButton(
                            child: const Text("Cerrar"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 40.0, top: 20),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.picture_as_pdf,
                        color: Colors.red,
                        size: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Hoja de ruta del ${_dateFormat.format(selectedDate)}",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20),
                child: Icon(
                  Icons.download_sharp,
                  color: Color.fromARGB(255, 0, 76, 128),
                  size: 35,
                ),
              ),
            ],
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
