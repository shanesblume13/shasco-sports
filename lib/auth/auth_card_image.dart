import 'package:flutter/material.dart';
import 'package:pick/card_image_clipper.dart';
import 'package:pick/palette.dart';

class AuthCardImage extends StatelessWidget {
  const AuthCardImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CardImageClipper(clipRight: true),
      child: Container(
        color: Colors.black,
        child: Icon(
          Icons.sports,
          color: Palette.shascoGrey[50]!,
          size: 60,
        ),
      ),
    );
  }
}
