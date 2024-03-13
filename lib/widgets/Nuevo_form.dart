import 'package:flutter/material.dart';
//import 'package:ruta_sdg/plandia.dart';
import 'package:ruta_sdg/views/home.dart';
import 'package:ruta_sdg/widgets/custom_dropdown.dart';

import 'text_form_result.dart';

class NuevoForm extends StatefulWidget {
  const NuevoForm({super.key});

  @override
  NuevoFormState createState() {
    return NuevoFormState();
  }
}

class NuevoFormState extends State<NuevoForm> {
  final _formKey = GlobalKey<FormState>();

  bool checkVisible = false;

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
                    const TextFormInto(label: "DNI"),
                    TextForm(
                      formKey: _formKey,
                      label: "Nombres",
                      InputType: TextInputType.text,
                    ),
                    TextForm(
                      formKey: _formKey,
                      label: "Apellido Paterno",
                      InputType: TextInputType.text,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextForm(
                            formKey: _formKey,
                            label: "DNI",
                            InputType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextForm(
                            formKey: _formKey,
                            label: "Celular",
                            InputType: TextInputType.phone,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextForm(
                            formKey: _formKey,
                            label: "Riesgo del Socio",
                            InputType: TextInputType.none,
                          ),
                        ),
                      ],
                    ),
                    TextForm(
                      formKey: _formKey,
                      label: "Correo electrónico",
                      InputType: TextInputType.emailAddress,
                    ),
                    TextForm(
                      formKey: _formKey,
                      label: "Dirección",
                      InputType: TextInputType.text,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextForm(
                            formKey: _formKey,
                            label: "Distrito",
                            InputType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextForm(
                            formKey: _formKey,
                            label: "Provincia",
                            InputType: TextInputType.phone,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextForm(
                            formKey: _formKey,
                            label: "Departamento",
                            InputType: TextInputType.none,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                child: const Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'DATOS DEL CRÉDITO',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 76, 128),
                        ),
                      ),
                    ),
                    CustomDropdown(
                      items: ['Socio 1', 'Socio 2', 'Socio 3'],
                      label: "Tipo de Socio:",
                    ),
                    CustomDropdown(
                      items: ['Crédito 1', 'Crédito 2', 'Crédito 3'],
                      label: "Tipo de Crédito:",
                    ),
                    CustomDropdown(
                      items: ['Producto 1', 'Producto 2', 'Producto 3'],
                      label: "Tipo de Producto:",
                    ),
                    CustomDropdown(
                      items: ['Modalidad 1', 'Modalidad 2', 'Modalidad 3'],
                      label: "Modalidad:",
                    ),
                  ],
                ),
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
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "CÁLCULO DEL CRÉDITO",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 0, 76, 128),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Row(
                      children: [
                        Expanded(
                          child: InputTextForm(
                            label: "Crédito total",
                          ),
                        ),
                        Expanded(
                          child: InputTextForm(
                            label: "Plazo(meses)",
                          ),
                        ),
                        Expanded(
                          child: InputTextForm(
                            label: "Interés(%)",
                            percentage: "%",
                          ),
                        ),
                      ],
                    ),
                    const TextFormResult(
                        label: "Pago Mensual:", content: "s/. 120.50"),
                    const TextFormResult(
                      label: "Primera fecha de pago:",
                      content: "12/02/2023",
                    ),
                    const TextFormResult(
                        label: "Última fehca de pago", content: "12/02/2024"),
                    Row(
                      children: [
                        const Text(
                          '¿ESTÁ INTERESADO?',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color.fromARGB(255, 0, 76, 128),
                          ),
                        ),
                        IconButton(
                          icon: Icon(checkVisible
                              ? Icons.check_circle
                              : Icons.circle_outlined),
                          iconSize: 20.0,
                          color: checkVisible ? Colors.green : Colors.grey,
                          onPressed: () {
                            setState(() {
                              checkVisible = !checkVisible;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
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
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'OBSERVACIONES',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 0, 76, 128),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
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

class TextFormInto extends StatelessWidget {
  final String label;
  const TextFormInto({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    // Borde personalizado
                    borderRadius:
                        BorderRadius.circular(10.0), // Bordes redondeados
                    borderSide: BorderSide.none, // Sin borde visible
                  ),
                  focusedBorder: OutlineInputBorder(
                    // Borde cuando está enfocado
                    borderRadius: BorderRadius.circular(10.0),
                    // ignore: prefer_const_constructors
                    borderSide: BorderSide(
                        color: Colors.white, width: 0), // Grosor del borde
                  ),
                  suffixIcon: InkWell(
                      onTap: () {
                        //Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      },
                      child: const Icon(
                        Icons.search,
                        color: Colors.black,
                      )
                      /*Icons.search,
                    color: Colors.black,*/
                      )

                  // Puedes añadir más propiedades de estilo según tus necesidades
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextForm extends StatelessWidget {
  const TextForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.label,
    // ignore: non_constant_identifier_names
    required this.InputType,
  }) : _formKey = formKey;
  final String label;
  // ignore: non_constant_identifier_names
  final TextInputType InputType;
  // ignore: unused_field
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 30,
          child: TextFormField(
            keyboardType: InputType,
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color.fromARGB(255, 0, 76, 128),
          ),
        ),
      ],
    );
  }
}
