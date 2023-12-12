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
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextForm extends StatelessWidget {
  const TextForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.label,
    required this.InputType,
  }) : _formKey = formKey;
  final String label;
  final TextInputType InputType;
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
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
