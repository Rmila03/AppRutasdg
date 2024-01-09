import 'package:flutter/material.dart';
import 'package:ruta_sdg/widgets/menu_supervisor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReporteSupervisorPage extends StatelessWidget {
  const ReporteSupervisorPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return ReporteSupervisorContent();
  }
}

class ReporteSupervisorContent extends StatefulWidget {
  const ReporteSupervisorContent({Key? key});

  @override
  _ReporteSupervisorContentState createState() =>
      _ReporteSupervisorContentState();
}

class UserData {
  String id;
  String name;
  String dni;
  int daysLate;

  UserData(this.id, this.name, this.dni, this.daysLate);
}

class _ReporteSupervisorContentState extends State<ReporteSupervisorContent> {
  String selectedMenu = 'REPORTES';
  DateTime selectedDate = DateTime.now();
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  List<UserData> users = [
    UserData("1", "Ruth Milagros", "12345678", 5),
    UserData("2", "Yolmy Milagros", "98765432", 8),
    // Agrega más usuarios según sea necesario
  ];

  List<UserData> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    filteredUsers = users;
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
                  const SizedBox(height: 50.0),
                  _buildTitle(),
                  const SizedBox(height: 20.0),

                  // Date picker widget
                  _buildDatePicker(context),
                  const SizedBox(height: 10.0),

                  // Search box widget
                  _buildSearchBox(),

                  const SizedBox(height: 10.0),

                  // Data table widget
                  _buildDataTable(filteredUsers),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'REPORTES',
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
          padding: const EdgeInsets.only(left: 50.0),
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
              border: Border.all(
                color: const Color.fromARGB(255, 0, 76, 128),
              ),
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

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(searchFocusNode);
        },
        child: Stack(
          children: [
            Container(
              width: 400.0,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromARGB(255, 0, 76, 128),
                  ),
                ),
              ),
              child: TextField(
                controller: searchController,
                focusNode: searchFocusNode,
                cursorColor: const Color.fromARGB(255, 0, 76, 128),
                decoration: InputDecoration(
                  labelText: 'Buscar',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 0, 76, 128),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 0, 76, 128) // Cambia a azul
                        ),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear_outlined),
                    color: const Color.fromARGB(255, 0, 76, 128),
                    onPressed: () {
                      searchController.clear();
                      _updateSearchResults('');
                    },
                  ),
                ),
                onChanged: (value) {
                  _updateSearchResults(value);
                },
              ),
            ),
            if (searchFocusNode.hasFocus && filteredUsers.isNotEmpty)
              Positioned(
                top: 50.0,
                child: Container(
                  width: 400.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 0, 76, 128)),
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                  child: ListView.builder(
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredUsers[index].name),
                        onTap: () {
                          searchController.text = filteredUsers[index].name;
                          _updateSearchResults(filteredUsers[index].name);
                          searchFocusNode.unfocus();
                        },
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataTable(List<UserData> userList) {
    List<DataRow> rows = userList.map((user) {
      return DataRow(
        cells: [
          DataCell(Text(user.dni)),
          DataCell(Text(user.name)),
          DataCell(
            IconButton(
              icon: const Icon(Icons.download),
              onPressed: () {
                // Agrega aquí la lógica de descarga para este usuario
              },
            ),
          ),
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
          borderRadius: BorderRadius.circular(0.0),
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
                DataColumn(label: Text('DESCARGAR')),
              ],
              rows: rows, // Usar la variable rows en lugar de userList
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
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
        )) ??
        selectedDate;
    if (picked != selectedDate && mounted) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _updateSearchResults(String query) {
    setState(() {
      filteredUsers = users
          .where(
              (user) => user.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
