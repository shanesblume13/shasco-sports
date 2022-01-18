import 'package:flutter/material.dart';
import 'package:pick/ui/shared/palette.dart';

class LogoNameContainer extends StatelessWidget {
  const LogoNameContainer({
    Key? key,
    required this.logoTextSize,
    required this.logoTextColor,
  }) : super(key: key);

  final double logoTextSize;
  final Color logoTextColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 300),
      style: TextStyle(
        fontSize: logoTextSize,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: logoTextColor,
      ),
      child: const Text(
        'Shasco Sports',
      ),
    );
  }
}
