import 'package:flutter/material.dart';
import 'package:ruta_sdg/user.dart';
import 'package:ruta_sdg/views/recuperacion.dart';
import 'package:ruta_sdg/widgets/radio_button_custom.dart';
import 'package:ruta_sdg/widgets/text_form_result.dart';

class RecuperacionForm extends StatefulWidget {
  final UserData user;
  const RecuperacionForm({super.key, required this.user});

  @override
  RecuperacionFormState createState() {
    return RecuperacionFormState();
  }
}

class RecuperacionFormState extends State<RecuperacionForm> {
  final _formKey = GlobalKey<FormState>();
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
              TextForm(
                formKey: _formKey,
                label: "Nombres",
                inputType: TextInputType.text,
                content: widget.user.name,
              ),
              TextForm(
                formKey: _formKey,
                label: "Apellido Paterno",
                inputType: TextInputType.text,
                content: widget.user.lastName,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextForm(
                      formKey: _formKey,
                      label: "DNI",
                      inputType: TextInputType.number,
                      content: widget.user.dni,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: TextForm(
                      formKey: _formKey,
                      label: "Celular",
                      inputType: TextInputType.phone,
                      content: widget.user.cellphone,
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
                content: widget.user.email,
              ),
              TextForm(
                formKey: _formKey,
                label: "Dirección",
                inputType: TextInputType.text,
                content: widget.user.address,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextForm(
                      formKey: _formKey,
                      label: "Distrito",
                      inputType: TextInputType.number,
                      content: widget.user.district,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: TextForm(
                      formKey: _formKey,
                      label: "Provincia",
                      inputType: TextInputType.phone,
                      content: widget.user.province,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: TextForm(
                      formKey: _formKey,
                      label: "Departamento",
                      inputType: TextInputType.none,
                      content: widget.user.region,
                    ),
                  ),
                ],
              ),
              //DropdownButtonFormField(items: , onChanged: onChanged),
              const TextFormResult(
                label: "Tipo de Socio:",
                content: "CAMPAÑA",
              ),
              const TextFormResult(
                label: "Tipo de Crédito:",
                content: "CONSUMO",
              ),
              const TextFormResult(
                label: "Tipo de Producto:",
                content: "INDEPENDIENTE",
              ),
              const TextFormResult(
                label: "Modalidad:",
                content: "COOPENAVIDEÑO",
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Cálculo de Crédito",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 0, 76, 128),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Expanded(
                    child: InputTextForm(
                      label: "Crédito total",
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        width: 20,
                        height: 5,
                        color: Colors.amber,
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                      ),
                    ),
                  )
                ],
              ),
              const Row(
                children: [
                  Expanded(
                    child: InputTextForm(
                      label: "Plazo(meses)",
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: InputTextForm(
                        label: "Tasa de interés(%)",
                        percentage: "%",
                      ),
                    ),
                  ),
                ],
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Cálculo",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const TextFormResult(
                label: "Pago Mensual:",
                content: "CAMPAÑA",
              ),
              const TextFormResult(
                label: "Primera fecha de pago:",
                content: "CAMPAÑA",
              ),
              const TextFormResult(
                label: "Última fehca de pago",
                content: "CAMPAÑA",
              ),
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "N° Visitas: 3",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Column(
                          children: [
                            TextFormResult(
                                label: "Crédito", content: "S/. 10000.00"),
                            TextFormResult(
                                label: "Monto a pagar",
                                content: "S/. 1150.53.00"),
                            TextFormResult(
                                label: "Cuota a Pagar", content: "8"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.grey[300],
                            ),
                            child: const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.insert_drive_file_rounded,
                                    size: 60, color: Colors.black),
                                SizedBox(height: 5),
                                Text(
                                  'Mas detalles',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
<<<<<<< HEAD
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            shape: const RoundedRectangleBorder(
                              side: BorderSide.none, // Borde transparente
                              borderRadius: BorderRadius.zero, // Bordes cero
                            ),
                          ),
                          child: const Text(
                            'Ver más',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Visibility(
                visible: (show == 1),
                child: const Column(
                  children: [
                    Text(
                      'COMPROMISO DE PAGO',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 76, 128),
                          fontSize: 17,
                          fontWeight: FontWeight.w900),
                    ),
                    TextFormResult(label: "Fecha de Cancelación", content: ""),
                    TextFormResult(label: "Método de pago:", content: ""),
                  ],
                ),
              ),
              Visibility(
                visible: (show == 2),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(10), // Bordes redondeados
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                  0.2), // Color y opacidad de la sombra
                              offset: const Offset(
                                  0, 2), // Desplazamiento de la sombra
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
=======
                      child: const Text(
                        'GUARDAR',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 0, 76, 128),
                          fontWeight: FontWeight.bold,
>>>>>>> f6103fed3ba8ad3a4136855731db98aa209a8e03
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
              ),

              const SizedBox(height: 20),
              Visibility(
                visible: (show != 0),
                child: Row(
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
                                  builder: (context) =>
                                      const RecuperacionPage()),
                            );
                          }
                        },
                        style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
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
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
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
  _TextForm createState() => _TextForm();
}

class _TextForm extends State<TextForm> {
  TextEditingController _controller = TextEditingController();

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
  const CustomDropdown({Key? key, required this.items, required this.label})
      : super(key: key);

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
