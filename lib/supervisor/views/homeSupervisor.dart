import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ruta_sdg/supervisor/widgets/menu_supervisor.dart';
import 'package:ruta_sdg/socio.dart';
import 'package:ruta_sdg/supervisor/widgets/menu_supervisor_mobile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ruta_sdg/api.dart';
//import 'package:tooltip/tooltip.dart';

class HomeSupervisorPage extends StatelessWidget {
  final String? idusuario;
  const HomeSupervisorPage({super.key, this.idusuario});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomeSupervisorPage(
          idusuario: idusuario), // Pasamos el idusuario aquí
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomeSupervisorPage extends StatefulWidget {
  final String? idusuario;
  const MyHomeSupervisorPage({super.key, this.idusuario});

  @override
  _MyHomeSupervisorPageState createState() => _MyHomeSupervisorPageState();
}

class _MyHomeSupervisorPageState extends State<MyHomeSupervisorPage>
    with SingleTickerProviderStateMixin {
  DateTime selectedDate = DateTime.now();
  bool isFloatingPageVisible = false;
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  int selectedPromotion = 0;
  int selectedAmpliation = 0;
  int selectedTracking = 0;
  int selectedRecovery = 0;
  String DistritoSeleccionado = "";
  String AnalistaSeleccionado = "";
  List<String> districts = [];
  List<Analista> analistas = [];
  List<Distrito> distritos = [];
  List<HojaRuta> SociosHojaRuta = [];
  Analista? selectedAnalista;
  Distrito? selectedDistrito;
  int? selectedNumber;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _fetchAnalistas();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: MediaQuery.of(context).size.width < 640
            ? const MenuSupervisorMobile(name: "PLAN DEL DÍA")
            : null,
        body: Stack(
          children: [
            Row(
              children: [
                if (MediaQuery.of(context).size.width >= 640)
                  const MenuSupervisor(name: "PLAN DEL DÍA"),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 25),
                          alignment: Alignment.center,
                          child: const Text(
                            'PLAN DEL DÍA',
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 76, 128),
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'HelveticaCondensed',
                            ),
                          ),
                        ),
                        // =================================== Fecha ===============================================
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  FontAwesomeIcons.calendarDay,
                                  color: Color.fromARGB(255, 0, 76, 128),
                                ),
                                onPressed: () {
                                  _selectDate(context);
                                },
                              ),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 0, 76, 128), // Color del borde
                                    width: 1.0, // Grosor del borde
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      5.0), // Borde redondeado de 5
                                ),
                                child: Text(
                                  DateFormat('dd/MM/yyyy').format(selectedDate),
                                  style: const TextStyle(
                                    color: Color.fromARGB(
                                        255, 0, 76, 128), // Color del texto
                                    fontFamily: 'HelveticaCondensed',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        // =================================== Seleccionador analista ===============================================
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildAnalistasDropdown(),
                          ],
                        ),
                        const SizedBox(height: 25.0),
                        // =================================== Seleccionadores distrito, num prom,ampl,seg,rec ===============================================

                        LayoutBuilder(
                          builder: (context, constraints) {
                            final screenWidth = constraints.maxWidth;

                            return screenWidth <= 1000
                                ? SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        _buildSquareWithIcon(
                                          FontAwesomeIcons.mapLocation,
                                          "Distrito",
                                          _buildDistrictSelector(),
                                          null,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        _buildSquareWithIcon(
                                          FontAwesomeIcons.bullhorn,
                                          "Promoción",
                                          _buildNumberSelector(
                                            selectedNumber: selectedPromotion,
                                            onChanged: (int? value) {
                                              setState(() {
                                                selectedPromotion = value ?? 0;
                                              });
                                            },
                                          ),
                                          null,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        _buildSquareWithIcon(
                                          FontAwesomeIcons.personCirclePlus,
                                          "Ampliación",
                                          _buildNumberSelector(
                                            selectedNumber: selectedAmpliation,
                                            onChanged: (int? value) {
                                              setState(() {
                                                selectedAmpliation = value ?? 0;
                                              });
                                            },
                                          ),
                                          null,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        _buildSquareWithIcon(
                                          FontAwesomeIcons.fileCircleCheck,
                                          "Seguimiento",
                                          _buildNumberSelector(
                                            selectedNumber: selectedTracking,
                                            onChanged: (int? value) {
                                              setState(() {
                                                selectedTracking = value ?? 0;
                                              });
                                            },
                                          ),
                                          null,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        _buildSquareWithIcon(
                                          FontAwesomeIcons.wallet,
                                          "Recuperación",
                                          _buildNumberSelector(
                                            selectedNumber: selectedRecovery,
                                            onChanged: (int? value) {
                                              setState(() {
                                                selectedRecovery = value ?? 0;
                                              });
                                            },
                                          ),
                                          null,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                _toggleFloatingPage();
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 0, 76, 128),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Icon(
                                                        FontAwesomeIcons
                                                            .userPlus,
                                                        color: Colors.white),
                                                    SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Text(
                                                      '  AÑADIR ',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'HelveticaCondensed',
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 15.0),
                                            GestureDetector(
                                              onTap: () {
                                                _fetchHojaRuta(
                                                    AnalistaSeleccionado,
                                                    DistritoSeleccionado,
                                                    selectedPromotion,
                                                    selectedAmpliation,
                                                    selectedTracking,
                                                    selectedRecovery);
                                                //print(SociosHojaRuta);
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 0, 76, 128),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Icon(
                                                        FontAwesomeIcons
                                                            .circleCheck,
                                                        color: Colors.white),
                                                    SizedBox(
                                                      width: 9.0,
                                                    ), // Espacio entre el icono y el texto
                                                    Text(
                                                      ' GENERAR',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'HelveticaCondensed',
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      _buildSquareWithIcon(
                                        FontAwesomeIcons.mapLocation,
                                        "Distrito",
                                        _buildDistrictSelector(),
                                        null,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      _buildSquareWithIcon(
                                        FontAwesomeIcons.bullhorn,
                                        "Promoción",
                                        _buildNumberSelector(
                                          selectedNumber: selectedPromotion,
                                          onChanged: (int? value) {
                                            setState(() {
                                              selectedPromotion = value ?? 0;
                                            });
                                          },
                                        ),
                                        null,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      _buildSquareWithIcon(
                                        FontAwesomeIcons.personCirclePlus,
                                        "Ampliación",
                                        _buildNumberSelector(
                                          selectedNumber: selectedAmpliation,
                                          onChanged: (int? value) {
                                            setState(() {
                                              selectedAmpliation = value ?? 0;
                                            });
                                          },
                                        ),
                                        null,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      _buildSquareWithIcon(
                                        FontAwesomeIcons.fileCircleCheck,
                                        "Seguimiento",
                                        _buildNumberSelector(
                                          selectedNumber: selectedTracking,
                                          onChanged: (int? value) {
                                            setState(() {
                                              selectedTracking = value ?? 0;
                                            });
                                          },
                                        ),
                                        null,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      _buildSquareWithIcon(
                                        FontAwesomeIcons.wallet,
                                        "Recuperación",
                                        _buildNumberSelector(
                                          selectedNumber: selectedRecovery,
                                          onChanged: (int? value) {
                                            setState(() {
                                              selectedRecovery = value ?? 0;
                                            });
                                          },
                                        ),
                                        null,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              _toggleFloatingPage();
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 0, 76, 128),
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              child: const Row(
                                                children: [
                                                  Icon(
                                                      FontAwesomeIcons.userPlus,
                                                      color: Colors.white),
                                                  SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Text(
                                                    '  AÑADIR ',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'HelveticaCondensed',
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 15.0),
                                          GestureDetector(
                                            onTap: () {
                                              _fetchHojaRuta(
                                                  AnalistaSeleccionado,
                                                  DistritoSeleccionado,
                                                  selectedPromotion,
                                                  selectedAmpliation,
                                                  selectedTracking,
                                                  selectedRecovery);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 0, 76, 128),
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              child: const Row(
                                                children: [
                                                  Icon(
                                                      FontAwesomeIcons
                                                          .circleCheck,
                                                      color: Colors.white),
                                                  SizedBox(
                                                    width: 9.0,
                                                  ), // Espacio entre el icono y el texto
                                                  Text(
                                                    ' GENERAR',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'HelveticaCondensed',
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                          },
                        ),
                        const SizedBox(height: 20.0),
                        // =================================== TABLA ===============================================
                        Center(
                          child: _buildDataTable(SociosHojaRuta),
                        ),
                        const SizedBox(height: 15.0),
                        // =================================== Boton Guardar ===============================================
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              // Aquí puedes agregar la lógica para generar
                              // Por ejemplo, puedes llamar a una función _handleGeneratePressed()
                            },
                            child: Container(
                              width: 130,
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 0, 76, 128),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: const Row(
                                children: [
                                  Icon(FontAwesomeIcons.floppyDisk,
                                      color: Colors.white),
                                  SizedBox(
                                    width: 9.0,
                                  ), // Espacio entre el icono y el texto
                                  Text(
                                    ' GUARDAR',
                                    style: TextStyle(
                                      fontFamily: 'HelveticaCondensed',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            /*if (isFloatingPageVisible)
              Stack(
                children: [
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        _toggleFloatingPage();
                      },
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                  Center(
                    child: SlideTransition(
                      position: _offsetAnimation,
                      child: SizedBox(
                        width: 550,
                        height: 800,
                        child: FloatingPage(
                          socioList: sociosNotAssignedToToday,
                          onPlusIconPressed: (Socio socio) {
                            _handlePlusIconPressed(socio);
                            _toggleFloatingPage();
                          },
                          onListsUpdated: (List<Socio> updatedSocios,
                              List<Socio> updatedFilteredSocios) {
                            setState(() {
                              sociosNotAssignedToToday = updatedSocios;
                            });
                          },
                          updateIsFloatingPageVisible: (bool value) {
                            setState(() {
                              isFloatingPageVisible =
                                  value; // Actualiza isFloatingPageVisible
                            });
                          }, // Pasar la función updateIsFloatingPageVisible
                        ),
                      ),
                    ),
                  ),
                ],
              ),*/
          ],
        ),
      ),
    );
  }

  // =================================== WIDGETS ===============================================
  Widget _buildAnalistasDropdown() {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.only(left: 25.0),
      width: 300,
      child: DropdownButtonFormField<Analista>(
        isExpanded: true,
        dropdownColor: Colors.white,
        focusColor: Colors.transparent,
        style: const TextStyle(
          fontSize: 13,
          fontFamily: 'HelveticaCondensed',
          color: Colors.black,
        ),
        items: analistas.map((Analista analista) {
          return DropdownMenuItem<Analista>(
            value: analista,
            child: Text(
              analista.analista,
              style: const TextStyle(
                fontSize: 13.0,
                fontFamily: 'HelveticaCondensed',
                color: Color.fromARGB(255, 0, 76, 128),
              ),
            ),
          );
        }).toList(),
        onChanged: (Analista? selectedAnalista) {
          if (selectedAnalista != null) {
            setState(() {
              this.selectedAnalista = selectedAnalista;
            });
            AnalistaSeleccionado = selectedAnalista.idusuario.toString();
            _fetchDistritos(selectedAnalista.idusuario.toString());
          }
        },
        decoration: const InputDecoration(
          labelText: 'Seleccionar Analista',
          contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
          labelStyle: TextStyle(
            fontSize: 15,
            fontFamily: 'HelveticaCondensed',
            color: Color.fromARGB(255, 0, 74, 125),
          ),
        ),
      ),
    );
  }

  Widget _buildSquareWithIcon(
    IconData icon,
    String text,
    Widget selector,
    Function(dynamic)? onChanged,
  ) {
    return Container(
      //padding: const EdgeInsets.all(1.0),
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      width: 170,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(255, 0, 76, 128),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: const Color.fromARGB(255, 0, 76, 128),
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 76, 128),
              fontSize: 15.0,
              fontFamily: 'HelveticaCondensed',
            ),
          ),
          const SizedBox(height: 5),
          selector,
        ],
      ),
    );
  }

  // Widget para construir el selector de distrito
  Widget _buildDistrictSelector() {
    return DropdownButtonFormField<Distrito>(
      isExpanded: true,
      dropdownColor: Colors.white,
      focusColor: Colors.transparent,
      value: selectedDistrito, // Establece el valor seleccionado
      items: distritos.map((Distrito descripcion) {
        return DropdownMenuItem<Distrito>(
          value: descripcion,
          child: Text(
            descripcion.descripcion,
            style: const TextStyle(
              fontSize: 13.0,
              fontFamily: 'HelveticaCondensed',
              color: Color.fromARGB(255, 0, 76, 128),
            ),
          ),
        );
      }).toList(),
      onChanged: (Distrito? selectedDistrito) {
        if (selectedDistrito != null) {
          setState(() {
            this.selectedDistrito = selectedDistrito;
          });
          DistritoSeleccionado = selectedDistrito.iddistrito.toString();
        }
      },
      hint: const Text(
        'Seleccionar Distrito',
        style: TextStyle(
          fontSize: 13.0,
          fontFamily: 'HelveticaCondensed',
          color: Color.fromARGB(255, 196, 196, 196),
        ),
      ),
    );
  }

  Widget _buildNumberSelector({
    required int selectedNumber,
    required ValueChanged<int?> onChanged,
  }) {
    return DropdownButton<int>(
      isExpanded: true,
      value: selectedNumber == 0
          ? 0
          : selectedNumber, // Si selectedNumber es 0, establece el valor en null
      items: List.generate(11, (index) {
        return DropdownMenuItem<int>(
          value: index,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 4.0), // Agrega un padding horizontal de 8.0
            child: Text(
              '$index',
              style: const TextStyle(
                color: Color.fromARGB(255, 0, 76, 128),
                fontSize: 13.0,
                fontFamily: 'HelveticaCondensed',
              ),
            ),
          ),
        );
      }),
      onChanged: onChanged,
      hint: const Text(
        'Seleccionar número',
        style: TextStyle(
          color: Color.fromARGB(255, 196, 196, 196),
          fontSize: 13.0,
          fontFamily: 'HelveticaCondensed',
        ),
      ),
    );
  }

  Widget _buildDataTable(List<HojaRuta> SociosHojaRuta) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFFD9DEDA), width: 2.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.white,
          elevation: 0,
          child: SizedBox(
            height: 350,
            width: 1000,
            child: SingleChildScrollView(
              child: DataTable(
                showCheckboxColumn: false,
                columnSpacing: 7.0,
                headingRowColor:
                    MaterialStateProperty.all(const Color(0xFFD9DEDA)),
                columns: const [
                  DataColumn(
                    label: Text(
                      'DNI',
                      style: TextStyle(
                        fontFamily: 'HelveticaCondensed',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'NOMBRE',
                      style: TextStyle(
                        fontFamily: 'HelveticaCondensed',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'DIRECCIÓN',
                      style: TextStyle(
                        fontFamily: 'HelveticaCondensed',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'MODALIDAD',
                      style: TextStyle(
                        fontFamily: 'HelveticaCondensed',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text('  '),
                  ),
                ],
                rows: SociosHojaRuta.map((socio) {
                  return DataRow(
                    /*onSelectChanged: (isSelected) {
                      if (isSelected != null && isSelected) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListaSupervisor(
                              tabName: "PLAN DEL DÍA",
                              socio: socio,
                            ),
                          ),
                        );
                      }
                    },*/
                    cells: [
                      DataCell(
                        Text(
                          socio.dni,
                          style: const TextStyle(
                            fontFamily: 'HelveticaCondensed',
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          socio.socio,
                          style: const TextStyle(
                            fontFamily: 'HelveticaCondensed',
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          socio.direccion,
                          style: const TextStyle(
                            fontFamily: 'HelveticaCondensed',
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          socio.modalidad,
                          style: const TextStyle(
                            fontFamily: 'HelveticaCondensed',
                          ),
                        ),
                      ),
                      DataCell(
                        IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.trash,
                            color: Color.fromARGB(255, 0, 76, 128),
                          ),
                          onPressed: () {
                            _handleTrashIconPressed(socio);
                          },
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =================================== APIS ===============================================
  Future<void> _fetchAnalistas() async {
    try {
      String token = await getToken();

      final url = Uri.parse(
          'https://wsdomingo.coopsantodomingo.com/laboratorio/creditos.php?codServicio=04');

      final headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
        'Accept': '*/*'
      };

      final body = {
        'idusuario': "12279",
        //'idusuario': widget.idusuario,
      };

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final List<dynamic>? jsonResponse = json.decode(response.body);

        if (jsonResponse != null) {
          setState(() {
            analistas =
                jsonResponse.map((json) => Analista.fromJson(json)).toList();
            selectedAnalista = analistas.isNotEmpty ? analistas.first : null;

            _fetchDistritos(selectedAnalista?.idusuario.toString() ?? '');
          });
        } else {
          _showErrorDialog('La respuesta de la API fue nula.');
        }
      } else {
        print(
            'Error al obtener los analistas. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _fetchDistritos(String idusuario) async {
    try {
      String token = await getToken();

      final url = Uri.parse(
          'https://wsdomingo.coopsantodomingo.com/laboratorio/creditos.php?codServicio=01');

      final headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
        'Accept': '*/*'
      };

      final body = {
        'idusuario': idusuario,
      };

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final List<dynamic>? jsonResponse = json.decode(response.body);

        if (jsonResponse != null) {
          setState(() {
            distritos =
                jsonResponse.map((json) => Distrito.fromJson(json)).toList();
            selectedDistrito = distritos.isNotEmpty ? null : null;
          });
        } else {
          _showErrorDialog('No existen datos de socios de este analista');
        }
      } else {
        print(
            'Error al obtener los distritos. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _fetchHojaRuta(
      String idusuario,
      String iddistrito,
      int selectedPromotion,
      int selectedAmpliation,
      int selectedTracking,
      int selectedRecovery) async {
    try {
      String token = await getToken();

      final url = Uri.parse(
          'https://wsdomingo.coopsantodomingo.com/laboratorio/creditos.php?codServicio=09');

      final headers = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
        'Accept': '*/*'
      };

      final body = {
        "idusuario": idusuario,
        "iddistrito": iddistrito,
        "cantidadPro": selectedPromotion,
        "cantidadAmp": selectedAmpliation,
        "cantidadSeg": selectedTracking,
        "cantiddRec": selectedRecovery,
      };

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final List<dynamic>? jsonResponse = json.decode(response.body);

        if (jsonResponse != null) {
          setState(() {
            SociosHojaRuta =
                jsonResponse.map((json) => HojaRuta.fromJson(json)).toList();
          });
        } else {
          _showErrorDialog('La respuesta de la API fue nula.');
        }
      } else {
        print(
            'Error al obtener la hoja de ruta. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

// =================================== VOID ===============================================
  void _handleTrashIconPressed(HojaRuta hojaRuta) {
    setState(() {
      SociosHojaRuta.removeWhere((socio) => socio == hojaRuta);
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            message,
            style: const TextStyle(
              fontSize: 14.0, // Tamaño de fuente
              color: Colors.black, // Color de texto
              fontFamily: 'HelveticaCondensed', // Tipo de letra
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Aceptar',
                style: TextStyle(
                  fontSize: 16.0, // Tamaño de fuente
                  color:
                      Color.fromARGB(255, 0, 74, 125), // Color de texto en azul
                  fontFamily: 'HelveticaCondensed',
                  fontWeight: FontWeight.bold, // Tipo de letra
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _handlePlusIconPressed(Socio socio) {
    setState(() {
      socio.assignedDate = DateTime(2024, 1, 8);
    });
    _toggleFloatingPage();
  }

  bool socioIsAssignedToToday(Socio socio) {
    // Lógica para verificar si el usuario está asignado a la fecha de hoy
    return socio.assignedDate != null &&
        socio.assignedDate!.toLocal().isAtSameMomentAs(selectedDate);
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color.fromARGB(255, 0, 76, 128),
            hintColor: const Color.fromARGB(255, 140, 178, 210),
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 0, 76, 128),
            ),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate!;
      });
    } else {
      pickedDate = DateTime.now();
      setState(() {
        selectedDate = pickedDate!;
      });
    }
  }

  void _toggleFloatingPage() {
    if (isFloatingPageVisible) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() {
      isFloatingPageVisible = !isFloatingPageVisible;
    });
  }
}

// =================================== CLASES ===============================================
class HojaRuta {
  final String dni;
  final String socio;
  final String direccion;
  final String idprestamo;
  final String modalidad;

  HojaRuta({
    required this.dni,
    required this.socio,
    required this.direccion,
    required this.idprestamo,
    required this.modalidad,
  });

  factory HojaRuta.fromJson(Map<String, dynamic> json) {
    return HojaRuta(
      dni: json['dni'],
      socio: json['socio'],
      direccion: json['direccion'],
      idprestamo: json['idprestamo'],
      modalidad: json['modalidad'],
    );
  }
}

class Distrito {
  final String iddistrito;
  final String descripcion;
  Distrito({
    required this.iddistrito,
    required this.descripcion,
  });

  factory Distrito.fromJson(Map<String, dynamic> json) {
    return Distrito(
      iddistrito: json['iddistrito'],
      descripcion: json['descripcion'],
    );
  }
}

class Analista {
  final String idusuario;
  final String analista;

  Analista({
    required this.idusuario,
    required this.analista,
  });

  factory Analista.fromJson(Map<String, dynamic> json) {
    return Analista(
      idusuario: json['idusuario'],
      analista: json['analista'],
    );
  }
}

class FloatingPage extends StatelessWidget {
  final List<Socio> socioList;
  final Function(Socio) onPlusIconPressed;
  final Function(List<Socio>, List<Socio>) onListsUpdated;
  final Function(bool) updateIsFloatingPageVisible;
  const FloatingPage({
    super.key,
    required this.socioList,
    required this.onPlusIconPressed,
    required this.onListsUpdated,
    required this.updateIsFloatingPageVisible,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        height: 800,
        width: 550,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40.0),
          border: Border.all(
            color: const Color.fromARGB(255, 0, 76, 128),
            width: 3.0,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 10.0, top: 10), // Espacio a la derecha del icono
                  child: IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.circleXmark,
                      color: Color.fromARGB(
                          255, 0, 76, 128), // Cambia el color del icono a azul
                    ),
                    onPressed: () {
                      updateIsFloatingPageVisible(false);
                    },
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 76, 128),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: const Text(
                '   LISTA DE SOCIOS   ',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'HelveticaCondensed',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            const TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  child: Text(
                    'General',
                    style: TextStyle(
                        fontFamily: 'HelveticaCondensed',
                        fontWeight:
                            FontWeight.bold // Establece la fuente Helvetica
                        ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Sugerencias',
                    style: TextStyle(
                        fontFamily: 'HelveticaCondensed',
                        fontWeight:
                            FontWeight.bold // Establece la fuente Helvetica
                        ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildGeneralTab(),
                  _buildSugerenciasTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralTab() {
    return SingleChildScrollView(
      child: SearchAndSocioList(
        socioList: socioList,
        onPlusIconPressed: onPlusIconPressed,
        onListsUpdated: onListsUpdated,
      ),
    );
  }

  Widget _buildSugerenciasTab() {
    return ListView.builder(
      itemCount: socioList.length,
      itemBuilder: (context, index) {
        final socio = socioList[index];
        return ListTile(
          title: Tooltip(
            message: 'Nombre: ${socio.name} ${socio.lastName}\n'
                'DNI: ${socio.dni}\n'
                'Celular: ${socio.cellphone}\n'
                'Email: ${socio.email}\n'
                'Dirección: ${socio.address}\n'
                'Distrito: ${socio.district}\n'
                'Provincia: ${socio.province}\n'
                'Región: ${socio.region}',
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            textStyle: const TextStyle(
              fontFamily: 'HelveticaCondensed',
              color: Colors.black,
            ),
            preferBelow: false,
            verticalOffset: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${socio.name} ${socio.lastName}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'HelveticaCondensed',
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Motivo: Cambio de ciudad',
                  style: TextStyle(
                    fontFamily: 'HelveticaCondensed',
                    fontSize: 14.0,
                    color: Color.fromARGB(255, 0, 76, 128),
                  ),
                ),
              ],
            ),
          ),
          trailing: IconButton(
            icon: const Icon(
              FontAwesomeIcons.plus,
              color: Color.fromARGB(255, 0, 76, 128),
            ),
            onPressed: () {
              onPlusIconPressed(socio);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${socio.name} añadido correctamente.',
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class SearchAndSocioList extends StatefulWidget {
  final List<Socio> socioList;
  final Function(Socio) onPlusIconPressed;
  final Function(List<Socio>, List<Socio>) onListsUpdated;

  const SearchAndSocioList({
    super.key,
    required this.socioList,
    required this.onPlusIconPressed,
    required this.onListsUpdated,
  });

  @override
  _SearchAndSocioListState createState() => _SearchAndSocioListState();
}

class _SearchAndSocioListState extends State<SearchAndSocioList> {
  late TextEditingController _searchController;
  List<Socio> filteredSocios = [];

  @override
  void initState() {
    super.initState();
    filteredSocios = widget.socioList;
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchChanged);
  }

  void _handlePlusIconPressed(Socio socio) {
    widget.onPlusIconPressed(socio);
  }

  void _onSearchChanged() {
    String searchText = _searchController.text.toLowerCase();
    setState(() {
      filteredSocios = widget.socioList.where((socio) {
        return socio.name.toLowerCase().contains(searchText) ||
            socio.lastName.toLowerCase().contains(searchText);
      }).toList();
    });

    // Devuelve las listas actualizadas a la clase principal
    widget.onListsUpdated(widget.socioList, filteredSocios);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Buscador
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: _searchController,
            style: const TextStyle(
                fontFamily: 'HelveticaCondensed',
                fontWeight:
                    FontWeight.bold // Establece la fuente Helvetica Condensed
                ),
            decoration: const InputDecoration(
              hintText: 'Buscar',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        // Lista de usuarios
        ListView.builder(
          shrinkWrap: true,
          itemCount: filteredSocios.length,
          itemBuilder: (context, index) {
            final socio = filteredSocios[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Tooltip(
                    message: 'Nombre: ${socio.name}${" "}${socio.lastName}\n'
                        'DNI: ${socio.dni}\n'
                        'Celular: ${socio.cellphone}\n'
                        'Email: ${socio.email}\n'
                        'Dirección: ${socio.address}\n'
                        'Distrito: ${socio.district}\n'
                        'Provincia: ${socio.province}\n'
                        'Región: ${socio.region}',
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      // Color de fondo del Tooltip
                    ),
                    textStyle: const TextStyle(
                      fontFamily: 'HelveticaCondensed',
                      color: Colors.black, // Color del texto dentro del Tooltip
                    ),
                    preferBelow: false,
                    verticalOffset:
                        20, // Ajusta la posición vertical del Tooltip

                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        '${socio.name} ${socio.lastName}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'HelveticaCondensed',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.plus,
                        color: Color.fromARGB(255, 0, 76, 128),
                      ),
                      onPressed: () {
                        _handlePlusIconPressed(socio);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${socio.name} añadido correctamente.',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
