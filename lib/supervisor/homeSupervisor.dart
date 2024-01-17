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
      "Aracely Milagros",
      "Conchoy Paucar",
      "96543025",
      "978563412",
      'abcd@gmail.com',
      "Jr. Jose Carlos Mariategui #345",
      "Cusco",
      "Cusco",
      "Cusco",
      assignedDate: DateTime.now(),
    ),
    UserData(
      "2",
      "Ana",
      "Cortez Quispe",
      "98765432",
      "978563412",
      "foo@gmail.com",
      "Av. La cultura #345",
      "Cusco",
      "Cusco",
      "Cusco",
      assignedDate: DateTime.now(),
    ),
    UserData(
      "3",
      "Glina ",
      "Puma Huamaní",
      "70236598",
      "978563412",
      'abcd@gmail.com',
      "Jr. Jose Carlos Mariategui #345",
      "Cusco",
      "Cusco",
      "Cusco",
      assignedDate: DateTime(2024, 1, 7),
    ),
    UserData(
      "4",
      "Roswell",
      "Pando Muñoz",
      "36402598",
      "978563412",
      'abcd@gmail.com',
      "Jr. Jose Carlos Mariategui #345",
      "Cusco",
      "Cusco",
      "Cusco",
      assignedDate: DateTime(2024, 1, 6),
    ),
    UserData(
      "5",
      "Yoshimori",
      "Lavilla Quispe",
      "32597322",
      "978563412",
      'abcd@gmail.com',
      "Jr. Jose Carlos Mariategui #345",
      "Cusco",
      "Cusco",
      "Cusco",
      assignedDate: DateTime.now(),
    ),
    UserData(
      "6",
      "Mishel",
      "Turpo Meza",
      "23014586",
      "978563412",
      'abcd@gmail.com',
      "Jr. Jose Carlos Mariategui #345",
      "Cusco",
      "Cusco",
      "Cusco",
      assignedDate: DateTime(2024, 1, 7),
    ),
    UserData(
      "7",
      "Anyi",
      "Mujica Hermoza",
      "35987645",
      "978563412",
      'abcd@gmail.com',
      "Jr. Jose Carlos Mariategui #345",
      "Cusco",
      "Cusco",
      "Cusco",
      assignedDate: DateTime.now(),
    ),
    UserData(
      "8",
      "Milagros",
      "Moreno Sarayasi",
      "15798642",
      "978563412",
      'abcd@gmail.com',
      "Jr. Jose Carlos Mariategui #345",
      "Cusco",
      "Cusco",
      "Cusco",
      assignedDate: DateTime(2024, 1, 10),
    ),
    UserData(
      "9",
      "Julia",
      "Ramos Gutierrez",
      "36501263",
      "978563412",
      "foo@gmail.com",
      "Av. La cultura #345",
      "Cusco",
      "Cusco",
      "Cusco",
      assignedDate: DateTime.now(),
    ),
    UserData(
      "10",
      "Margoire",
      "Chirinos Vilca",
      "54698230",
      "978563412",
      "foo@gmail.com",
      "Av. La cultura #345",
      "Cusco",
      "Cusco",
      "Cusco",
      assignedDate: DateTime.now(),
    ),
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
    List<UserData> usersAssignedToToday = [];
    List<UserData> usersNotAssignedToToday = [];
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
    List<String> selectedUsersIds = [];

    switch (selectedOption) {
      case 'Juan Perez Garcia':
        selectedUsersIds = ['1', '4'];
        break;
      case 'Ruth Milagros Arce Quispe':
        selectedUsersIds = ['3', '5'];
        break;
      case 'Yolmy Milagros Cahuata Lavilla':
        selectedUsersIds = ['2', '8'];
        break;
      case 'Stiward Maldonado':
        selectedUsersIds = ['6', '10'];
        break;
      case 'Justino Ferro':
        selectedUsersIds = ['7', '9'];
        break;
      default:
        // Handle default case if needed
        break;
    }

    //List<UserData> filteredUsers = users.where((user) {return selectedUsersIds.contains(user.number);
    //}).toList();
    // List<UserData> usersAssignedToToday = [];
    //List<UserData> usersNotAssignedToToday = [];

    // Filtrar usuarios asignados y no asignados a la fecha seleccionada
    for (UserData user in users) {
      if (selectedUsersIds.contains(user.number)) {
        // Verificar si el usuario está asignado a la fecha de hoy
        if (userIsAssignedToToday(user)) {
          usersAssignedToToday.add(user);
        } else {
          usersNotAssignedToToday.add(user);
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
                  //child: SingleChildScrollView(
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
                              selectedOption, usersAssignedToToday),
                        )
                      ],
                    ),
                  ),
                  //),
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
                          userList: usersNotAssignedToToday,
                          onPlusIconPressed: (UserData user) {
                            _handlePlusIconPressed(user);
                            _toggleFloatingPage();
                          },
                          onListsUpdated: (List<UserData> updatedUsers,
                              List<UserData> updatedFilteredUsers) {
                            setState(() {
                              usersNotAssignedToToday = updatedUsers;
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

  Widget _buildDataTable(String title, List<UserData> userList) {
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
            height: 250,
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
                      DataCell(
                        IconButton(
                          icon: const Icon(FontAwesomeIcons.trash,
                              color: Color(0xFF0E813C)),
                          onPressed: () {
                            _handleTrashIconPressed(user);
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

  void _handlePlusIconPressed(UserData user) {
    setState(() {
      user.assignedDate = DateTime(2024, 1, 8);
    });
    _toggleFloatingPage();
  }

  void _handleTrashIconPressed(UserData user) {
    setState(() {
      user.assignedDate = DateTime.now().add(const Duration(days: 1));
    });
  }

  bool userIsAssignedToToday(UserData user) {
    // Lógica para verificar si el usuario está asignado a la fecha de hoy
    return user.assignedDate != null &&
        user.assignedDate!.toLocal().isAtSameMomentAs(selectedDate);
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
  final Function(UserData) onPlusIconPressed;
  final Function(List<UserData>, List<UserData>) onListsUpdated;

  const FloatingPage({
    Key? key,
    required this.userList,
    required this.onPlusIconPressed,
    required this.onListsUpdated,
  }) : super(key: key);

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
          Expanded(
            child: SingleChildScrollView(
              child: SearchAndUserList(
                userList: userList,
                onPlusIconPressed: onPlusIconPressed,
                onListsUpdated: onListsUpdated,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchAndUserList extends StatefulWidget {
  final List<UserData> userList;
  final Function(UserData) onPlusIconPressed;
  final Function(List<UserData>, List<UserData>) onListsUpdated;

  const SearchAndUserList({
    Key? key,
    required this.userList,
    required this.onPlusIconPressed,
    required this.onListsUpdated,
  }) : super(key: key);

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

  void _handlePlusIconPressed(UserData user) {
    widget.onPlusIconPressed(user);
  }

  void _onSearchChanged() {
    String searchText = _searchController.text.toLowerCase();
    setState(() {
      filteredUsers = widget.userList.where((user) {
        return user.name.toLowerCase().contains(searchText) ||
            user.lastName.toLowerCase().contains(searchText);
      }).toList();
    });

    // Devuelve las listas actualizadas a la clase principal
    widget.onListsUpdated(widget.userList, filteredUsers);
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
          itemCount: filteredUsers.length,
          itemBuilder: (context, index) {
            final user = filteredUsers[index];
            return Padding(
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
                    child: IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.plus,
                        color: Color(0xFF0E813C),
                      ),
                      onPressed: () {
                        _handlePlusIconPressed(user);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${user.name} añadido correctamente.',
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
