import 'package:flutter/material.dart';
import 'package:pick/ui/shared/palette.dart';

class TeamImageClip extends StatelessWidget {
  const TeamImageClip({
    Key? key,
    required this.imagePath,
    required this.hasPick,
    required this.isPicked,
    required this.isHome,
  }) : super(key: key);

  final String imagePath;
  final bool hasPick;
  final bool isPicked;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: isHome ? MyCustomClipper2() : MyCustomClipper(),
      child: Image(
        height: 60,
        fit: BoxFit.cover,
        color: !hasPick
            ? Colors.transparent
            : isPicked
                ? Colors.transparent
                : Palette.shascoGrey,
        colorBlendMode: BlendMode.hardLight,
        image: AssetImage(imagePath),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    Path path = Path();

    path.lineTo(0, 3);
    path.lineTo(width - 6, 3);
    path.quadraticBezierTo(width, 3, width, 9);
    path.lineTo(width * .75, height - 9);
    path.quadraticBezierTo(
        width * .75, height - 3, (width * .75) - 6, height - 3);
    path.lineTo(0, height - 3);
    path.lineTo(0, 3);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class MyCustomClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    Path path = Path();

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
