import 'package:flutter/material.dart';
import 'package:pick/ui/shared/card_image_clip.dart';
import 'package:pick/ui/shared/palette.dart';

class GameCardImageClip extends StatelessWidget {
  const GameCardImageClip({
    Key? key,
    required this.iconData,
  }) : super(key: key);

  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CardImageClip(clipRight: true),
      child: Container(
        color: Palette.shascoBlue,
        child: Icon(
          iconData,
          color: Colors.white,
          size: 60,
        ),
      ),
    );
  }
}
