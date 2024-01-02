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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: _controller,
              enabled: false,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.white, width: 0),
                ),
              ),
              style: const TextStyle(color: Colors.black, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
