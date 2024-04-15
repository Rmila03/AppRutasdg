import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ruta_sdg/socio.dart';
import 'package:ruta_sdg/analista/views/recuperacion.dart';
import 'package:ruta_sdg/analista/views/reportes.dart';
import 'package:ruta_sdg/analista/widgets/custom_dropdown.dart';

import 'package:ruta_sdg/analista/widgets/text_form_result.dart';

class RecuperacionForm extends StatefulWidget {
  final Socio socio;
  const RecuperacionForm({super.key, required this.socio});

  @override
  RecuperacionFormState createState() {
    return RecuperacionFormState();
  }
}

class RecuperacionFormState extends State<RecuperacionForm> {
  final _formKey = GlobalKey<FormState>();
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

  int show = 0;
  int valorSeleccionado = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 10),
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
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'DATOS DEL SOCIO',
                        style: TextStyle(
                          fontFamily: "HelveticaCondensed",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 76, 128),
                        ),
                      ),
                    ),
                    TextForm(
                      formKey: _formKey,
                      label: "Nombres",
                      inputType: TextInputType.text,
                      content: widget.socio.name,
                    ),
                    TextForm(
                      formKey: _formKey,
                      label: "Apellido Paterno",
                      inputType: TextInputType.text,
                      content: widget.socio.lastName,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextForm(
                            formKey: _formKey,
                            label: "DNI",
                            inputType: TextInputType.number,
                            content: widget.socio.dni,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextForm(
                            formKey: _formKey,
                            label: "Celular",
                            inputType: TextInputType.phone,
                            content: widget.socio.cellphone,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextForm(
                            formKey: _formKey,
                            label: "Riesgo del Socio",
                            inputType: TextInputType.none,
                            content: "Normal",
                          ),
                        ),
                      ],
                    ),
                    TextForm(
                      formKey: _formKey,
                      label: "Correo electrónico",
                      inputType: TextInputType.emailAddress,
                      content: widget.socio.email,
                    ),
                    TextForm(
                      formKey: _formKey,
                      label: "Dirección",
                      inputType: TextInputType.text,
                      content: widget.socio.address,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextForm(
                            formKey: _formKey,
                            label: "Distrito",
                            inputType: TextInputType.number,
                            content: widget.socio.district,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextForm(
                            formKey: _formKey,
                            label: "Provincia",
                            inputType: TextInputType.phone,
                            content: widget.socio.province,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextForm(
                            formKey: _formKey,
                            label: "Departamento",
                            inputType: TextInputType.none,
                            content: widget.socio.region,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 10),
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
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "DATOS DEL CRÉDITO",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 0, 76, 128),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const TextFormResult(
                    label: "Tipo de socio:",
                    content: "GENERICO",
                  ),
                  const TextFormResult(
                    label: "Tipo de crédito:",
                    content: "CONSUMO",
                  ),
                  const TextFormResult(
                    label: "Tipo de producto:",
                    content: "INDEPENDIENTE",
                  ),
                  const TextFormResult(
                    label: "Modalidad:",
                    content: "COOPENAVIDEÑO",
                  ),
                ]),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 10),
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
                    Container(
                      margin: const EdgeInsetsDirectional.only(bottom: 10),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "CRÉDITO ACTUAL",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 76, 128),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        const Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  TextFormResult(
                                      label: "Crédito",
                                      content: "S/. 10000.00"),
                                  TextFormResult(
                                      label: "Monto a pagar",
                                      content: "S/. 1150.53"),
                                  TextFormResult(
                                      label: "Cuota a Pagar", content: "8"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(
                              child: TextFormResult(
                                  label: "Fecha de CPAnt",
                                  content: "12 de noviembre del 2023"),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  shape: const RoundedRectangleBorder(
                                    side: BorderSide.none, // Borde transparente
                                    borderRadius:
                                        BorderRadius.zero, // Bordes cero
                                  ),
                                ),
                                child: const Text(
                                  'Ver más',
                                  style: TextStyle(
                                      fontFamily: "HelveticaCondensed",
                                      color: Colors.black,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
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
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: const Text(
                            "COMPROMISO DE PAGO",
                            style: TextStyle(
                              fontFamily: "HelveticaCondensed",
                              fontSize: 20,
                              color: Color.fromARGB(255, 0, 76, 128),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              'Fecha de cancelación: ',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 0, 76, 128),
                                fontFamily: "HelveticaCondensed",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: FechaGestureDetector(
                                selectedDate: selectedDate,
                                selectDateCallback: _selectDate,
                                dateFormat: _dateFormat,
                              ),
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            Expanded(
                                child: CustomDropdown(
                              items: ['Agencia', 'Kasnet'],
                              label: 'Método de pago: ',
                            ))
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
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
                                          margin: const EdgeInsets.only(
                                              left: 5, right: 18),
                                          height: 24,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 189, 189, 189),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        ),
                                        const Icon(
                                          FontAwesomeIcons.calendarDay,
                                          color: Color.fromARGB(
                                              255, 189, 189, 189),
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
                              isEditing =
                                  !isEditing; // Alternar el estado de isEditing
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
                                fillColor:
                                    const Color.fromRGBO(244, 244, 244, 1),
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Bordes redondeados
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
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 5),
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
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RecuperacionPage()),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(244, 244, 244, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            Icon(
                              Icons.save,
                              color: Color.fromARGB(255, 0, 76, 128),
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'GUARDAR',
                              style: TextStyle(
                                fontFamily: "HelveticaCondensed",
                                fontSize: 15,
                                color: Color.fromARGB(255, 0, 76, 128),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InputTextForm extends StatelessWidget {
  final String label;
  final String? percentage;
  const InputTextForm({
    super.key,
    required this.label,
    this.percentage = "",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: "HelveticaCondensed",
              fontSize: 12,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[300],
              contentPadding: const EdgeInsets.symmetric(vertical: 4),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
                borderSide: BorderSide.none, // Sin borde visible
              ),

              // Puedes añadir más propiedades de estilo según tus necesidades
            ),
          ),
        ),
      ],
    );
  }
}

class TextFormInto extends StatelessWidget {
  final String label;
  const TextFormInto({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Row(
        children: [
          SizedBox(
            child: Text(
              label,
              style: const TextStyle(
                  fontFamily: "HelveticaCondensed", fontSize: 13),
            ),
          ),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 240, 240, 240),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Bordes redondeados
                  borderSide: BorderSide.none, // Sin borde visible
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextFormDate extends StatelessWidget {
  final String label;
  const TextFormDate({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: "HelveticaCondensed",
              fontSize: 10,
            ),
          ),
        ),
      ]),
    );
  }
}
