import 'package:flutter/material.dart';

class PromotionForm extends StatefulWidget {
  const PromotionForm({super.key});

  @override
  PromotionFormState createState() {
    return PromotionFormState();
  }
}

class PromotionFormState extends State<PromotionForm> {
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
              //DropdownButtonFormField(items: , onChanged: onChanged),
              const CustomDropdown(
                items: ['', 'Socio 1', 'Socio 2', 'Socio 3'],
                label: "Tipo de Socio:",
              ),
              const CustomDropdown(
                items: ['', 'Crédito 1', 'Crédito 2', 'Crédito 3'],
                label: "Tipo de Crédito:",
              ),
              const CustomDropdown(
                items: ['', 'Producto 1', 'Producto 2', 'Producto 3'],
                label: "Tipo de Producto:",
              ),
              const CustomDropdown(
                items: ['', 'Modalidad 1', 'Modalidad 2', 'Modalidad 3'],
                label: "Modalidad:",
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
              const TextFormResult(label: "Pago Mensual:"),
              const TextFormResult(label: "Primera fecha de pago:"),
              const TextFormResult(label: "Última fehca de pago"),
              ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFormResult extends StatelessWidget {
  final String label;
  const TextFormResult({
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
            width: 150,
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
                // Puedes añadir más propiedades de estilo según tus necesidades
              ),
            ),
          ),
        ],
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
              border: OutlineInputBorder(
                // Borde personalizado
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
        TextFormField(
          keyboardType: InputType,
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
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
            width: 140,
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
                            child: Text(value),
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
