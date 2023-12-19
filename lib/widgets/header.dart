import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: 8,
          ),
          child: Image.asset(
            'assets/logo-sdg.png',
            width: 45,
            height: 45,
            fit: BoxFit.cover,
          ),
        ),
        const Text(
          'RUTASDG',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
