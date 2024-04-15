import 'package:flutter/material.dart';

class TextFormResult extends StatefulWidget {
  final String label;
  final String content;
  const TextFormResult({
    super.key,
    required this.label,
    required this.content,
  });
  _TextFormResult createState() => _TextFormResult();
}

class _TextFormResult extends State<TextFormResult> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.content;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.bottomLeft,
          child: Text(
            widget.label,
            style: const TextStyle(
              fontFamily: "HelveticaCondensed",
              fontSize: 12,
              color: Color.fromARGB(255, 0, 76, 128),
            ),
          ),
        ),
        SizedBox(
          height: 30,
          child: TextFormField(
            controller: _controller,
            enabled: false,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromRGBO(244, 244, 244, 1),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                    width: 2.0, color: Color.fromARGB(255, 0, 76, 128)),
              ),
            ),
            style: const TextStyle(
                fontFamily: "HelveticaCondensed",
                color: Colors.black,
                fontSize: 13),
          ),
        ),
      ],
    );
  }
}
