import 'package:flutter/material.dart';

class LogoSquareImageClip extends CustomPainter {
  LogoSquareImageClip({
    required this.color,
  });

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;
    Path path = Path();
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(clipRightPath(path, width, height), paint);
  }

  Path clipRightPath(Path path, double width, double height) {
    path.lineTo(0, 0);
    path.lineTo(width - 6, 0);
    path.quadraticBezierTo(width, 0, width, 6);
    path.lineTo(width * .75, height - 6);
    path.quadraticBezierTo(
        (width * .75) - 3, height, (width * .75) - 6, height);
    path.lineTo(0, height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldPainter) => true;
}
