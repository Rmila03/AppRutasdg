import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String? label;
  final String? hint;
  final Color? borderColor;
  final double? lenItem;
  const CustomDropdown({
    super.key,
    required this.items,
    this.label,
    this.hint,
    this.borderColor,
    this.lenItem,
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
                      fontSize: 12,
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
                  height: 48,
                  color: Colors.white,
                  child: DropdownButtonFormField<String>(
                    value: _selectedItem,
                    dropdownColor: Colors.white,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 208, 208, 208),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: widget.borderColor ??
                              const Color.fromARGB(255, 208, 208, 208),
                          width: 2.0,
                        ),
                      ),
                    ),
                    icon: Icon(Icons.arrow_drop_down,
                        color: widget.borderColor ?? Colors.black),
                    items: widget.items
                        .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style:
                                    TextStyle(fontSize: widget.lenItem ?? 12)),
                          ),
                        )
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedItem = newValue;
                      });
                    },
                    hint: Text(
                      widget.hint ?? '',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 196, 196, 196),
                        fontSize: 15.0,
                        fontFamily: 'Unna-Bold',
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
