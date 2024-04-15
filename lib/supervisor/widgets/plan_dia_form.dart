import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:ruta_sdg/supervisor/views/carterapage.dart';
import 'package:ruta_sdg/socio.dart';
import 'package:ruta_sdg/supervisor/views/homeSupervisor.dart';
import 'package:ruta_sdg/supervisor/widgets/custom_supervisor.dart';
import 'package:ruta_sdg/supervisor/widgets/radio_button_custom.dart';

class PlanDiaSupervisor extends StatefulWidget {
  final Socio socio;
  const PlanDiaSupervisor({super.key, required this.socio});

  @override
  CarteraFormState createState() {
    return CarteraFormState();
  }
}

class CarteraFormState extends State<PlanDiaSupervisor> {
  final _formKey = GlobalKey<FormState>();

  bool vigenteSelected = true;
  bool vencidoSelected = false;
  int show = 0;
  int valorSeleccionado = 0;

  @override
  Widget build(BuildContext context) {
    //List<Socio> socioAssingnedToToday = [];
    //List<Socio> socioNotAssingnedToToday = [];
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const HomeSupervisorPage(),
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
                        fontFamily: "HelveticaCondensed",
                        fontSize: 25,
                        color: Color.fromARGB(255, 0, 76, 128),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          width: 900,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(244, 244, 244, 1),
                                    borderRadius: BorderRadius.circular(20),
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
                                          "DATOS PERSONALES",
                                          style: TextStyle(
                                              fontFamily: "HelveticaCondensed",
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 0, 76, 128),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 50),
                                                  child: TextFormSupervisor(
                                                    formKey: _formKey,
                                                    label: "Apellidos",
                                                    inputType:
                                                        TextInputType.text,
                                                    content:
                                                        widget.socio.lastName,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 50),
                                                  child: TextFormSupervisor(
                                                    formKey: _formKey,
                                                    label: "Nombres",
                                                    inputType:
                                                        TextInputType.text,
                                                    content: widget.socio.name,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 30),
                                                  child: TextFormSupervisor(
                                                    formKey: _formKey,
                                                    label: "Nro Documento",
                                                    inputType:
                                                        TextInputType.number,
                                                    content: widget.socio.dni,
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
                                                    right: 50),
                                                child: TextFormSupervisor(
                                                  formKey: _formKey,
                                                  label: "Teléfono",
                                                  inputType:
                                                      TextInputType.phone,
                                                  content:
                                                      widget.socio.cellphone,
                                                ),
                                              )),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 50),
                                                  child: TextFormSupervisor(
                                                    formKey: _formKey,
                                                    label: "Celular Personal  ",
                                                    inputType:
                                                        TextInputType.phone,
                                                    content:
                                                        widget.socio.cellphone,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    right: 30,
                                                  ),
                                                  child: TextFormSupervisor(
                                                    formKey: _formKey,
                                                    label: "Riesgo socio",
                                                    inputType:
                                                        TextInputType.none,
                                                    content: widget
                                                        .socio.riesgoSocio,
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
                                                      const EdgeInsets.only(
                                                          right: 20),
                                                  child: TextFormSupervisor(
                                                    formKey: _formKey,
                                                    label: "Dirección",
                                                    inputType:
                                                        TextInputType.text,
                                                    content:
                                                        widget.socio.address,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 30),
                                                  child: TextFormSupervisor(
                                                    formKey: _formKey,
                                                    label: "Correo electrónico",
                                                    inputType:
                                                        TextInputType.text,
                                                    content: widget.socio.email,
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
                                                      const EdgeInsets.only(
                                                          right: 50),
                                                  child: TextFormSupervisor(
                                                    formKey: _formKey,
                                                    label: "Distrito",
                                                    inputType:
                                                        TextInputType.number,
                                                    content:
                                                        widget.socio.district,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 50),
                                                  child: TextFormSupervisor(
                                                    formKey: _formKey,
                                                    label: "Provincia",
                                                    inputType:
                                                        TextInputType.phone,
                                                    content:
                                                        widget.socio.province,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 30),
                                                  child: TextFormSupervisor(
                                                    formKey: _formKey,
                                                    label: "Departamento",
                                                    inputType:
                                                        TextInputType.none,
                                                    content:
                                                        widget.socio.region,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(244, 244, 244, 1),
                                    borderRadius: BorderRadius.circular(20),
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
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "INFORMACIÓN DE CRÉDITO (S)",
                                            style: TextStyle(
                                                fontFamily:
                                                    "HelveticaCondensed",
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 0, 76, 128),
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
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 50,
                                                    ),
                                                    child: TextFormSupervisor(
                                                      formKey: _formKey,
                                                      label: "Riesgo del Socio",
                                                      inputType:
                                                          TextInputType.number,
                                                      content: widget
                                                          .socio.riesgoSocio,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 50,
                                                    ),
                                                    child: TextFormSupervisor(
                                                      formKey: _formKey,
                                                      label: "Tipo de Socio",
                                                      inputType:
                                                          TextInputType.number,
                                                      content: widget
                                                          .socio.tipoSocio,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 50,
                                                    ),
                                                    child: TextFormSupervisor(
                                                      formKey: _formKey,
                                                      label: "Tipo de Crédito",
                                                      inputType:
                                                          TextInputType.number,
                                                      content: widget
                                                          .socio.tipoCredito,
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
                                                        const EdgeInsets.only(
                                                      right: 50,
                                                    ),
                                                    child: TextFormSupervisor(
                                                      formKey: _formKey,
                                                      label: "Tipo de Producto",
                                                      inputType:
                                                          TextInputType.number,
                                                      content: widget
                                                          .socio.tipoProducto,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 50,
                                                    ),
                                                    child: TextFormSupervisor(
                                                      formKey: _formKey,
                                                      label: "Modalidad",
                                                      inputType:
                                                          TextInputType.number,
                                                      content: widget
                                                          .socio.modalidad,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 50,
                                                    ),
                                                    child: TextFormSupervisor(
                                                      formKey: _formKey,
                                                      label:
                                                          "Nombre de Prestamo",
                                                      inputType:
                                                          TextInputType.number,
                                                      content: widget
                                                          .socio.nombrePrestamo,
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
                                                        const EdgeInsets.only(
                                                      right: 50,
                                                    ),
                                                    child: TextFormSupervisor(
                                                        formKey: _formKey,
                                                        label: "Crédito Total",
                                                        inputType: TextInputType
                                                            .number,
                                                        content:
                                                            "S/. ${widget.socio.creditoTotal}"),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 50,
                                                    ),
                                                    child: TextFormSupervisor(
                                                        formKey: _formKey,
                                                        label: "Plazo ",
                                                        inputType: TextInputType
                                                            .number,
                                                        content:
                                                            "${widget.socio.plazo} meses"),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 50,
                                                    ),
                                                    child: TextFormSupervisor(
                                                        formKey: _formKey,
                                                        label:
                                                            "Tasa de Interés",
                                                        inputType: TextInputType
                                                            .number,
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 50,
                                                    ),
                                                    child: TextFormSupervisor(
                                                        formKey: _formKey,
                                                        label:
                                                            "Fecha de Aprobación de Crédito",
                                                        inputType: TextInputType
                                                            .number,
                                                        content: widget.socio
                                                            .fechaAprobacion),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 50,
                                                    ),
                                                    child: TextFormSupervisor(
                                                        formKey: _formKey,
                                                        label:
                                                            "Primera Fecha de Pago",
                                                        inputType: TextInputType
                                                            .number,
                                                        content:
                                                            "10/01/2024 duda"),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 50,
                                                    ),
                                                    child: TextFormSupervisor(
                                                        formKey: _formKey,
                                                        label:
                                                            "Ultima Fecha de Pago",
                                                        inputType: TextInputType
                                                            .number,
                                                        content: widget.socio
                                                            .ultimaFechaPago),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 50,
                                                    ),
                                                    child: TextFormSupervisor(
                                                        formKey: _formKey,
                                                        label:
                                                            "Monto de la Cuota",
                                                        inputType: TextInputType
                                                            .number,
                                                        content:
                                                            "S/. ${widget.socio.montoCuota}"),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 50,
                                                    ),
                                                    child: TextFormSupervisor(
                                                        formKey: _formKey,
                                                        label: "Saldo Vencido",
                                                        inputType: TextInputType
                                                            .number,
                                                        content:
                                                            "S/. ${widget.socio.saldoVencido}"),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 50,
                                                    ),
                                                    child: TextFormSupervisor(
                                                        formKey: _formKey,
                                                        label:
                                                            "Saldo de Crédito",
                                                        inputType: TextInputType
                                                            .number,
                                                        content:
                                                            "S/. ${widget.socio.saldoCredito}"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: (show == 2),
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0,
                                                  bottom: 10.0,
                                                  left: 30),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0),
                                              width: 900,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255, 210, 210, 210),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            right: 50,
                                                          ),
                                                          child: TextForm(
                                                            formKey: _formKey,
                                                            label:
                                                                "Riesgo del Socio",
                                                            inputType:
                                                                TextInputType
                                                                    .number,
                                                            content: widget
                                                                .socio
                                                                .riesgoSocio,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 50),
                                                          child: TextForm(
                                                            formKey: _formKey,
                                                            label:
                                                                "Tipo de Socio",
                                                            inputType:
                                                                TextInputType
                                                                    .number,
                                                            content: widget
                                                                .socio
                                                                .tipoSocio,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 50),
                                                          child: TextForm(
                                                            formKey: _formKey,
                                                            label:
                                                                "Tipo de Crédito",
                                                            inputType:
                                                                TextInputType
                                                                    .number,
                                                            content: widget
                                                                .socio
                                                                .tipoCredito,
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
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 50),
                                                          child: TextForm(
                                                            formKey: _formKey,
                                                            label:
                                                                "Tipo de Producto",
                                                            inputType:
                                                                TextInputType
                                                                    .number,
                                                            content: widget
                                                                .socio
                                                                .tipoProducto,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 50),
                                                          child: TextForm(
                                                            formKey: _formKey,
                                                            label: "Modalidad",
                                                            inputType:
                                                                TextInputType
                                                                    .number,
                                                            content: widget
                                                                .socio
                                                                .modalidad,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 50),
                                                          child: TextForm(
                                                            formKey: _formKey,
                                                            label:
                                                                "Nombre de Prestamo",
                                                            inputType:
                                                                TextInputType
                                                                    .number,
                                                            content: widget
                                                                .socio
                                                                .nombrePrestamo,
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
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 50),
                                                          child: TextForm(
                                                              formKey: _formKey,
                                                              label:
                                                                  "Crédito Total",
                                                              inputType:
                                                                  TextInputType
                                                                      .number,
                                                              content: widget
                                                                  .socio
                                                                  .creditoTotal),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 50),
                                                          child: TextForm(
                                                              formKey: _formKey,
                                                              label:
                                                                  "Plazo (meses)",
                                                              inputType:
                                                                  TextInputType
                                                                      .number,
                                                              content: widget
                                                                  .socio.plazo),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 50),
                                                          child: TextForm(
                                                              formKey: _formKey,
                                                              label:
                                                                  "Tasa de Interés",
                                                              inputType:
                                                                  TextInputType
                                                                      .number,
                                                              content: widget
                                                                  .socio
                                                                  .tasaInteres),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 50),
                                                          child: TextForm(
                                                              formKey: _formKey,
                                                              label:
                                                                  "Fecha de Aprobación de Crédito",
                                                              inputType:
                                                                  TextInputType
                                                                      .number,
                                                              content: widget
                                                                  .socio
                                                                  .fechaAprobacion),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 50),
                                                          child: TextForm(
                                                              formKey: _formKey,
                                                              label:
                                                                  "Primera Fecha de Pago",
                                                              inputType:
                                                                  TextInputType
                                                                      .number,
                                                              content:
                                                                  "10/01/2024 dudaa"),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 50),
                                                          child: TextForm(
                                                              formKey: _formKey,
                                                              label:
                                                                  "Ultima Fecha de Pago",
                                                              inputType:
                                                                  TextInputType
                                                                      .number,
                                                              content: widget
                                                                  .socio
                                                                  .ultimaFechaPago),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 50),
                                                          child: TextForm(
                                                              formKey: _formKey,
                                                              label:
                                                                  "Monto de la Cuota",
                                                              inputType:
                                                                  TextInputType
                                                                      .number,
                                                              content: widget
                                                                  .socio
                                                                  .montoCuota),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 50),
                                                          child: TextForm(
                                                              formKey: _formKey,
                                                              label:
                                                                  "Saldo Vencido",
                                                              inputType:
                                                                  TextInputType
                                                                      .number,
                                                              content: widget
                                                                  .socio
                                                                  .saldoVencido),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 50),
                                                          child: TextForm(
                                                              formKey: _formKey,
                                                              label:
                                                                  "Saldo de Crédito",
                                                              inputType:
                                                                  TextInputType
                                                                      .number,
                                                              content: widget
                                                                  .socio
                                                                  .saldoCredito),
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
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
        SizedBox(
          height: 40,
          child: TextFormField(
            controller: _controller,
            enabled: false,
            keyboardType: widget.inputType,
            cursorColor: const Color.fromARGB(255, 0, 76, 128),
            style: const TextStyle(
                fontFamily: "HelveticaCondensed", color: Colors.black),
          ),
        ),
        Text(
          widget.label,
          style: const TextStyle(
            fontFamily: "HelveticaCondensed",
            fontSize: 13,
            color: Color.fromARGB(255, 0, 76, 128),
          ),
        ),
      ],
    );
  }
}
