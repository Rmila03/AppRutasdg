import 'package:flutter/material.dart';
import 'package:ruta_sdg/socio.dart';
import 'package:ruta_sdg/views/seguimiento.dart';
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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
              const SizedBox(
                height: 10,
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
              const SizedBox(
                height: 10,
              ),
              const Encontro(),
              const RadioButtonCustom(),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(10), // Bordes redondeados
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.2), // Color y opacidad de la sombra
                        offset:
                            const Offset(0, 2), // Desplazamiento de la sombra
                        blurRadius: 4, // Radio de desenfoque de la sombra
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
                      color:
                          Colors.grey, // Color del borde cuando no tiene foco
                      width: 1.0, // Grosor del borde cuando no tiene foco
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          /*ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );*/
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SeguimientoPage()),
                          );
                        }
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10), // Padding en todos los lados
                        ),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // Bordes redondeados
                            side: const BorderSide(
                                color: Color.fromARGB(255, 0, 76, 128),
                                width: 2.0), // Color y grosor del borde
                          ),
                        ),
                      ),
                      child: const Text(
                        'GUARDAR',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 0, 76, 128),
                          fontWeight: FontWeight.bold,
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
              focusedBorder: OutlineInputBorder(
                // Borde cuando está enfocado
                borderRadius: BorderRadius.circular(10.0),
                // ignore: prefer_const_constructors
                borderSide: BorderSide(
                    color: Colors.white, width: 0), // Grosor del borde
              ),
              // Puedes añadir más propiedades de estilo según tus necesidades
            ),
          ),
        ),
      ],
    );
  }
}

class TextForm extends StatefulWidget {
  final String label;
  final TextInputType inputType;
  final String content;
  const TextForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.label,
    required this.inputType,
    required this.content,
  });
  @override
  _TextForm createState() => _TextForm();
}

class _TextForm extends State<TextForm> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.content;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: _controller,
          enabled: false,
          keyboardType: widget.inputType,
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            labelStyle: TextStyle(color: Colors.red),
          ),
          style: const TextStyle(color: Colors.black),
        ),
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String label;
  const CustomDropdown({super.key, required this.items, required this.label});

  @override
  CustomDropdownState createState() => CustomDropdownState();
}

class CustomDropdownState extends State<CustomDropdown> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 48,
                  color: Colors.white,
                  child: DropdownButtonFormField<String>(
                    value: _selectedItem,
                    dropdownColor: Colors.white,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 208, 208, 208),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 208, 208, 208),
                          width: 2.0,
                        ),
                      ),
                    ),
                    items: widget.items
                        .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: const TextStyle(fontSize: 12)),
                          ),
                        )
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedItem = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
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
              color: const Color.fromRGBO(20, 153, 74, 1), // Color del borde
              width: 3, // Grosor del borde
            ),
            color: const Color.fromRGBO(20, 153, 74, 1),
          ),
          child: const Center(
            child: Text(
              '¿Necesita actualizar dato(s)?',
              style: TextStyle(
                  color: Colors.white,
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
                    ? const Color.fromRGBO(160, 218, 183, 1)
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
                      ? const Color.fromARGB(255, 250, 162, 29)
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
                      ? const Color.fromRGBO(160, 218, 183, 1)
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
                    ? const Color.fromARGB(255, 250, 162, 29)
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
