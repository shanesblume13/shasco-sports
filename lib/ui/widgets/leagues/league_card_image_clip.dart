import 'package:flutter/material.dart';
import 'package:pick/ui/shared/card_image_clip.dart';

class LeagueCardImageClip extends StatelessWidget {
  const LeagueCardImageClip({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CardImageClip(clipRight: true),
      child: Image(
        height: 60,
        fit: BoxFit.cover,
        image: AssetImage(imagePath),
      ),
    );
  }
}
