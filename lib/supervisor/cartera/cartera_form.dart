import 'package:flutter/material.dart';
import 'package:ruta_sdg/supervisor/cartera/carterapage.dart';
import 'package:ruta_sdg/user.dart';

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
      Expanded(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Text(
                        "PERFIL DEL SOCIO",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
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
                          label: "Correo Electrónico",
                          inputType: TextInputType.none,
                          content: widget.user.email,
                        ),
                      ),
                    ],
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
                  Row(
                    children: [
                      Expanded(
                        child: TextForm(
                            formKey: _formKey,
                            label: "Crédito",
                            inputType: TextInputType.number,
                            content: "------"),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: TextForm(
                            formKey: _formKey,
                            label: "Vigente",
                            inputType: TextInputType.number,
                            content: "o"),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: TextForm(
                            formKey: _formKey,
                            label: "Candelado",
                            inputType: TextInputType.number,
                            content: "o"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextForm(
                            formKey: _formKey,
                            label: "Riesgo del Socio",
                            inputType: TextInputType.number,
                            content: "NORMAL"),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: TextForm(
                            formKey: _formKey,
                            label: "Tipo de Socio",
                            inputType: TextInputType.number,
                            content: "RECURRENTE"),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: TextForm(
                            formKey: _formKey,
                            label: "Tipo de Crédito",
                            inputType: TextInputType.number,
                            content: "GENÉRICO"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextForm(
                            formKey: _formKey,
                            label: "Tipo de Producto",
                            inputType: TextInputType.number,
                            content: "MYPE"),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: TextForm(
                            formKey: _formKey,
                            label: "Modalidad",
                            inputType: TextInputType.number,
                            content: "COOPENAVIDEÑO"),
                      ),
                      const SizedBox(width: 30),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextForm(
                            formKey: _formKey,
                            label: "Crédito Total",
                            inputType: TextInputType.number,
                            content: "S/. 10 000"),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: TextForm(
                            formKey: _formKey,
                            label: "Plazo (meses)",
                            inputType: TextInputType.number,
                            content: "24"),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: TextForm(
                            formKey: _formKey,
                            label: "Tasa de Interés",
                            inputType: TextInputType.number,
                            content: "8.83 %"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextForm(
                            formKey: _formKey,
                            label: "Monto de la Cuota",
                            inputType: TextInputType.number,
                            content: "S/. 479.16"),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: TextForm(
                            formKey: _formKey,
                            label: "Primera Fecha de Pago",
                            inputType: TextInputType.number,
                            content: "10/01/2024"),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: TextForm(
                            formKey: _formKey,
                            label: "Ultima Fecha de Pago",
                            inputType: TextInputType.number,
                            content: "10/01/2026"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextForm(
                            formKey: _formKey,
                            label: "Saldo Vencido",
                            inputType: TextInputType.number,
                            content: "S/. 0"),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: TextForm(
                            formKey: _formKey,
                            label: "Saldo de Crédito",
                            inputType: TextInputType.number,
                            content: "S/. 10 000"),
                      ),
                    ],
                  ),
                  const SizedBox(width: 30),
                  Center(
                    child: Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
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
                                horizontal: 10, vertical: 10),
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
          decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 102, 102, 102)),
            ),
          ),
          style: const TextStyle(color: Colors.black),
        ),
        Text(
          widget.label,
          style: const TextStyle(
              fontSize: 12, color: Color.fromARGB(255, 102, 102, 102)),
        ),
      ],
    );
  }
}
