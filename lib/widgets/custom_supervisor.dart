import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextFormSupervisor extends StatefulWidget {
  final String label;
  final TextInputType inputType;
  final String content;
  const TextFormSupervisor({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.label,
    required this.inputType,
    required this.content,
  });
  _TextFormSupervisor createState() => _TextFormSupervisor();
}

class _TextFormSupervisor extends State<TextFormSupervisor> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.content;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.label,
          style: const TextStyle(
            fontFamily: "HelveticaCondensed",
            fontSize: 12,
            color: Color.fromARGB(255, 0, 76, 128),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          margin: const EdgeInsets.only(top: 5, bottom: 15),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 4, 54, 95),
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          height: 30,
          child: TextFormField(
            controller: _controller,
            enabled: false,
            textAlign: TextAlign.left,
            keyboardType: widget.inputType,
            cursorColor: const Color.fromARGB(255, 0, 76, 128),
            style: const TextStyle(
                fontFamily: "HelveticaCondensed", color: Colors.black),
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        ),
      ],
    );
  }
}
