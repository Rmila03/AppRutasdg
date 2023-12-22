import 'package:flutter/material.dart';
import 'package:ruta_sdg/user.dart';
import 'package:ruta_sdg/views/promocion.dart';

class PromotionForm extends StatefulWidget {
  final UserData user;
  const PromotionForm({super.key, required this.user});

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
              const TextFormResult(
                  label: "Pago Mensual:", InputType: TextInputType.number),
              const TextFormResult(
                  label: "Primera fecha de pago:",
                  InputType: TextInputType.datetime),
              const TextFormResult(
                  label: "Última fehca de pago",
                  InputType: TextInputType.datetime),
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
              const RadioButtonCustom(),
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
                                builder: (context) => const PromocionPage()),
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
                          color: Colors.black,
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

class TextFormResult extends StatelessWidget {
  final String label;
  final TextInputType InputType;
  const TextFormResult({
    super.key,
    required this.label,
    required this.InputType,
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
              keyboardType: InputType,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[300],
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
                border: OutlineInputBorder(
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
  final GlobalKey<FormState> _formKey;
  final String content;
  const TextForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.label,
    required this.inputType,
    required this.content,
  }) : _formKey = formKey;
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
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedButton = 1; // Primer botón seleccionado
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 40),
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), // Bordes redondeados
                border: Border.all(
                  color: Colors.green, // Color del borde
                  width: 2, // Grosor del borde
                ),
                color: selectedButton == 1 ? Colors.green : Colors.white,
              ),
              child: const Text(
                'SI',
                style: TextStyle(color: Colors.black, fontSize: 15),
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
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 40),
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), // Bordes redondeados
                border: Border.all(
                  color: Colors.orange, // Color del borde
                  width: 2, // Grosor del borde
                ),
                color: selectedButton == 2 ? Colors.orange : Colors.white,
              ),
              child: const Text(
                'NO',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
