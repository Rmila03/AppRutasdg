import 'package:flutter/material.dart';
import 'package:ruta_sdg/socio.dart';
import 'package:ruta_sdg/views/seguimiento.dart';
import 'package:ruta_sdg/widgets/custom_dropdown.dart';
import 'package:ruta_sdg/widgets/text_form_result.dart';

class SeguimientoForm extends StatefulWidget {
  final Socio socio;
  const SeguimientoForm({super.key, required this.socio});

  @override
  SeguimientoFormState createState() {
    return SeguimientoFormState();
  }
}

class SeguimientoFormState extends State<SeguimientoForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isSelected = false;
  bool isEditing = false;
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
                                  ? const Color.fromARGB(255, 4, 54, 95)
                                  : const Color.fromRGBO(244, 244, 244, 1),
                              border: Border.all(
                                color: const Color.fromARGB(255, 4, 54, 95),
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
                                    : const Color.fromARGB(255, 105, 105, 105),
                                width: 1.0,
                              ),
                            ),
                            minimumSize: const Size(70, 32),
                          ),
                          child: Text(
                            isEditing ? 'Actualizar datos' : 'Actualizar datos',
                            style: TextStyle(
                              fontSize: 12,
                              color: isEditing ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            height: 25,
                            child: TextFormField(
                              enabled: isEditing,
                              keyboardType: TextInputType.number,
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
                            fontSize: 12,
                            color: Color.fromARGB(255, 0, 76, 128),
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
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
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SeguimientoPage()),
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
      ),
    );
  }
}

class RadioButtonCustom extends StatefulWidget {
  const RadioButtonCustom({super.key});

  @override
  _RadioButtonCustomState createState() => _RadioButtonCustomState();
}

class _RadioButtonCustomState extends State<RadioButtonCustom> {
  int selectedButton = 0; // Inicialmente ningún botón seleccionado

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          //width: 600,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // Bordes redondeados
            border: Border.all(
              color: const Color.fromRGBO(160, 218, 183, 1), // Color del borde
              width: 3, // Grosor del borde
            ),
            color: const Color.fromRGBO(160, 218, 183, 1),
          ),
          child: const Center(
            child: Text(
              '¿Necesita actualizar dato(s)?',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedButton = 1; // Primer botón seleccionado
              });
            },
            child: Container(
              //padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), // Bordes redondeados
                border: Border.all(
                  color:
                      const Color.fromRGBO(150, 158, 153, 1), // Color del borde
                  width: 1.5, // Grosor del borde
                ),
                color: selectedButton == 1
                    ? const Color.fromRGBO(150, 158, 153, 1)
                    : Colors.white,
              ),
              child: const Center(
                child: Text(
                  'SI',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedButton = 2; // Segundo botón seleccionado
              });
            },
            child: Container(

                //padding:const EdgeInsets.symmetric(vertical: 2, horizontal: 40),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), // Bordes redondeados
                  border: Border.all(
                    color: const Color.fromRGBO(
                        150, 158, 153, 1), // Color del borde
                    width: 1.5, // Grosor del borde
                  ),
                  color: selectedButton == 2
                      ? const Color.fromRGBO(150, 158, 153, 1)
                      : Colors.white,
                ),
                child: const Center(
                  child: Text(
                    'NO',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ),
        ),
      ],
    );
  }
}

class Encontro extends StatefulWidget {
  const Encontro({super.key});

  @override
  _Encontro createState() => _Encontro();
}

class _Encontro extends State<Encontro> {
  int selectedButton = 0; // Inicialmente ningún botón seleccionado

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedButton = 1; // Primer botón seleccionado
              });
            },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), // Bordes redondeados
                  border: Border.all(
                    color: const Color.fromRGBO(
                        150, 158, 153, 1), // Color del borde
                    width: 1.5, // Grosor del borde
                  ),
                  color: selectedButton == 1
                      ? const Color.fromRGBO(150, 158, 153, 1)
                      : Colors.white,
                ),
                child: const Center(
                  child: Text(
                    'SE ENCONTRÓ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedButton = 2; // Segundo botón seleccionado
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // Bordes redondeados
                border: Border.all(
                  color:
                      const Color.fromRGBO(150, 158, 153, 1), // Color del borde
                  width: 1.5, // Grosor del borde
                ),
                color: selectedButton == 2
                    ? const Color.fromRGBO(150, 158, 153, 1)
                    : Colors.white,
              ),
              child: const Center(
                child: Text(
                  'NO SE ENCONTRÓ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
