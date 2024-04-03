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
  void initState() {
    super.initState();
    filteredSocio = List.from(socios);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Row(
              children: [
                if (MediaQuery.of(context).size.width >= 640)
                  const MenuSupervisor(name: 'NOTIFICACIONES'),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildTitle(),
                      _buildSearchBox(),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredSocio.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildNotificationCard(filteredSocio[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: MediaQuery.of(context).size.width < 640
            ? const MenuSupervisorMobile(name: 'NOTIFICACIONES')
            : null,
      ),
    );
  }

  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.only(top: 25, bottom: 16),
      child: Text(
        'NOTIFICACIONES DE CAMBIOS',
        style: TextStyle(
          fontSize: 25.0,
          color: Color.fromARGB(255, 0, 76, 128),
          fontWeight: FontWeight.bold,
          fontFamily: 'HelveticaCondensed',
        ),
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
            padding: EdgeInsets.zero,
            width: 250.0,
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

  Widget _buildNotificationCard(Socio socio) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 0, 76, 128),
        ),
        borderRadius: BorderRadius.circular(8.0),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${socio.name} ${socio.lastName}',
                      style: const TextStyle(
                        fontFamily: 'HelveticaCondensed',
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      'Fecha: ${selectedDate.toString().split(' ')[0]}',
                      style: const TextStyle(
                        fontFamily: 'HelveticaCondensed',
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                const Text(
                  'Descripción del cambio:',
                  style: TextStyle(
                    fontFamily: 'HelveticaCondensed',
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 76, 128),
                  ),
                ),
                const SizedBox(height: 4.0),
                const Text(
                  'Aquí va la descripción detallada del cambio...',
                  style: TextStyle(
                    fontFamily: 'HelveticaCondensed',
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
