import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const HomeSupervisorPage());
}

class HomeSupervisorPage extends StatelessWidget {
  const HomeSupervisorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomeSupervisorPage(),
    );
  }
}

class MyHomeSupervisorPage extends StatefulWidget {
  const MyHomeSupervisorPage({super.key});

  @override
  _MyHomeSupervisorPageState createState() => _MyHomeSupervisorPageState();
}

class _MyHomeSupervisorPageState extends State<MyHomeSupervisorPage> {
  String selectedMenu = 'PLAN DEL DÍA'; // Inicialmente seleccionado 'Inicio'
  Map<String, Widget> screens = {
    'PLAN DEL DÍA': const MyHomeSupervisorPage(),
    'REPORTES': const MyHomeSupervisorPage(),
    'CARTERA': const MyHomeSupervisorPage(),
    'DASHBOARD': const MyHomeSupervisorPage(),
    'MORA': const MyHomeSupervisorPage(),
    'HISTORIAL': const MyHomeSupervisorPage(),
    // Agrega las demás pantallas según sea necesario
  };
  @override
  Widget build(BuildContext context) {
    Color customColor = const Color(0xFFD9DEDA);
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 250,
            color: customColor,
            //decoration: const BoxDecoration(
            //  border: Border(right: BorderSide(color: Colors.black, width: 2.0, style: BorderStyle.solid)),
            //),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Agregar la imagen y el texto arriba de los buildMenuItem
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/logo-sdg.png', width: 50, height: 50),
                      const SizedBox(width: 8.0),
                      const Text(
                        'RUTASSDG',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  ),
                ),
                buildMenuItem('PLAN DEL DÍA'),
                buildMenuItem('REPORTES'),
                buildMenuItem('CARTERA'),
                buildMenuItem('DASHBOARD'),
                buildMenuItem('MORA'),
                buildMenuItem('HISTORIAL'),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  const Text(
                    'HOLA Ramón',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 20.0,
                      fontFamily: 'Unna-Bold',
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.calendar,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          // Agregar lógica para seleccionar la fecha
                        },
                      ),
                      // Aquí debes implementar la lógica para mostrar la fecha seleccionada
                      const Text(
                        '--------------',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: DropdownButton<String>(
                          items: [
                            'Juan Perez Garcia',
                            'Ruth Milagros Arce Quispe',
                            'Stiward Maldonado',
                            'Justino Ferro'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontFamily: 'Unna-Bold',
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            // Agregar lógica para manejar la opción seleccionada
                          },
                          hint: const Text(
                            'Seleccionar opción',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontFamily: 'Unna-Bold',
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Agregar lógica para redirigir a la pantalla "añadirclass()"
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.orange,
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
                  Center(
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('DNI')),
                        DataColumn(label: Text('NOMBRE')),
                        DataColumn(label: Text('DIRECCIÓN')),
                        DataColumn(label: Text('MODALIDAD')),
                        DataColumn(label: Text('--')),
                      ],
                      rows: const [
                        DataRow(cells: [
                          DataCell(Text('123')),
                          DataCell(Text('Juan')),
                          DataCell(Text('Calle 123')),
                          DataCell(Text('Presencial')),
                          DataCell(Text('--')),
                        ]),
                        // Agregar más filas según sea necesario
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem(String title) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedMenu = title;
        });

        // Redirigir a la pantalla correspondiente
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => screens[selectedMenu]!,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: selectedMenu == title
              ? const Color(0xFFD9DEDA)
              : Colors.transparent,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selectedMenu == title ? Colors.orange : Colors.black,
            fontSize: 12.0,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
