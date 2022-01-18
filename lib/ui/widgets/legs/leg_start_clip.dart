import 'package:flutter/material.dart';

class LegStartClip extends StatelessWidget {
  const LegStartClip({
    Key? key,
    required this.startDate,
  }) : super(key: key);

  final String startDate;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyCustomClipper(),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 60,
              color: Colors.black,
            ),
            Text(
              startDate.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
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
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
