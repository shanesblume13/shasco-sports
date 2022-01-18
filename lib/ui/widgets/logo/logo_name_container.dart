import 'package:flutter/material.dart';

class LogoNameContainer extends StatelessWidget {
  const LogoNameContainer({
    Key? key,
    required this.logoTextSize,
  }) : super(key: key);

  final double logoTextSize;

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 100),
      style: TextStyle(
        fontSize: logoTextSize,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Colors.black,
      ),
      child: const Text(
        'Shasco Sports',
      ),
    );
  }
}
