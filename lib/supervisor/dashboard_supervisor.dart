import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ruta_sdg/widgets/menu_supervisor.dart';

class DashboardSupervisorPage extends StatefulWidget {
  const DashboardSupervisorPage({super.key});

  @override
  State<DashboardSupervisorPage> createState() =>
      _DashboardSupervisorPageState();
}

class _DashboardSupervisorPageState extends State<DashboardSupervisorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const MenuSupervisor(name: "DASHBOARD"),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  const Text(
                    'HOLA Ramónesssssssssss',
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
}
