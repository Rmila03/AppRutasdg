import 'package:flutter/material.dart';
import 'package:ruta_sdg/socio.dart';
import 'package:ruta_sdg/views/recuperacion.dart';
import 'package:ruta_sdg/widgets/custom_dropdown.dart';
import 'package:ruta_sdg/widgets/text_form_result.dart';

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
  DateTime selectedDate = DateTime.now();
  bool _isSelected = false;
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
                    Row(
                      children: [
                        const Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'DATOS DEL SOCIO',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 76, 128),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 20,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color.fromARGB(255, 0, 76, 128),
                              width: 1,
                            ),
                          ),
                          child: const Text(
                            'RIESGO',
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 76, 128),
                              fontSize: 8,
                            ),
                          ),
                        ),
                      ],
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
                        Expanded(
                          child: TextForm(
                            formKey: _formKey,
                            label: "Celular",
                            inputType: TextInputType.phone,
                            content: widget.socio.cellphone,
                          ),
                        ),
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
                                      color: Colors.black, fontSize: 12),
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
                    child: const Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "COMPROMISO DE PAGO",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 0, 76, 128),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextFormInto(label: "Fecha de cancelación: "),
                        TextFormInto(label: "Método de pago: "),
                      ],
                    ),
                  )
                ],
              ),
              /*const SizedBox(height: 15),
              RadioButtonCustom(
                option1: "SE ENCONTRÓ",
                option2: "NO SE ENCONTRÓ",
                onValueChanged: (int newValue) {
                  setState(() {
                    valorSeleccionado = newValue;
                    show = newValue;
                  });
                },
              ),
              const SizedBox(height: 15),
              Visibility(
                visible: (show == 1),
                child: Column(
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
                      child: const Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "COMPROMISO DE PAGO",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 0, 76, 128),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextFormInto(label: "Fecha de cancelación: "),
                          TextFormInto(label: "Método de pago: "),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: (show == 2 || show == 1),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: const Text(
                          "FEEDBACK",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 76, 128),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // Bordes redondeados
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 76, 128),
                            width: 2.0, // Grosor del borde al tener foco
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // Bordes redondeados
                          borderSide: const BorderSide(
                            color: Colors
                                .grey, // Color del borde cuando no tiene foco
                            width: 1.0, // Grosor del borde cuando no tiene foco
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),*/
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
                        const Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "OBSERVACIONES",
                              style: TextStyle(
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
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 90,
                          padding: const EdgeInsets.all(3),
                          margin: const EdgeInsets.only(right: 10, top: 10),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 0, 76, 128),
                            border: Border.all(
                              color: const Color.fromARGB(255, 0, 76, 128),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Actuzalizar datos',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsetsDirectional.only(top: 10),
                            height: 25,
                            child: TextField(
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 105, 105, 105),
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 105, 105, 105),
                                    width: 1.0,
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
                            fontSize: 12,
                            color: Color.fromARGB(255, 0, 76, 128),
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 105, 105, 105),
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 105, 105, 105),
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: (show != 0),
                child: Row(
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
                                  builder: (context) =>
                                      const RecuperacionPage()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(244, 244, 244, 1),
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
              style: const TextStyle(fontSize: 13),
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
              fontSize: 10,
            ),
          ),
        ),
      ]),
    );
  }
}
