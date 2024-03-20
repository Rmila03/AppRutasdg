import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String? label;
  final String? hint;
  final Color? borderColor;
  final double? lenItem;
  final Function(String?)? onChanged;
  const CustomDropdown({
    super.key,
    required this.items,
    this.label,
    this.hint,
    this.borderColor,
    this.lenItem,
    this.onChanged,
  });

  @override
  CustomDropdownState createState() => CustomDropdownState();
}

class CustomDropdownState extends State<CustomDropdown> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          widget.label != null
              ? SizedBox(
                  width: 120,
                  child: Text(
                    widget.label ?? '',
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      color: Color.fromARGB(255, 0, 76, 128),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  color: const Color.fromRGBO(244, 244, 244, 1),
                  child: DropdownButtonFormField<String>(
                    value: _selectedItem,
                    dropdownColor: const Color.fromARGB(249, 232, 236, 240),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: widget.borderColor ??
                              const Color.fromARGB(255, 105, 105, 105),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: widget.borderColor ??
                              const Color.fromARGB(255, 105, 105, 105),
                          width: 1.0,
                        ),
                      ),
                    ),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: widget.borderColor ??
                          const Color.fromARGB(255, 105, 105, 105),
                    ),
                    items: widget.items
                        .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: widget.lenItem ?? 12),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedItem = newValue;
                      });
                      widget.onChanged!(newValue);
                    },
                    hint: Text(
                      widget.hint ?? '',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 76, 128),
                        fontSize: 15.0,
                        fontFamily: "Poppins",
                      ),
                    ),
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

class TextForm extends StatefulWidget {
  final String label;
  final TextInputType inputType;
  final String content;
  const TextForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.label,
    required this.inputType,
    required this.content,
  });
  _TextForm createState() => _TextForm();
}

class _TextForm extends State<TextForm> {
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
        SizedBox(
          height: 40,
          child: TextFormField(
            controller: _controller,
            enabled: false,
            keyboardType: widget.inputType,
            cursorColor: const Color.fromARGB(255, 0, 76, 128),
            style: const TextStyle(fontFamily: "Poppins", color: Colors.black),
          ),
        ),
        Text(
          widget.label,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 12,
            color: Color.fromARGB(255, 0, 76, 128),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class InputTextForm extends StatelessWidget {
  final String label;
  final String? percentage;
  const InputTextForm({
    super.key,
    required this.label,
    this.percentage = "",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 12,
              color: Color.fromARGB(255, 0, 76, 128),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(right: 10),
          height: 25,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(244, 244, 244, 1),
                    contentPadding: const EdgeInsets.symmetric(vertical: 4),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Bordes redondeados
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 79, 81, 82),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 79, 81, 82),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
