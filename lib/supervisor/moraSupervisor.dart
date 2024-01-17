import 'package:flutter/material.dart';
import 'package:ruta_sdg/widgets/menu_supervisor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MoraSupervisorPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MoraSupervisorPage({Key? key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MoraSupervisorContent();
  }
}

class MoraSupervisorContent extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const MoraSupervisorContent({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _MoraSupervisorContentState createState() => _MoraSupervisorContentState();
}

class UserData {
  String id;
  String name;
  String lastName;
  String dni;
  String phoneNumber;
  String email;
  String address;
  String city;
  String department;
  String district;
  int daysLate;

  UserData(
    this.id,
    this.name,
    this.lastName,
    this.dni,
    this.phoneNumber,
    this.email,
    this.address,
    this.city,
    this.department,
    this.district,
    this.daysLate,
  );
}

class _MoraSupervisorContentState extends State<MoraSupervisorContent> {
  String selectedMenu = 'MORA';
  DateTime selectedDate = DateTime.now();

  String selectedOption = '';

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
        "Cusco",
        5),
    UserData("2", "Yolmy Milagros", "Cahuata Lavilla", "98765432", "978563412",
        "foo@gmail.com", "Av. La cultura #345", "Cusco", "Cusco", "Cusco", 8),
    // Agrega más usuarios según sea necesario
  ];

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left side menu
          MenuSupervisor(name: selectedMenu),

          // Expanded section for the main content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Other widgets...

                  // Title widget
                  // Container with margin before the table title
                  const SizedBox(height: 0.0), // Añade un espacio en blanco
                  _buildTitle(),

                  // Date picker widget
                  const SizedBox(height: 5.0),
                  _buildDatePicker(context),

                  // Filter button widget
                  _showFilterDialog(),

                  // Data table widget
                  _buildDataTable(users),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _showFilterDialog() => AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: const Color(0xFFD9DEDA),
              width: 2.0,
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Selecciona días:',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              DropdownButton<int>(
                value: filterDays,
                focusColor: Colors.transparent,
                onChanged: (int? value) {
                  if (value != null) {
                    setState(() {
                      filterDays = value;
                    });
                  }
                },
                items: List.generate(
                  11,
                  (index) => DropdownMenuItem<int>(
                    value: index,
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5.0), // Ajusta el margen horizontal
                      child: Text(
                        index == 0 ? '' : '$index',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildTitle() {
    return const Text(
      'SOCIOS EN MORA',
      style: TextStyle(
        fontSize: 25.0,
        color: Color.fromARGB(255, 0, 76, 128),
        fontWeight: FontWeight.bold,
        fontFamily: 'Montserrat',
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(
              left: 50.0), // Añade sangría al lado izquierdo
          child: IconButton(
            icon: const Icon(
              FontAwesomeIcons.calendarDay,
            ),
            color: const Color.fromARGB(255, 0, 76, 128),
            onPressed: () {
              _selectDate(context);
            },
          ),
        ),
        const SizedBox(width: 10.0),
        GestureDetector(
          onTap: () {
            _selectDate(context);
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(255, 0, 76, 128)),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              selectedDate.toLocal().toString().split(' ')[0],
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ],
    );
  }

  int filterDays = 0;

  void setFilterDays(int value) {
    setState(() {
      filterDays = value;
    });
  }

  Widget _buildDataTable(List<UserData> userList) {
    List<UserData> filteredUsers = userList
        .where((user) => filterDays == 0 || user.daysLate == filterDays)
        .toList();

    List<DataRow> rows = filteredUsers.map((user) {
      return DataRow(
        cells: [
          DataCell(Text(user.dni)),
          DataCell(Text("${user.name} ${user.lastName}")),
          DataCell(Text(user.address)),
          DataCell(Text(user.daysLate.toString())),
        ],
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color.fromRGBO(255, 255, 255, 1),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: const Color.fromARGB(255, 255, 255, 255),
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
                DataColumn(label: Text('DÍAS DE ATRASO')),
              ],
              rows: rows, // Usar la variable rows en lugar de userList
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime picked = (await showDatePicker(
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
                buttonTheme: const ButtonThemeData(
                  textTheme: ButtonTextTheme.primary,
                ),
              ),
              child: child!,
            );
          },
        )) ??
        selectedDate;

    if (picked != selectedDate && mounted) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
