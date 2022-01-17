import 'package:flutter/material.dart';
import 'package:pick/ui/shared/card_image_clip.dart';

class AuthCardImageClip extends StatelessWidget {
  const AuthCardImageClip({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CardImageClip(clipRight: true),
      child: Container(
        color: Colors.black,
        child: const Icon(
          Icons.sports,
          color: Colors.white,
          size: 60,
        ),
      ),
    );
  }
}
