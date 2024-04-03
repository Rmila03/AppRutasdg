import 'package:flutter/material.dart';
import 'package:ruta_sdg/socio.dart';

class MotivoDialog extends StatelessWidget {
  final Socio socio;
  final Map<Socio, String> motivos;
  final ValueChanged<String> onMotivoChanged;

  const MotivoDialog({
    Key? key,
    required this.socio,
    required this.motivos,
    required this.onMotivoChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String motivo = motivos[socio] ?? '';
    return AlertDialog(
      title: const Text(
        'Agregar motivo',
        style: TextStyle(
          fontFamily: "HelveticaCondensed",
        ),
      ),
      content: TextField(
        onChanged: onMotivoChanged,
        controller: TextEditingController(text: motivo),
        cursorColor: Colors.black, // Cambia el color del cursor a negro
        decoration: const InputDecoration(
          hintText: 'Ingrese el motivo',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancelar',
            style: TextStyle(
              fontFamily: "HelveticaCondensed",
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Aceptar',
            style: TextStyle(
              fontFamily: "HelveticaCondensed",
            ),
          ),
        ),
      ],
    );
  }
}
