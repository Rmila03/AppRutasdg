import 'package:flutter/material.dart';
import 'package:ruta_sdg/widgets/menu_supervisor.dart';
import 'package:ruta_sdg/socio.dart';
import 'package:ruta_sdg/analista.dart';
import 'package:ruta_sdg/widgets/menu_supervisor_mobile.dart';

class NotificacionesSupervisorPage extends StatelessWidget {
  const NotificacionesSupervisorPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return const NotificacionesSupervisorContent();
  }
}

class NotificacionesSupervisorContent extends StatefulWidget {
  const NotificacionesSupervisorContent({Key? key});

  @override
  _NotificacionesSupervisorContentState createState() =>
      _NotificacionesSupervisorContentState();
}

class _NotificacionesSupervisorContentState
    extends State<NotificacionesSupervisorContent> {
  String selectedMenu = 'Notificaciones';
  DateTime selectedDate = DateTime.now();
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  final List<Analista> analistas = getAnalistas();
  final List<Socio> socios = getSocios();

  List<Analista> filteredAnalista = [];
  List<Socio> filteredSocio = [];

  List<Socio> getSociosByAnalistaId(String analistaId) {
    return getSocios()
        .where((socio) => socio.idAnalista == analistaId)
        .toList();
  }

  void updateSocios(String analistaId) {
    setState(() {
      filteredSocio = getSociosByAnalistaId(analistaId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MediaQuery.of(context).size.width < 640
          ? const MenuSupervisorMobile(name: 'NOTIFICACIONES')
          : null,
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= 640)
            const MenuSupervisor(name: 'NOTIFICACIONES'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40.0),
                  _buildTitle(),
                  const SizedBox(height: 20.0),
                  _buildSearchBox(),
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredSocio.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildSocioCard(filteredSocio[index]);
                      },
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

  Widget _buildTitle() {
    return const Text(
      'NOTIFICACIONES DE CAMBIOS',
      style: TextStyle(
        fontSize: 25.0,
        color: Color.fromARGB(255, 0, 76, 128),
        fontWeight: FontWeight.bold,
        fontFamily: 'HelveticaCondensed',
      ),
    );
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.zero, // Elimina el padding
            width: 250.0, // Establece el ancho deseado
            child: DropdownButtonFormField<Analista>(
              isExpanded: true,
              dropdownColor: Colors.white,
              focusColor: Colors.transparent,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: "HelveticaCondensed",
              ),
              items: analistas.map((Analista analista) {
                return DropdownMenuItem<Analista>(
                  value: analista,
                  child: Text(
                    "${analista.name} ${analista.lastName}",
                    style: const TextStyle(
                      fontFamily: "HelveticaCondensed",
                    ),
                  ),
                );
              }).toList(),
              onChanged: (Analista? selectedAnalista) {
                if (selectedAnalista != null) {
                  searchController.text =
                      "${selectedAnalista.name} ${selectedAnalista.lastName}";
                  updateSocios(selectedAnalista.idAnalista);
                }
              },
              decoration: InputDecoration(
                labelText: 'Seleccionar Analista',
                contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                labelStyle: const TextStyle(
                  fontFamily: 'HelveticaCondensed',
                  color: Color.fromARGB(255, 0, 76, 128),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 4, 56, 99),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 4, 56, 99),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocioCard(Socio socio) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(8.0), // Ajusta el espacio interno aquí
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 0, 76, 128),
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.notifications,
            color: Colors.red,
            size: 24.0,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Notificación de Cambio',
                  style: TextStyle(
                    fontFamily: 'HelveticaCondensed',
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Color.fromARGB(255, 3, 3, 3),
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Nombre: ${socio.name} ${socio.lastName}',
                  style: const TextStyle(
                      fontFamily: 'HelveticaCondensed', fontSize: 14.0),
                ),
                const Text(
                  'Fecha de notificación:',
                  style: TextStyle(
                      fontFamily: 'HelveticaCondensed',
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 76, 128)),
                ),
                const Text(
                  'Descripción del cambio:',
                  style: TextStyle(
                      fontFamily: 'HelveticaCondensed',
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 76, 128)),
                ),
                const Text(
                  'Aquí va la descripción detallada del cambio...',
                  style: TextStyle(
                      fontFamily: 'HelveticaCondensed', fontSize: 14.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
