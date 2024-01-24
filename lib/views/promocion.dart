import 'dart:core';
import 'package:flutter/material.dart';
import 'package:ruta_sdg/plandia.dart';
import 'package:ruta_sdg/listasocio.dart';
import 'package:ruta_sdg/socio.dart';
import 'package:ruta_sdg/widgets/header.dart';
import 'package:ruta_sdg/widgets/navigation_drawer.dart';
import 'package:ruta_sdg/widgets/tabbar.dart';

class PromocionPage extends StatefulWidget {
  const PromocionPage({super.key});

  @override
  State createState() => _PromocionPageState();
}

class _PromocionPageState extends State<PromocionPage> {
  final List<Socio> socios = getSocios();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
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
              _buildPromotionCard(),
              TabBar(
                tabs: [
                  _buildTab("Promoción"),
                  _buildTab("Ampliación"),
                ],
                labelColor: const Color.fromARGB(255, 0, 76, 128),
                indicatorColor: const Color.fromARGB(255, 0, 76, 128),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildPromotionContent("CARTERA DE PROMOCIÓN", socios),
                    _buildPromotionContent("CARTERA DE AMPLIACIÓN", socios),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String text) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Text(text),
    );
  }

  Widget _buildPromotionContent(String title, List<Socio> userList) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildCarteraBox(title),
          _buildDataTable(title, userList),
          // Puedes agregar más contenido específico de la pestaña aquí
        ],
      ),
    );
  }

  Widget _buildCarteraBox(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 5,
        shadowColor: const Color.fromARGB(255, 5, 5, 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 1.0,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataTable(String title, List<Socio> userList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFFD9DEDA)),
          borderRadius: BorderRadius.circular(0.0),
        ),
        color: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        child: SizedBox(
          height: 200,
          width: 600,
          child: SingleChildScrollView(
            child: DataTable(
              showCheckboxColumn: false,
              columnSpacing: 7.0,
              headingRowColor:
                  MaterialStateProperty.all(const Color(0xFFD9DEDA)),
              columns: const [
                DataColumn(label: Text('N°')),
                DataColumn(label: Text('DNI')),
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('')),
              ],
              rows: userList
                  .where((user) => user.tipoGrupo == 'Promoción')
                  .map((user) {
                return DataRow(
                  onSelectChanged: (isSelected) {
                    if (isSelected != null && isSelected) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListaSocio(
                            tabColorLeft: Colors.orange,
                            tabName: 'PROMOCIÓN',
                            socio: user,
                          ),
                        ),
                      );
                    }
                  },
                  cells: [
                    DataCell(Text(user.idSocio)),
                    DataCell(Text(user.dni)),
                    DataCell(Text("${user.name} ${user.lastName}")),
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
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(0),
        ),
        color: Color.fromARGB(255, 0, 76, 128),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(
                top: 10, bottom: 5), // Ajusta el margen inferior aquí
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 2),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
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
                  fontSize: 18,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 5,
        shadowColor: const Color.fromARGB(255, 5, 5, 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
