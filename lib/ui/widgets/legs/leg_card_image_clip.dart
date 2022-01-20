import 'package:flutter/material.dart';
import 'package:pick/ui/shared/card_image_clip.dart';
import 'package:pick/ui/shared/palette.dart';

class LegCardImageClip extends StatelessWidget {
  const LegCardImageClip({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CardImageClip(clipRight: true),
      child: Container(
        color: Palette.shascoBlue,
        child: Icon(
          Icons.date_range,
          color: Palette.shascoGrey,
          size: 60,
        ),
      ),
    );
  }
}
