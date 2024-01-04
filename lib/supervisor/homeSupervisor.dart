import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ruta_sdg/widgets/menu_supervisor.dart';
import 'package:ruta_sdg/user.dart';

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
  final List<UserData> users = [
    UserData(
        "1",
        "Ruth Milagros",
        "Arce Quispe",
        "12345678",
        "978563412",
        'abcd@gmail.com',
        "Jr. Jose Carlos Mariategui #345",
        "Cusco",
        "Cusco",
        "Cusco"),
    UserData("2", "Yolmy Milagros", "Cahuata Lavilla", "98765432", "978563412",
        "foo@gmail.com", "Av. La cultura #345", "Cusco", "Cusco", "Cusco"),
    // Agrega más usuarios según sea necesario
  ];
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

    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              const MenuSupervisor(name: "PLAN DEL DÍA"),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20.0),
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
                        child: _buildDataTable("", users),
                      )
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
                      width: 600,
                      height: 800,
                      child: FloatingPage(userList: users),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildDataTable(String title, List<UserData> userList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFFD9DEDA), width: 2.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 0,
        child: SizedBox(
          height: 400,
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
              rows: userList.asMap().entries.map((entry) {
                UserData user = entry.value;

                return DataRow(
                  cells: [
                    DataCell(Text(user.dni)),
                    DataCell(Text("${user.name} ${user.lastName}")),
                    DataCell(Text(user.address)),
                    const DataCell(Text("Promoción")),
                    const DataCell(
                      Icon(FontAwesomeIcons.trash, color: Color(0xFF0E813C)),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
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
  final List<UserData> userList;

  const FloatingPage({super.key, required this.userList});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Center(child: SearchAndUserList(userList: userList)),
        ],
      ),
    );
  }
}

class SearchAndUserList extends StatefulWidget {
  final List<UserData> userList;

  const SearchAndUserList({super.key, required this.userList});

  @override
  _SearchAndUserListState createState() => _SearchAndUserListState();
}

class _SearchAndUserListState extends State<SearchAndUserList> {
  late TextEditingController _searchController;
  List<UserData> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    filteredUsers = widget.userList;
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    String searchText = _searchController.text.toLowerCase();
    setState(() {
      filteredUsers = widget.userList.where((user) {
        return user.name.toLowerCase().contains(searchText) ||
            user.lastName.toLowerCase().contains(searchText);
      }).toList();
    });
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
        for (final user in filteredUsers)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    '${user.name} ${user.lastName}',
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: const Icon(
                    FontAwesomeIcons.plus,
                    color: Color(0xFF0E813C),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
