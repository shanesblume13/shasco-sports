import 'package:flutter/material.dart';

class MatchupCardTeamDividerClipper extends CustomClipper<Path> {
  MatchupCardTeamDividerClipper({
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
    path.lineTo(width, 0);
    path.lineTo(width * .25, 0);
    path.lineTo(0, height * .5);
    path.lineTo(width * .25, height);
    path.lineTo(width, height);
    path.lineTo(width, 0);

    return path;
  }

  Path clipLeftPath(Path path, double width, double height) {
    path.lineTo(0, 0);
    path.lineTo(width * .75, 0);
    path.lineTo(width, height * .5);
    path.lineTo(width * .75, height);
    path.lineTo(0, height);
    path.lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
