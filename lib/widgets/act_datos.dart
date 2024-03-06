import 'package:flutter/material.dart';

class ActualizarCustom extends StatefulWidget {
  const ActualizarCustom({super.key});

  @override
  _ActualizarCustomState createState() => _ActualizarCustomState();
}

class _ActualizarCustomState extends State<ActualizarCustom> {
  int selectedButton = 0; // Inicialmente ningún botón seleccionado

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          //width: 600,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // Bordes redondeados
            border: Border.all(
              color: const Color.fromRGBO(160, 218, 183, 1), // Color del borde
              width: 3, // Grosor del borde
            ),
            color: const Color.fromRGBO(160, 218, 183, 1),
          ),
          child: const Center(
            child: Text(
              '¿Necesita actualizar dato(s)?',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedButton = 1; // Primer botón seleccionado
              });
            },
            child: Container(
              //padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), // Bordes redondeados
                border: Border.all(
                  color:
                      const Color.fromRGBO(150, 158, 153, 1), // Color del borde
                  width: 1, // Grosor del borde
                ),
                color: selectedButton == 1
                    ? const Color.fromRGBO(150, 158, 153, 1)
                    : Colors.white,
              ),
              child: const Center(
                child: Text(
                  'SI',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedButton = 2; // Segundo botón seleccionado
              });
            },
            child: Container(

                //padding:const EdgeInsets.symmetric(vertical: 2, horizontal: 40),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), // Bordes redondeados
                  border: Border.all(
                    color: const Color.fromRGBO(
                        150, 158, 153, 1), // Color del borde
                    width: 1, // Grosor del borde
                  ),
                  color: selectedButton == 2
                      ? const Color.fromRGBO(150, 158, 153, 1)
                      : Colors.white,
                ),
                child: const Center(
                  child: Text(
                    'NO',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ),
        ),
      ],
    );
  }
}

class Encontro extends StatefulWidget {
  const Encontro({super.key});

  @override
  _Encontro createState() => _Encontro();
}

class _Encontro extends State<Encontro> {
  int selectedButton = 0; // Inicialmente ningún botón seleccionado

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedButton = 1; // Primer botón seleccionado
              });
            },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), // Bordes redondeados
                  border: Border.all(
                    color: const Color.fromRGBO(
                        150, 158, 153, 1), // Color del borde
                    width: 1.5, // Grosor del borde
                  ),
                  color: selectedButton == 1
                      ? const Color.fromRGBO(150, 158, 153, 1)
                      : Colors.white,
                ),
                child: const Center(
                  child: Text(
                    'SE ENCONTRÓ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedButton = 2; // Segundo botón seleccionado
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // Bordes redondeados
                border: Border.all(
                  color:
                      const Color.fromRGBO(150, 158, 153, 1), // Color del borde
                  width: 1.5, // Grosor del borde
                ),
                color: selectedButton == 2
                    ? const Color.fromRGBO(150, 158, 153, 1)
                    : Colors.white,
              ),
              child: const Center(
                child: Text(
                  'NO SE ENCONTRÓ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
