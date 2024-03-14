import 'package:flutter/material.dart';
import 'package:ruta_sdg/socio.dart';
import 'package:ruta_sdg/views/promocion.dart';
import 'package:ruta_sdg/widgets/custom_dropdown.dart';
import 'package:ruta_sdg/widgets/text_form_result.dart';

class PromotionForm extends StatefulWidget {
  final Socio socio;
  const PromotionForm({super.key, required this.socio});

  @override
  PromotionFormState createState() {
    return PromotionFormState();
  }
}

class PromotionFormState extends State<PromotionForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isSelected = false;
  bool checkVisible = false;
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
                            builder: (context) => const PromocionPage()),
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
