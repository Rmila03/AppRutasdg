import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ruta_sdg/widgets/menu_supervisor.dart';
import 'package:ruta_sdg/socio.dart';
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
  List<String> menuOptions = [
    'Juan Perez Garcia',
    'Ruth Milagros Arce Quispe',
    'Yolmy Milagros Cahuata Lavilla',
    'Stiward Maldonado',
    'Justino Ferro'
  ];
  final List<Socio> socios = getSocios();
  bool isFloatingPageVisible = false;
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

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
      padding: const EdgeInsets.all(8.0),
      width: 450,
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
          'Seleccionar opción',
          style: TextStyle(
            color: Color.fromARGB(255, 196, 196, 196),
            fontSize: 15.0,
            fontFamily: 'Unna-Bold',
          ),
        ),
      ),
    );
    List<String> selectedSociosIds = [];

    switch (selectedOption) {
      case 'Juan Perez Garcia':
        selectedSociosIds = ['1', '4'];
        break;
      case 'Ruth Milagros Arce Quispe':
        selectedSociosIds = ['3', '5'];
        break;
      case 'Yolmy Milagros Cahuata Lavilla':
        selectedSociosIds = ['2', '8'];
        break;
      case 'Stiward Maldonado':
        selectedSociosIds = ['6', '10'];
        break;
      case 'Justino Ferro':
        selectedSociosIds = ['7', '9'];
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
      if (selectedSociosIds.contains(socio.number)) {
        // Verificar si el usuario está asignado a la fecha de hoy
        if (socioIsAssignedToToday(socio)) {
          sociosAssignedToToday.add(socio);
        } else {
          sociosNotAssignedToToday.add(socio);
        }
      }
    }

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Row(
              children: [
                const MenuSupervisor(name: "PLAN DEL DÍA"),
                Expanded(
                  // child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 25.0),
                        Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'PLAN DEL DÍA',
                            style: TextStyle(
                              color: Color(0xFF0E813C),
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Unna-Bold',
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          'Ramón Perez García',
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Unna-Bold',
                          ),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                FontAwesomeIcons.calendarDay,
                                color: Color.fromARGB(255, 4, 56, 99),
                              ),
                              onPressed: () {
                                _selectDate(context);
                              },
                            ),
                            const SizedBox(width: 10),
                            Text(
                              DateFormat('dd/MM/yyyy').format(selectedDate),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 4, 56, 99),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            container,
                            GestureDetector(
                              onTap: () {
                                _toggleFloatingPage();
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 100),
                                padding: const EdgeInsets.fromLTRB(16.0, 16.0,
                                    16.0, 16.0), // Ajuste del margen derecho
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0E813C),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.add, color: Colors.white),
                                    Text(
                                      'AÑADIR',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //const SizedBox(width: 0), // Ajuste del margen derecho
                          ],
                        ),
                        const SizedBox(height: 25.0),
                        Center(
                          child: _buildDataTable(
                              selectedOption, sociosAssignedToToday),
                        )
                      ],
                    ),
                  ),
                  // ),
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
                        width: 600,
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
                              // Puedes utilizar updatedFilteredUsers si es necesario
                            });
                          },
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

  Widget _buildDataTable(String title, List<Socio> socioList) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFFD9DEDA), width: 2.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.white,
          elevation: 0,
          child: SizedBox(
            height: 300,
            width: 1000,
            child: SingleChildScrollView(
              child: DataTable(
                showCheckboxColumn: false,
                columnSpacing: 7.0,
                headingRowColor:
                    MaterialStateProperty.all(const Color(0xFFD9DEDA)),
                columns: const [
                  DataColumn(label: Text('DNI')),
                  DataColumn(label: Text('NOMBRE')),
                  DataColumn(label: Text('DIRECCIÓN')),
                  DataColumn(label: Text('MODALIDAD')),
                  DataColumn(label: Text('  ')),
                ],
                rows: socioList.asMap().entries.map((entry) {
                  Socio socio = entry.value;

                  return DataRow(
                    cells: [
                      DataCell(Text(socio.dni)),
                      DataCell(Text("${socio.name} ${socio.lastName}")),
                      DataCell(Text(socio.address)),
                      const DataCell(Text("Promoción")),
                      DataCell(
                        IconButton(
                          icon: const Icon(FontAwesomeIcons.trash,
                              color: Color(0xFF0E813C)),
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
            primaryColor: const Color.fromARGB(255, 4, 56, 99),
            hintColor: const Color.fromARGB(255, 140, 178, 210),
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 4, 56, 99),
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

  const FloatingPage({
    super.key,
    required this.socioList,
    required this.onPlusIconPressed,
    required this.onListsUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        height: 800,
        width: 600,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40.0),
          border: Border.all(
            color: const Color(0xFF0E813C),
            width: 3.0,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: const Color(0xFF0E813C),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: const Text(
                '   LISTA DE SOCIOS   ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: 'General'),
                Tab(text: 'Sugerencias'),
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
              color: Colors.black,
            ),
            preferBelow: false,
            verticalOffset: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${socio.name} ${socio.lastName}',
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Motivo: Cambio de ciudad',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color.fromARGB(255, 9, 104, 47),
                  ),
                ),
              ],
            ),
          ),
          trailing: IconButton(
            icon: const Icon(
              FontAwesomeIcons.plus,
              color: Color(0xFF0E813C),
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
                      color: Colors.black, // Color del texto dentro del Tooltip
                    ),
                    preferBelow: false,
                    verticalOffset:
                        20, // Ajusta la posición vertical del Tooltip

                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        '${socio.name} ${socio.lastName}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.plus,
                        color: Color(0xFF0E813C),
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
