import 'package:flutter/material.dart';
import 'package:ruta_sdg/supervisor/cartera/carterapage.dart';
import 'package:ruta_sdg/user.dart';
import 'package:ruta_sdg/widgets/menu_supervisor.dart';
import 'package:ruta_sdg/widgets/text_form_result.dart';

class CarteraForm extends StatefulWidget {
  final UserData user;
  const CarteraForm({super.key, required this.user});

  @override
  CarteraFormState createState() {
    return CarteraFormState();
  }
}

class CarteraFormState extends State<CarteraForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 600, // Puedes ajustar este valor según tus necesidades
        child: const MenuSupervisor(name: "CARTERA"),
      ),
      Expanded(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(children: [
                    Expanded(
                      child: TextForm(
                        formKey: _formKey,
                        label: "Nombres",
                        inputType: TextInputType.text,
                        content: widget.user.name,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: TextForm(
                        formKey: _formKey,
                        label: "Apellidos",
                        inputType: TextInputType.text,
                        content: widget.user.lastName,
                      ),
                    )
                  ]),
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
                      label: "Pago Mensual:", content: "s/. 120.50"),
                  const TextFormResult(
                    label: "Primera fecha de pago:",
                    content: "12/02/2023",
                  ),
                  const TextFormResult(
                      label: "Última fehca de pago", content: "12/02/2024"),
                  const SizedBox(height: 20),
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
                                    builder: (context) => const CarteraPage()),
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
                            'REGRESAR',
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
        ),
      ),
    ]);
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
            textAlign: TextAlign.center,
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
