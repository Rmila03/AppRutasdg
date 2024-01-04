import 'package:flutter/material.dart';
import 'package:ruta_sdg/widgets/menu_supervisor.dart';

class HistorialSupervisorPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const HistorialSupervisorPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HistorialSupervisorContent(),
    );
  }
}

class HistorialSupervisorContent extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const HistorialSupervisorContent({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _HistorialSupervisorContentState createState() =>
      _HistorialSupervisorContentState();
}

class _HistorialSupervisorContentState
    extends State<HistorialSupervisorContent> {
  String selectedMenu = 'HISTORIAL';
  DateTime selectedDate = DateTime.now();

  // Lista de Cambios para cada fecha
  List<Cambio> cambios = [
    Cambio(DateTime(2024, 1, 1), "Cambio 1", "Descripción Cambio 1"),
    Cambio(DateTime(2024, 1, 1), "Cambio 2", "Descripción Cambio 2"),
    Cambio(DateTime(2024, 1, 2), "Cambio 3", "Descripción Cambio 3"),
    Cambio(DateTime(2024, 1, 2), "Cambio 4", "Descripción Cambio 4"),
    Cambio(DateTime(2024, 1, 3), "Cambio 5", "Descripción Cambio 5"),
    Cambio(DateTime(2024, 1, 3), "Cambio 6", "Descripción Cambio 6"),
    // Agrega más Cambios según sea necesario
  ];

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    List<Cambio> cambiosDelDia = obtenerCambiosDelDia(selectedDate);

    return Scaffold(
      body: Row(
        children: [
          MenuSupervisor(name: selectedMenu),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start, // Cambiado a start
              children: [
                buildTitle(),
                const SizedBox(height: 20.0),
                buildDatePicker(),
                const SizedBox(height: 20.0),
                for (var cambio in cambiosDelDia) ...[
                  buildAlarmInfo(
                    cambio.fecha,
                    cambio.nombre,
                    cambio.descripcion,
                    mostrarBotonVerTodo: true,
                  ),
                  const SizedBox(height: 10.0),
                ],
                buildAllEventsButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTitle() {
    return const Text(
      'HISTORIAL DE CAMBIOS',
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.amber,
        fontWeight: FontWeight.bold,
        fontFamily: 'Montserrat',
      ),
    );
  }

  Widget buildDatePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.calendar_today),
              color: const Color.fromARGB(255, 0, 76, 128),
              onPressed: () {
                _selectDate(context);
              },
            ),
            const SizedBox(width: 10.0),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 0, 76, 128)),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                selectedDate.toLocal().toString().split(' ')[0],
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildAlarmInfo(DateTime fecha, String name, String description,
      {bool mostrarBotonVerTodo = true}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 0, 76, 128)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 900.0),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: Color.fromARGB(255, 0, 76, 128)),
                ),
              ),
              child: Text(
                "${fecha.day}/${fecha.month}/${fecha.year}",
                style: const TextStyle(fontSize: 14.0),
              ),
            ),
            const SizedBox(width: 10.0),
            const Icon(Icons.alarm),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAllEventsButton() {
    return ElevatedButton(
      onPressed: () {
        // Muestra todos los Cambios almacenados
        mostrarTodosLosCambios();
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.amber,
        padding: EdgeInsets.zero,
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: Text("VER TODO"),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        )) ??
        selectedDate;
    if (picked != selectedDate && mounted) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Función para obtener Cambios de una fecha específica
  List<Cambio> obtenerCambiosDelDia(DateTime fecha) {
    return cambios.where((cambio) {
      return cambio.fecha.year == fecha.year &&
          cambio.fecha.month == fecha.month &&
          cambio.fecha.day == fecha.day;
    }).toList();
  }

  // Función para mostrar todos los Cambios almacenados
  void mostrarTodosLosCambios() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Todos los Cambios'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var cambio in cambios) ...[
                  buildAlarmInfo(
                    cambio.fecha,
                    cambio.nombre,
                    cambio.descripcion,
                    mostrarBotonVerTodo: false,
                  ),
                  const SizedBox(height: 10.0),
                ],
              ],
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}

// Clase para representar un Cambio
class Cambio {
  final DateTime fecha;
  final String nombre;
  final String descripcion;

  Cambio(this.fecha, this.nombre, this.descripcion);
}
