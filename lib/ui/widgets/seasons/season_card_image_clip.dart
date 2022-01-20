import 'package:flutter/material.dart';
import 'package:pick/ui/shared/card_image_clip.dart';
import 'package:pick/ui/shared/palette.dart';

class SeasonCardImageClip extends StatelessWidget {
  const SeasonCardImageClip({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CardImageClip(clipRight: true),
      child: Container(
        color: Palette.shascoBlue,
        child: Icon(
          Icons.calendar_today,
          color: Palette.shascoGrey,
          size: 60,
        ),
      ),
    );
  }
}
