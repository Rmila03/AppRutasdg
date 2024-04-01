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
  _FechaSelectorState createState() => _FechaSelectorState();
}

class _FechaSelectorState extends State<FechaSelector> {
  DateTime selectedDate = DateTime.now();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color.fromARGB(255, 0, 76, 128),
            hintColor: const Color.fromARGB(255, 140, 178, 210),
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 0, 76, 128),
            ),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    // Verificar si el usuario seleccionó una fecha o canceló la selección
    if (picked != null) {
      setState(() {
        selectedDate = picked!;
      });
    } else {
      // Si el usuario canceló la selección, asignar la fecha actual
      picked = DateTime.now();
      setState(() {
        selectedDate = picked!;
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
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Row(
              children: [
                const Text(
                  "FECHA :  ",
                  style: TextStyle(
                    fontFamily: 'HelveticaCondensed',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                FechaGestureDetector(
                  selectedDate: selectedDate,
                  selectDateCallback: _selectDate,
                  dateFormat: _dateFormat,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10.0, top: 20),
            child: Text(
              "Reporte generado :  ",
              style: TextStyle(
                fontFamily: 'HelveticaCondensed',
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          FechaContent(selectedDate: selectedDate, dateFormat: _dateFormat),
        ],
      ),
    );
  }
}

class FechaGestureDetector extends StatelessWidget {
  const FechaGestureDetector({
    super.key,
    required this.selectedDate,
    required this.selectDateCallback,
    required this.dateFormat,
  });

  final DateTime selectedDate;
  final Function(BuildContext) selectDateCallback;
  final DateFormat dateFormat;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => selectDateCallback(context),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Container(
                  height: 24,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors
                            .black /*color: const Color.fromARGB(255, 225, 228, 233)*/),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(0.0),
                  alignment: Alignment.center,
                  child: Text(
                    dateFormat.format(selectedDate),
                    style: const TextStyle(
                      fontFamily: 'HelveticaCondensed',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Icon(
                  FontAwesomeIcons.calendarDay,
                  color: Color.fromARGB(255, 0, 76, 128),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FechaContent extends StatelessWidget {
  const FechaContent({
    super.key,
    required this.selectedDate,
    required this.dateFormat,
  });

  final DateTime selectedDate;
  final DateFormat dateFormat;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "Reporte del ${dateFormat.format(selectedDate)}",
                    style: const TextStyle(
                      fontFamily: "HelveticaCondensed",
                    ),
                  ),
                  content: const Text(
                    "Contenido del reporte",
                    style: TextStyle(
                      fontFamily: "HelveticaCondensed",
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: const Text(
                        "Cerrar",
                        style: TextStyle(
                          fontFamily: "HelveticaCondensed",
                        ),
                      ),
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
                  size: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Reporte del ${dateFormat.format(selectedDate)}",
                    style: const TextStyle(
                      fontFamily: 'HelveticaCondensed',
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
            size: 30,
          ),
        ),
      ],
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
                fontFamily: 'HelveticaCondensed',
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
    super.key,
    required this.text,
    required this.leftIcon,
    this.rightIcon = FontAwesomeIcons.greaterThan,
    this.shadowColor =
        const Color.fromRGBO(0, 0, 0, 0.3), // Valor predeterminado
  });

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
                  fontFamily: 'HelveticaCondensed',
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
