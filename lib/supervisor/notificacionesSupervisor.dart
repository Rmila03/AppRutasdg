import 'package:flutter/material.dart';
import 'package:ruta_sdg/widgets/menu_supervisor.dart';
import 'package:ruta_sdg/socio.dart';
import 'package:ruta_sdg/analista.dart';

class NotificacionesSupervisorPage extends StatelessWidget {
  const NotificacionesSupervisorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: NotificacionesSupervisorContent(),
      ),
    );
  }
}

class NotificacionesSupervisorContent extends StatefulWidget {
  const NotificacionesSupervisorContent({Key? key}) : super(key: key);

  @override
  _NotificacionesSupervisorContentState createState() =>
      _NotificacionesSupervisorContentState();
}

class _NotificacionesSupervisorContentState
    extends State<NotificacionesSupervisorContent> {
  late String selectedAnalistaId;
  List<Socio> socios = [];

  @override
  void initState() {
    super.initState();
    selectedAnalistaId = getAnalistas().first.idAnalista;
    updateSocios(selectedAnalistaId);
  }

  List<Socio> getSociosByAnalistaId(String analistaId) {
    return getSocios()
        .where((socio) => socio.idAnalista == analistaId)
        .toList();
  }

  void updateSocios(String analistaId) {
    setState(() {
      socios = getSociosByAnalistaId(analistaId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const MenuSupervisor(name: 'NOTIFICACIONES'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 40.0),
                  const Text(
                    'NOTIFICACIONES DE CAMBIOS',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Color.fromARGB(255, 0, 76, 128),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: DropdownButton<String>(
                      value: selectedAnalistaId,
                      items: getAnalistas().map((analista) {
                        return DropdownMenuItem<String>(
                          value: analista.idAnalista,
                          child: Text(' ${analista.name}'),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedAnalistaId = newValue;
                            updateSocios(selectedAnalistaId);
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Cambiado a start
                      children: [
                        for (var socio in socios) ...[
                          buildAlarmInfo(
                            socio.name,
                            'Descripción Cambio', // Cambia la descripción según tus necesidades
                            mostrarBotonVerTodo: true,
                          ),
                          const SizedBox(height: 10.0),
                        ],
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

  Widget buildAlarmInfo(String name, String description,
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
            const SizedBox(width: 10.0),
            const Icon(
              Icons.notifications,
              color: Colors.red,
            ),
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
}

class Cambio {
  final String nombreAnalista;
  final String descripcion;

  Cambio(this.nombreAnalista, this.descripcion);
}
