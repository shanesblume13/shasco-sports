import 'package:flutter/material.dart';
import 'package:pick/ui/shared/card_image_clip.dart';

class SportCardImageClip extends StatelessWidget {
  const SportCardImageClip({
    Key? key,
    required this.iconData,
    required this.iconColor,
  }) : super(key: key);

  final IconData iconData;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CardImageClip(clipRight: true),
      child: Container(
        color: Colors.black,
        child: Icon(
          iconData,
          color: iconColor,
          size: 60,
        ),
      ),
    );
  }
}
