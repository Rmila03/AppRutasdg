import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ruta_sdg/supervisor/listacartera.dart';
import 'package:ruta_sdg/widgets/menu_supervisor.dart';
import 'package:ruta_sdg/socio.dart';
import 'package:ruta_sdg/analista.dart';
import 'package:ruta_sdg/widgets/menu_supervisor_mobile.dart';
//import 'package:tooltip/tooltip.dart';

void main() {
  runApp(const HomeSupervisorPage());
}

class HomeSupervisorPage extends StatelessWidget {
  const HomeSupervisorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomeSupervisorPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomeSupervisorPage extends StatefulWidget {
  const MyHomeSupervisorPage({super.key});

  @override
  _MyHomeSupervisorPageState createState() => _MyHomeSupervisorPageState();
}

class _MyHomeSupervisorPageState extends State<MyHomeSupervisorPage>
    with SingleTickerProviderStateMixin {
  String selectedOption = '';
  DateTime selectedDate = DateTime.now();
  List<Analista> analistas = getAnalistas();
  List<String> menuOptions = [];
  final List<Socio> socios = getSocios();
  bool isFloatingPageVisible = false;
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  List<String> districts = [
    'District 1',
    'District 2',
    'District 3'
  ]; // Example districts list
  final List<String> numbers =
      List.generate(11, (index) => (index).toString()); // Numbers from 1 to 10
  int selectedPromotion = 0;
  int selectedAmpliation = 0;
  int selectedTracking = 0;
  int selectedRecovery = 0;
  String selectedDistrict = '';
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
  }

