import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ruta_sdg/views/reportes.dart';

class ObservacionesWidget extends StatefulWidget {
  @override
  _ObservacionesWidgetState createState() => _ObservacionesWidgetState();
}

class _ObservacionesWidgetState extends State<ObservacionesWidget> {
  bool _isSelected = false;
  bool isEditing = false;
  bool isEditing1 = false;
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(244, 244, 244, 1),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(1.0, 3.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: const Text(
                    "OBSERVACIONES",
                    style: TextStyle(
                      fontFamily: "HelveticaCondensed",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 76, 128),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isSelected = !_isSelected;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  alignment: Alignment.centerRight,
                  width: 80,
                  height: 20,
                  decoration: BoxDecoration(
                    color: _isSelected
                        ? const Color.fromARGB(255, 0, 76, 128)
                        : const Color.fromRGBO(244, 244, 244, 1),
                    border: Border.all(
                      color: const Color.fromARGB(255, 0, 76, 128),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      _isSelected ? 'SIN UBICAR' : 'SIN UBICAR',
                      style: TextStyle(
                        fontFamily: "HelveticaCondensed",
                        color: _isSelected
                            ? Colors.white
                            : const Color.fromARGB(255, 0, 76, 128),
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        isEditing1 = !isEditing1;
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: isEditing1
                          ? const Color.fromARGB(255, 0, 76, 128)
                          : const Color.fromRGBO(244, 244, 244, 1),
                      alignment: Alignment.center,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(
                          color: Color.fromARGB(255, 0, 76, 128),
                          width: 1.0,
                        ),
                      ),
                      minimumSize: const Size(70, 32),
                    ),
                    child: Text(
                      'Agendar cita',
                      style: TextStyle(
                        fontFamily: "HelveticaCondensed",
                        fontSize: 12,
                        color: isEditing1
                            ? Colors.white
                            : const Color.fromARGB(255, 0, 76, 128),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: isEditing1
                        ? FechaGestureDetector(
                            selectedDate: selectedDate,
                            selectDateCallback: _selectDate,
                            dateFormat: _dateFormat,
                          )
                        : Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 5, right: 18),
                                height: 24,
                                width: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 189, 189, 189),
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              const Icon(
                                FontAwesomeIcons.calendarDay,
                                color: Color.fromARGB(255, 189, 189, 189),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    isEditing = !isEditing; // Alternar el estado de isEditing
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: isEditing
                      ? const Color.fromARGB(255, 0, 76, 128)
                      : const Color.fromRGBO(244, 244, 244, 1),
                  //padding: const EdgeInsets.all(3),
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(
                      color: isEditing
                          ? const Color.fromARGB(255, 4, 54, 95)
                          : const Color.fromARGB(255, 0, 76, 128),
                      width: 1.0,
                    ),
                  ),
                  minimumSize: const Size(70, 32),
                ),
                child: Text(
                  'Actualizar datos',
                  style: TextStyle(
                    fontFamily: "HelveticaCondensed",
                    fontSize: 12,
                    color: isEditing
                        ? Colors.white
                        : const Color.fromARGB(255, 0, 76, 128),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  height: 25,
                  child: TextFormField(
                    enabled: isEditing,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(244, 244, 244, 1),
                      contentPadding: const EdgeInsets.symmetric(vertical: 4),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Bordes redondeados
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 79, 81, 82),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 79, 81, 82),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              //padding: const EdgeInsets.symmetric(horizontal: 8),
              margin: const EdgeInsets.only(top: 10),
              child: const Text(
                "FEEDBACK",
                style: TextStyle(
                  fontFamily: "HelveticaCondensed",
                  fontSize: 12,
                  color: Color.fromARGB(255, 0, 76, 128),
                ),
              ),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            textAlign: TextAlign.left,
            maxLines: 3,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromRGBO(244, 244, 244, 1),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 79, 81, 82),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 79, 81, 82),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
