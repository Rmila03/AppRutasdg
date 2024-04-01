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
            'assets/NuevoLogo.png',
            width: 90,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        const Text(
          'RUTASDG',
          style: TextStyle(
            fontFamily: "HelveticaCondensed",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
