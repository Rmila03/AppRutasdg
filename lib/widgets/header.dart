import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(),
          child: Image.asset(
            'assets/logo_sdg.png',
            width: 35,
            height: 35,
            fit: BoxFit.cover,
          ),
        ),
        const Text(
          'RUTASDG',
          style: TextStyle(
            fontFamily: "HelveticaCondensed",
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