  @override
  Widget build(BuildContext context) {
    List<Socio> sociosAssignedToToday = [];
    List<Socio> sociosNotAssignedToToday = [];
    var container = Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.only(left: 25.0),
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: selectedOption.isNotEmpty ? selectedOption : null,
        items: analistas.map((Analista analista) {
          return DropdownMenuItem<String>(
            value: analista.idAnalista,
            child: Text(
              '${analista.name} ${analista.lastName}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontFamily: 'HelveticaCondensed',
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
          'Seleccionar analista',
          style: TextStyle(
            color: Color.fromARGB(255, 196, 196, 196),
            fontSize: 15.0,
            fontFamily: 'HelveticaCondensed',
          ),
        ),
      ),
    );

    List<String> selectedSociosIds = [];

    switch (selectedOption) {
      case '1':
        selectedSociosIds = SociosPorAnalista(analistaId: '1', socios: socios);
        break;
      case '2':
        selectedSociosIds = SociosPorAnalista(analistaId: '2', socios: socios);
        break;
      case '3':
        selectedSociosIds = SociosPorAnalista(analistaId: '3', socios: socios);
        break;
      case '4':
        selectedSociosIds = SociosPorAnalista(analistaId: '4', socios: socios);
        break;
      case '5':
        selectedSociosIds = SociosPorAnalista(analistaId: '5', socios: socios);
        break;
      case '6':
        selectedSociosIds = SociosPorAnalista(analistaId: '6', socios: socios);
        break;
      case '7':
        selectedSociosIds = SociosPorAnalista(analistaId: '7', socios: socios);
        break;
      case '8':
        selectedSociosIds = SociosPorAnalista(analistaId: '8', socios: socios);
        break;
      case '9':
        selectedSociosIds = SociosPorAnalista(analistaId: '9', socios: socios);
        break;

      // Repite este bloque para cada analista (hasta el '10')
      case '10':
        selectedSociosIds = SociosPorAnalista(analistaId: '10', socios: socios);
        break;
      default:
        // Handle default case if needed
        break;
    }

    //List<Socio> filteredUsers = users.where((user) {return selectedUsersIds.contains(user.number);
    //}).toList();
    // List<Socio> usersAssignedToToday = [];
    //List<Socio> usersNotAssignedToToday = [];

    // Filtrar usuarios asignados y no asignados a la fecha seleccionada
    for (Socio socio in socios) {
      if (selectedSociosIds.contains(socio.idSocio)) {
        if (socioIsAssignedToToday(socio)) {
          sociosAssignedToToday.add(socio);
        } else {
          sociosNotAssignedToToday.add(socio);
        }
      }
    }

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            container,
                          ],
                        ),
                        const SizedBox(height: 25.0),
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
                                          _buildDistrictSelector(
                                            districts: districts,
                                            selectedDistrict: selectedDistrict,
                                            onChanged: (String? value) {
                                              setState(() {
                                                selectedDistrict = value ?? '';
                                              });
                                            },
                                          ),
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
                                                // Aquí puedes agregar la lógica para generar
                                                // Por ejemplo, puedes llamar a una función _handleGeneratePressed()
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
                                        _buildDistrictSelector(
                                          districts: districts,
                                          selectedDistrict: selectedDistrict,
                                          onChanged: (String? value) {
                                            setState(() {
                                              selectedDistrict = value ?? '';
                                            });
                                          },
                                        ),
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
                                              // Aquí puedes agregar la lógica para generar
                                              // Por ejemplo, puedes llamar a una función _handleGeneratePressed()
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
                        Center(
                          child: _buildDataTable(
                              selectedOption, sociosAssignedToToday),
                        ),
                        const SizedBox(height: 15.0),
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
            if (isFloatingPageVisible)
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
              ),
          ],
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
  Widget _buildDistrictSelector({
    required List<String> districts,
    required String selectedDistrict,
    required ValueChanged<String?> onChanged, // Cambiado a String?
  }) {
    return DropdownButton<String>(
      isExpanded: true,
      value: selectedDistrict.isNotEmpty ? selectedDistrict : null,
      items: districts.map((district) {
        return DropdownMenuItem<String>(
          value: district,
          child: Text(
            district,
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 76, 128),
              fontSize: 15.0,
              fontFamily: 'HelveticaCondensed',
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      hint: const Text(
        'Seleccionar distrito',
        style: TextStyle(
          color: Color.fromARGB(255, 196, 196, 196),
          fontSize: 15.0,
          fontFamily: 'HelveticaCondensed',
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
                fontSize: 15.0,
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
          fontSize: 15.0,
          fontFamily: 'HelveticaCondensed',
        ),
      ),
    );
  }

  List<String> SociosPorAnalista({
    required String analistaId,
    required List<Socio> socios,
  }) {
    return socios
        .where((socio) => socio.idAnalista == analistaId)
        .map((socio) => socio.idSocio)
        .toList();
  }

  Widget _buildDataTable(String title, List<Socio> socioList) {
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
                        fontWeight: FontWeight.bold),
                  )),
                  DataColumn(
                      label: Text('NOMBRE',
                          style: TextStyle(
                              fontFamily: 'HelveticaCondensed',
                              fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('DIRECCIÓN',
                          style: TextStyle(
                              fontFamily: 'HelveticaCondensed',
                              fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('MODALIDAD',
                          style: TextStyle(
                              fontFamily: 'HelveticaCondensed',
                              fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('  ')),
                ],
                rows: socioList.map((socio) {
                  return DataRow(
                    onSelectChanged: (isSelected) {
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
                    },
                    cells: [
                      DataCell(Text(socio.dni,
                          style: const TextStyle(
                            fontFamily: 'HelveticaCondensed',
                          ))),
                      DataCell(Text("${socio.name} ${socio.lastName}",
                          style: const TextStyle(
                            fontFamily: 'HelveticaCondensed',
                          ))),
                      DataCell(Text(socio.address,
                          style: const TextStyle(
                            fontFamily: 'HelveticaCondensed',
                          ))),
                      DataCell(Text(socio.tipoGrupo,
                          style: const TextStyle(
                            fontFamily: 'HelveticaCondensed',
                          ))),
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

  void _handlePlusIconPressed(Socio socio) {
    setState(() {
      socio.assignedDate = DateTime(2024, 1, 8);
    });
    _toggleFloatingPage();
  }

  void _onDistrictChanged(dynamic value) {
    if (value is String) {
      // Handle district selection
      setState(() {
        selectedDistrict = value;
      });
    } else if (value is int) {
      // Handle number selection
      setState(() {
        selectedPromotion = value;
        selectedAmpliation = value;
        selectedTracking = value;
        selectedRecovery = value;
      });
    }
  }

  void _handleTrashIconPressed(Socio socio) {
    setState(() {
      socio.assignedDate = DateTime.now().add(const Duration(days: 1));
    });
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
