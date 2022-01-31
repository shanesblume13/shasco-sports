import 'package:flutter/material.dart';

class MatchupCardTeamImageClipper extends CustomClipper<Path> {
  MatchupCardTeamImageClipper({
    this.clipLeft = false,
    this.clipRight = false,
  });

  final bool clipLeft;
  final bool clipRight;

  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    Path path = Path();

    if (clipLeft && !clipRight) {
      return clipLeftPath(path, width, height);
    } else if (clipRight && !clipLeft) {
      return clipRightPath(path, width, height);
    }

    return path;
  }

  Path clipRightPath(Path path, double width, double height) {
    path.lineTo(0, 3);
    path.lineTo(width - 6, 3);
    path.quadraticBezierTo(width, 3, width, 9);
    path.lineTo(width * .75, height - 9);
    path.quadraticBezierTo(
      width * .75,
      height - 3,
      (width * .75) - 6,
      height - 3,
    );
    path.lineTo(0, height - 3);
    path.lineTo(0, 3);

    return path;
  }

  Path clipLeftPath(Path path, double width, double height) {
    path.lineTo(width, 3);
    path.lineTo(width * .25 + 6, 3);
    path.quadraticBezierTo(width * .25, 3, width * .25, 9);
    path.lineTo(0, height - 9);
    path.quadraticBezierTo(0, height - 3, 6, height - 3);
    path.lineTo(width, height - 3);
    path.lineTo(width, 3);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
