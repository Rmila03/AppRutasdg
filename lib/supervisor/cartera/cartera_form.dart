import 'package:flutter/material.dart';
import 'package:ruta_sdg/supervisor/cartera/carterapage.dart';
import 'package:ruta_sdg/socio.dart';
//import 'package:ruta_sdg/widgets/promotion_form.dart';
import 'package:ruta_sdg/widgets/radio_button_custom.dart';

class CarteraForm extends StatefulWidget {
  final Socio socio;
  const CarteraForm({super.key, required this.socio});

  @override
  CarteraFormState createState() {
    return CarteraFormState();
  }
}

class CarteraFormState extends State<CarteraForm> {
  final _formKey = GlobalKey<FormState>();
  String selectedOption = '';
  bool vigenteSelected = true;
  bool vencidoSelected = false;
  int show = 0;
  int valorSeleccionado = 0;
  List<String> menuOptions = [
    'Crédito 1',
    'Crédito 2',
    'Crédito 3',
    'Crédito 4'
  ];
  @override
  Widget build(BuildContext context) {
    //List<Socio> socioAssingnedToToday = [];
    //List<Socio> socioNotAssingnedToToday = [];
    var container = Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButton<String>(
        value: selectedOption.isNotEmpty ? selectedOption : null,
        items: menuOptions.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontFamily: 'Unna-Bold',
              ),
            ),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            selectedOption = value ?? '';
          });
        },
        hint: const Text(
          'Seleccionar nro de crédito',
          style: TextStyle(
            color: Color.fromARGB(255, 196, 196, 196),
            fontSize: 15.0,
            fontFamily: 'Unna-Bold',
          ),
        ),
      ),
    );
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CarteraPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              const Expanded(
                child: Text(
                  "PERFIL DEL SOCIO",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 90),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "DATOS PERSONALES",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 0, 76, 128),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 10.0, left: 30),
                        margin: const EdgeInsets.only(bottom: 20, top: 15),
                        width: 900,
                        decoration: BoxDecoration(
                          //color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: const Color.fromARGB(255, 210, 210, 210),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 50),
                                    child: TextForm(
                                      formKey: _formKey,
                                      label: "Apellido Paterno",
                                      inputType: TextInputType.text,
                                      content: widget.socio.lastName,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 50),
                                    child: TextForm(
                                      formKey: _formKey,
                                      label: "Apellido Materno",
                                      inputType: TextInputType.text,
                                      content: widget.socio.lastName,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  /*Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    //color: Colors.white,
                                    borderRadius: BorderRadius.circular(50.0),
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 210, 210, 210),
                                    ),

                                    boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                  ),*/
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 50),
                                    child: TextForm(
                                      formKey: _formKey,
                                      label: "Nombres",
                                      inputType: TextInputType.text,
                                      content: widget.socio.name,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 50),
                                    child: Text(
                                      "Tipo de Documento : DNI",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 30),
                                    child: TextForm(
                                      formKey: _formKey,
                                      label: "Nro Documento",
                                      inputType: TextInputType.number,
                                      content: widget.socio.dni,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 30),
                                    child: TextForm(
                                      formKey: _formKey,
                                      label: "Sexo",
                                      inputType: TextInputType.number,
                                      content: widget.socio.sexo,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 30),
                                    child: TextForm(
                                      formKey: _formKey,
                                      label: "Edad",
                                      inputType: TextInputType.number,
                                      content: widget.socio.edad,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 50),
                                    child: TextForm(
                                      formKey: _formKey,
                                      label: "Fecha de Naciemiento",
                                      inputType: TextInputType.number,
                                      content: widget.socio.fechaNacimiento,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 400),
                              child: TextForm(
                                formKey: _formKey,
                                label: "Dirección",
                                inputType: TextInputType.text,
                                content: widget.socio.address,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 50),
                                    child: TextForm(
                                      formKey: _formKey,
                                      label: "Distrito",
                                      inputType: TextInputType.number,
                                      content: widget.socio.district,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 50),
                                    child: TextForm(
                                      formKey: _formKey,
                                      label: "Provincia",
                                      inputType: TextInputType.phone,
                                      content: widget.socio.province,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 50),
                                    child: TextForm(
                                      formKey: _formKey,
                                      label: "Departamento",
                                      inputType: TextInputType.none,
                                      content: widget.socio.region,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "DATOS DE CONTACTO",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 0, 76, 128),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 10.0, left: 30),
                        margin: const EdgeInsets.only(top: 15, bottom: 15),
                        width: 900,
                        decoration: BoxDecoration(
                          //color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: const Color.fromARGB(255, 210, 210, 210),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(right: 50),
                                  child: TextForm(
                                    formKey: _formKey,
                                    label: "Teléfono",
                                    inputType: TextInputType.phone,
                                    content: widget.socio.cellphone,
                                  ),
                                )),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 50),
                                    child: TextForm(
                                      formKey: _formKey,
                                      label: "Celular Personal  ",
                                      inputType: TextInputType.phone,
                                      content: widget.socio.cellphone,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 50,
                                    ),
                                    child: TextForm(
                                      formKey: _formKey,
                                      label: "Correo Electrónico",
                                      inputType: TextInputType.none,
                                      content: widget.socio.email,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "INFORMACIÓN DE CRÉDITO (S)",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 0, 76, 128),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      RadioButtonCustom(
                          option1: "Vigente",
                          option2: "Vencidos",
                          onValueChanged: (int newValue) {
                            setState(() {
                              valorSeleccionado = newValue;
                              show = newValue;
                            });
                          }),
                      Visibility(
                        visible: (show == 1),
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 10.0, left: 30),
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          width: 900,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 210, 210, 210),
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 50,
                                      ),
                                      child: TextForm(
                                        formKey: _formKey,
                                        label: "Riesgo del Socio",
                                        inputType: TextInputType.number,
                                        content: widget.socio.riesgoSocio,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 50,
                                      ),
                                      child: TextForm(
                                        formKey: _formKey,
                                        label: "Tipo de Socio",
                                        inputType: TextInputType.number,
                                        content: widget.socio.tipoSocio,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 50,
                                      ),
                                      child: TextForm(
                                        formKey: _formKey,
                                        label: "Tipo de Crédito",
                                        inputType: TextInputType.number,
                                        content: widget.socio.tipoCredito,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 50,
                                      ),
                                      child: TextForm(
                                        formKey: _formKey,
                                        label: "Tipo de Producto",
                                        inputType: TextInputType.number,
                                        content: widget.socio.tipoProducto,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 50,
                                      ),
                                      child: TextForm(
                                        formKey: _formKey,
                                        label: "Modalidad",
                                        inputType: TextInputType.number,
                                        content: widget.socio.modalidad,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 50,
                                      ),
                                      child: TextForm(
                                        formKey: _formKey,
                                        label: "Nombre de Prestamo",
                                        inputType: TextInputType.number,
                                        content: widget.socio.nombrePrestamo,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 50,
                                      ),
                                      child: TextForm(
                                          formKey: _formKey,
                                          label: "Crédito Total",
                                          inputType: TextInputType.number,
                                          content:
                                              "S/. ${widget.socio.creditoTotal}"),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 50,
                                      ),
                                      child: TextForm(
                                          formKey: _formKey,
                                          label: "Plazo ",
                                          inputType: TextInputType.number,
                                          content:
                                              "${widget.socio.plazo} meses"),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 50,
                                      ),
                                      child: TextForm(
                                          formKey: _formKey,
                                          label: "Tasa de Interés",
                                          inputType: TextInputType.number,
                                          content:
                                              "${widget.socio.tasaInteres} %"),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 50,
                                      ),
                                      child: TextForm(
                                          formKey: _formKey,
                                          label:
                                              "Fecha de Aprobación de Crédito",
                                          inputType: TextInputType.number,
                                          content:
                                              widget.socio.fechaAprobacion),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 50,
                                      ),
                                      child: TextForm(
                                          formKey: _formKey,
                                          label: "Primera Fecha de Pago",
                                          inputType: TextInputType.number,
                                          content: "10/01/2024 duda"),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 50,
                                      ),
                                      child: TextForm(
                                          formKey: _formKey,
                                          label: "Ultima Fecha de Pago",
                                          inputType: TextInputType.number,
                                          content:
                                              widget.socio.ultimaFechaPago),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 50,
                                      ),
                                      child: TextForm(
                                          formKey: _formKey,
                                          label: "Monto de la Cuota",
                                          inputType: TextInputType.number,
                                          content:
                                              "S/. ${widget.socio.montoCuota}"),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 50,
                                      ),
                                      child: TextForm(
                                          formKey: _formKey,
                                          label: "Saldo Vencido",
                                          inputType: TextInputType.number,
                                          content:
                                              "S/. ${widget.socio.saldoVencido}"),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 50,
                                      ),
                                      child: TextForm(
                                          formKey: _formKey,
                                          label: "Saldo de Crédito",
                                          inputType: TextInputType.number,
                                          content:
                                              "S/. ${widget.socio.saldoCredito}"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: (show == 2),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [container],
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 10.0, left: 30),
                              margin:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              width: 900,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 210, 210, 210),
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            right: 50,
                                          ),
                                          child: TextForm(
                                            formKey: _formKey,
                                            label: "Riesgo del Socio",
                                            inputType: TextInputType.number,
                                            content: widget.socio.riesgoSocio,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 50),
                                          child: TextForm(
                                            formKey: _formKey,
                                            label: "Tipo de Socio",
                                            inputType: TextInputType.number,
                                            content: widget.socio.tipoSocio,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 50),
                                          child: TextForm(
                                            formKey: _formKey,
                                            label: "Tipo de Crédito",
                                            inputType: TextInputType.number,
                                            content: widget.socio.tipoCredito,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 50),
                                          child: TextForm(
                                            formKey: _formKey,
                                            label: "Tipo de Producto",
                                            inputType: TextInputType.number,
                                            content: widget.socio.tipoProducto,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 50),
                                          child: TextForm(
                                            formKey: _formKey,
                                            label: "Modalidad",
                                            inputType: TextInputType.number,
                                            content: widget.socio.modalidad,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 50),
                                          child: TextForm(
                                            formKey: _formKey,
                                            label: "Nombre de Prestamo",
                                            inputType: TextInputType.number,
                                            content:
                                                widget.socio.nombrePrestamo,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 50),
                                          child: TextForm(
                                              formKey: _formKey,
                                              label: "Crédito Total",
                                              inputType: TextInputType.number,
                                              content:
                                                  widget.socio.creditoTotal),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 50),
                                          child: TextForm(
                                              formKey: _formKey,
                                              label: "Plazo (meses)",
                                              inputType: TextInputType.number,
                                              content: widget.socio.plazo),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 50),
                                          child: TextForm(
                                              formKey: _formKey,
                                              label: "Tasa de Interés",
                                              inputType: TextInputType.number,
                                              content:
                                                  widget.socio.tasaInteres),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 50),
                                          child: TextForm(
                                              formKey: _formKey,
                                              label:
                                                  "Fecha de Aprobación de Crédito",
                                              inputType: TextInputType.number,
                                              content:
                                                  widget.socio.fechaAprobacion),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 50),
                                          child: TextForm(
                                              formKey: _formKey,
                                              label: "Primera Fecha de Pago",
                                              inputType: TextInputType.number,
                                              content: "10/01/2024 dudaa"),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 50),
                                          child: TextForm(
                                              formKey: _formKey,
                                              label: "Ultima Fecha de Pago",
                                              inputType: TextInputType.number,
                                              content:
                                                  widget.socio.ultimaFechaPago),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 50),
                                          child: TextForm(
                                              formKey: _formKey,
                                              label: "Monto de la Cuota",
                                              inputType: TextInputType.number,
                                              content: widget.socio.montoCuota),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 50),
                                          child: TextForm(
                                              formKey: _formKey,
                                              label: "Saldo Vencido",
                                              inputType: TextInputType.number,
                                              content:
                                                  widget.socio.saldoVencido),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 50),
                                          child: TextForm(
                                              formKey: _formKey,
                                              label: "Saldo de Crédito",
                                              inputType: TextInputType.number,
                                              content:
                                                  widget.socio.saldoCredito),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      /*Container(
                        padding: const EdgeInsets.all(16.0),
                        margin: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 250, 250, 250),
                            border: Border.all(
                              color: const Color.fromARGB(255, 0, 76, 128),
                            ),
                            borderRadius: BorderRadius.circular(30.0)),
                        //width: 800,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextForm(
                                    formKey: _formKey,
                                    label: "Riesgo del Socio",
                                    inputType: TextInputType.number,
                                    content: "NORMAL",
                                  ),
                                ),
                                const SizedBox(width: 30),
                                Expanded(
                                  child: TextForm(
                                    formKey: _formKey,
                                    label: "Tipo de Socio",
                                    inputType: TextInputType.number,
                                    content: "RECURRENTE",
                                  ),
                                ),
                                const SizedBox(width: 30),
                                Expanded(
                                  child: TextForm(
                                    formKey: _formKey,
                                    label: "Tipo de Crédito",
                                    inputType: TextInputType.number,
                                    content: "GENÉRICO",
                                  ),
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
                                    content: "MYPE",
                                  ),
                                ),
                                const SizedBox(width: 30),
                                Expanded(
                                  child: TextForm(
                                    formKey: _formKey,
                                    label: "Modalidad",
                                    inputType: TextInputType.number,
                                    content: "COOPENAVIDEÑO",
                                  ),
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
                                      label: "Fecha de Aprobación de Crédito",
                                      inputType: TextInputType.number,
                                      content: "10/12/2023"),
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
                                      label: "Monto de la Cuota",
                                      inputType: TextInputType.number,
                                      content: "S/. 479.16"),
                                ),
                                const SizedBox(width: 30),
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
                          ],
                        ),
                      ),*/
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
