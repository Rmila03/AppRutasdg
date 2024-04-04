import 'dart:core';
import 'package:flutter/material.dart';
import 'package:ruta_sdg/plandia.dart';
import 'package:ruta_sdg/listasocio.dart';
import 'package:ruta_sdg/socio.dart';
import 'package:ruta_sdg/widgets/header.dart';
import 'package:ruta_sdg/widgets/navigation_drawer.dart';
import 'package:ruta_sdg/widgets/tabbar.dart';

class SeguimientoPage extends StatefulWidget {
  const SeguimientoPage({super.key});

  @override
  State createState() => _SeguimientoPageState();
}

class _SeguimientoPageState extends State<SeguimientoPage> {
  final List<Socio> socios = getSocios();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 1,
        child: Scaffold(
          bottomNavigationBar: const BottomAppBar(
            child: TabBarBottom(),
          ),
          appBar: AppBar(
            title: const Header(),
            backgroundColor: const Color.fromARGB(255, 0, 76, 128),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          drawer: const MenuDrawer(),
          body: Column(
            children: [
              _buildHeader(),
              TabBar(
                tabs: [
                  _buildTab(
                    "Seguimiento",
                    textStyle: const TextStyle(
                      fontFamily: 'HelveticaCondensed',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                labelColor: const Color.fromARGB(255, 0, 76, 128),
                indicatorColor: const Color.fromARGB(255, 0, 76, 128),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildPromotionContent("CARTERA DE SEGUIMIENTO", socios),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String text, {TextStyle? textStyle}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }

  Widget _buildPromotionContent(String title, List<Socio> userList) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildDataTable(title, userList),
          // Puedes agregar más contenido específico de la pestaña aquí
        ],
      ),
    );
  }

  Widget _buildDataTable(String title, List<Socio> userList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFFD9D9D9)),
          borderRadius: BorderRadius.circular(0.0),
        ),
        color: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        child: SizedBox(
          height: 500,
          width: 600,
          child: SingleChildScrollView(
            child: DataTable(
              showCheckboxColumn: false,
              columnSpacing: 7.0,
              headingRowColor:
                  MaterialStateProperty.all(const Color(0xFFD9D9D9)),
              columns: const [
                DataColumn(
                  label: Text('DNI',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Nombres y Apellidos',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(label: Text('')),
              ],
              rows: userList
                  .where((user) => user.tipoGrupo == 'Seguimiento')
                  .map((user) {
                return DataRow(
                  onSelectChanged: (isSelected) {
                    if (isSelected != null && isSelected) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListaSocio(
                            tabColorLeft: Colors.orange,
                            tabName: 'SEGUIMIENTO',
                            socio: user,
                          ),
                        ),
                      );
                    }
                  },
                  cells: [
                    DataCell(Text(
                      user.dni,
                      style: const TextStyle(fontFamily: 'HelveticaCondensed'),
                    )),
                    DataCell(Text(
                      "${user.name} ${user.lastName}",
                      style: const TextStyle(fontFamily: 'HelveticaCondensed'),
                    )),
                    const DataCell(Icon(Icons.check)),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 20, right: 5),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(0)),
        color: Color.fromARGB(255, 0, 76, 128),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 5),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyPlanDiarioPage(title: ""),
                  ),
                );
              },
              child: const Text(
                "PLAN DEL DIA",
                style: TextStyle(
                  fontFamily: 'HelveticaCondensed',
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
