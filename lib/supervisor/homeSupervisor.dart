// ignore: file_names
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

class _MyHomeSupervisorPageState extends State<MyHomeSupervisorPage> {
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
      body: Row(
        children: [
          const MenuSupervisor(name: "PLAN DEL DÍA"),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  // Texto "PLAN DEL DÍA" en negrita, de color verde claro, al centro y con un tamaño de letra de 25
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
                      const SizedBox(
                          width: 10), // Ajusta el espacio según sea necesario
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
                          // Agregar lógica para redirigir a la pantalla "añadirclass()"
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0E813C),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.add, color: Colors.white),
                              Text(
                                'AÑADIR',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  // Aquí debes implementar la tabla con las columnas especificadas
                  Center(child: _buildDataTable("", users))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable(String title, List<UserData> userList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
              color: Color.fromRGBO(255, 255, 255, 1), width: 2.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: const Color.fromARGB(255, 255, 255, 255),
        elevation: 5,
        child: SizedBox(
          height: 400,
          width: 1000,
          child: SingleChildScrollView(
            child: DataTable(
              showCheckboxColumn: false,
              columnSpacing: 7.0,
              columns: const [
                DataColumn(label: Text('DNI')),
                DataColumn(label: Text('NOMBRE')),
                DataColumn(label: Text('DIRECCIÓN')),
                DataColumn(label: Text('MODALIDAD')),
                DataColumn(label: Text('  ')),
              ],
              rows: userList.map((user) {
                return DataRow(
                  //onSelectChanged: () {},
                  cells: [
                    DataCell(Text(user.dni)),
                    DataCell(Text("${user.name} ${user.lastName}")),
                    DataCell(Text(user.address)),
                    const DataCell(Text("Promoción")),
                    const DataCell(
                        Icon(FontAwesomeIcons.trash, color: Colors.green)),
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
      // Si el usuario canceló la selección, asignar la fecha actual
      pickedDate = DateTime.now();
      setState(() {
        selectedDate = pickedDate!;
      });
    }
  }
}

class FechaGestureDetector extends StatelessWidget {
  const FechaGestureDetector({
    super.key,
    required this.selectedDate,
    required this.selectDateCallback,
    required this.dateFormat,
  });

  final DateTime selectedDate;
  final Function(BuildContext) selectDateCallback;
  final DateFormat dateFormat;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => selectDateCallback(context),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0, top: 20),
                child: Container(
                  height: 24,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(0.0),
                  alignment: Alignment.center,
                  child: Text(
                    dateFormat.format(selectedDate),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
