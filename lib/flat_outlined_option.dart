import 'package:flutter/material.dart';
import 'package:pick/palette.dart';

class FlatBorderOption extends StatelessWidget {
  const FlatBorderOption({
    Key? key,
    required this.child,
    this.color,
    this.borderColor,
  }) : super(key: key);

  final Widget child;
  final Color? color;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final kInnerDecoration = BoxDecoration(
      color: color ?? Palette.shascoGrey[50],
      borderRadius: BorderRadius.circular(10),
    );

    final kGradientBoxDecoration = BoxDecoration(
      border: Border.all(
        color: borderColor ?? Palette.shascoBlue,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(12),
    );

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        clipBehavior: Clip.hardEdge,
        decoration: kGradientBoxDecoration,
        height: 64,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: kInnerDecoration,
          child: child,
        ),
      ),
    );
  }
}
