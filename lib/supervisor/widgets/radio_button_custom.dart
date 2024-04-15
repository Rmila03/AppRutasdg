import 'package:flutter/material.dart';

class RadioButtonCustom extends StatefulWidget {
  final String option1;
  final String option2;
  final void Function(int)? onValueChanged;
  const RadioButtonCustom(
      {super.key,
      this.onValueChanged,
      required this.option1,
      required this.option2});

  @override
  _RadioButtonCustomState createState() => _RadioButtonCustomState();
}

class _RadioButtonCustomState extends State<RadioButtonCustom> {
  int selectedButton = 0;
  String selectedOption = '';
  List<String> menuOptions = [
    'Crédito 1',
    'Crédito 2',
    'Crédito 3',
    'Crédito 4'
  ];
  @override
  Widget build(BuildContext context) {
    var container = Container(
      height: 50,

      //padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButton<String>(
        value: selectedOption.isNotEmpty ? selectedOption : null,
        items: menuOptions.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontFamily: "HelveticaCondensed",
              ),
            ),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            selectedOption = value ?? '';
          });
        },
        hint: const Text(
          'Seleccionar nro de crédito',
          style: TextStyle(
            color: Color.fromARGB(255, 196, 196, 196),
            fontSize: 15.0,
            fontFamily: "HelveticaCondensed",
          ),
        ),
      ),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedButton = 1;
                  });
                  if (widget.onValueChanged != null) {
                    widget.onValueChanged!(selectedButton);
                  }
                },
                child: Container(
                  width: 150,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                  margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: const Color.fromARGB(255, 185, 185, 185),
                      width: 1,
                    ),
                    color: selectedButton == 1
                        ? const Color.fromARGB(255, 4, 54, 95)
                        : Colors.white,
                  ),
                  child: Text(
                    widget.option1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "HelveticaCondensed",
                      color: selectedButton == 1
                          ? Colors.white
                          : Colors
                              .black, // Cambia el color del texto según el estado del botón
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedButton = 2;
                  });
                  if (widget.onValueChanged != null) {
                    widget.onValueChanged!(selectedButton);
                  }
                },
                child: Container(
                  width: 150,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: const Color.fromARGB(255, 185, 185, 185),
                      width: 1,
                    ),
                    color: selectedButton == 2
                        ? const Color.fromARGB(255, 4, 54, 95)
                        : Colors.white,
                  ),
                  child: Text(
                    widget.option2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "HelveticaCondensed",
                      color: selectedButton == 2
                          ? Colors.white
                          : Colors
                              .black, // Cambia el color del texto según el estado del botón
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 50),
            child: container,
          ),
        ),
      ],
    );
  }
}
