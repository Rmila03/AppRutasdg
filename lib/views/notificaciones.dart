import 'package:flutter/material.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'package:ruta_sdg/widgets/header.dart';
import 'package:ruta_sdg/widgets/tabbar.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 209, 200, 224)),
        useMaterial3: true,
      ),
      home: const NotificacionPage(title: ""),
    );
  }
}

class NotificacionPage extends StatefulWidget {
  const NotificacionPage({super.key, required this.title});
  final String title;

  @override
  State<NotificacionPage> createState() => _NotificacionPageState();
}

class _NotificacionPageState extends State<NotificacionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomAppBar(
        child: TabBarBottom(),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.only(
                left: 20,
                right: 5,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.zero,
                ),
                color: Color.fromARGB(255, 0, 76, 128),
              ),
              child: const Row(
                children: [
                  Column(
                    children: [
                      Header(),
                    ],
                  ),
                ],
              ),
            ),
            //Container(child: Column(children: <Widget>[_list()])),
            Expanded(
                child: ListView.separated(
              itemCount: 15,
              itemBuilder: (BuildContext context, int index) =>
                  _item("Alerta de retraso ", "Justino Ferro Alvarez", 15),
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  color:
                      const Color.fromARGB(255, 45, 49, 62).withOpacity(0.15),
                  height: 8.0,
                );
              },

              /*children: <Widget>[
                _item("Alerta de retraso 1", "Justino Ferro Alvarez", 15),
                _item("Alerta de retraso 2", "Stiward Maldonado", 1),
                _item("Alerta de retraso 3", "Ruth Milagros Arce Quispe", 4),
                _item("Alerta de retraso 4", "Yolmy Milagros Cahuata Lavilla", 2),
                _item("Alerta de retraso 5", "Yanet Cusi Quispe", 5),
                _item("Alerta de retraso 6", "Glina de la Flor Puma Huamani", 7),
                _item("Alerta de retraso 7", "Yerson Chirinos Vilca", 8)
              ],*/
            ))
          ],
        ),
      ),
    );
  }
}

Widget _item(String nameAlert, String nameSocio, int dias) {
  return ListTile(
    leading: const Icon(
      FontAwesomeIcons.bell,
      size: 25.0,
      color: Colors.red,
    ),
    title: Text(
      nameAlert,
      style: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.black),
    ),
    subtitle: Text(
      nameSocio,
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
          color: Color.fromARGB(255, 7, 62, 90)),
    ),
    trailing: Container(
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "$dias dias",
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.0),
        ),
      ),
    ),
  );
}

/*Widget _list() {
  return Expanded(
      child: ListView(
    children: <Widget>[
      _item(FontAwesomeIcons.bell, "Alerta 1", 3),
      _item(FontAwesomeIcons.bell, "Alerta 2", 3),
      _item(FontAwesomeIcons.bell, "Alerta 3", 3),
      _item(FontAwesomeIcons.bell, "Alerta 4", 3)
    ],
  ));
}*/

class MapButton extends StatelessWidget {
  final String name;
  const MapButton({
    super.key,
    required this.name,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: GestureDetector(
        onTap: () {},
        child: Column(
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 0, 76, 128),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextContainer extends StatelessWidget {
  final String text;
  final IconData leftIcon;
  final IconData rightIcon;
  final Color shadowColor;

  const CustomTextContainer({
    Key? key,
    required this.text,
    required this.leftIcon,
    this.rightIcon = FontAwesomeIcons.greaterThan,
    this.shadowColor =
        const Color.fromRGBO(0, 0, 0, 0.3), // Valor predeterminado
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270.0,
      height: 50.0,
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.zero,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                leftIcon,
                color: Colors.black,
              ),
              const SizedBox(width: 8),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                rightIcon,
                color: Colors.black,
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
