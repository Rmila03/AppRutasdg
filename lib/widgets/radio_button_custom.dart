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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedButton = 1;
              });
              if (widget.onValueChanged != null) {
                widget.onValueChanged!(selectedButton);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color.fromARGB(255, 185, 185, 185),
                  width: 1,
                ),
                color: selectedButton == 1 ? Colors.green : Colors.white,
              ),
              child: Text(
                widget.option1,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedButton = 2;
              });
              if (widget.onValueChanged != null) {
                widget.onValueChanged!(selectedButton);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color.fromARGB(255, 185, 185, 185),
                  width: 1,
                ),
                color: selectedButton == 2 ? Colors.orange : Colors.white,
              ),
              child: Text(
                widget.option2,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
