import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:pick/ui/widgets/logo/logo_image_clip.dart';

class LogoImageContainer extends StatelessWidget {
  const LogoImageContainer({
    Key? key,
    required this.logoSize,
    required this.strokeWidth,
    required this.square2Radius,
    required this.square7Radius,
  }) : super(key: key);

  final double logoSize;
  final double strokeWidth;
  final double square2Radius;
  final double square7Radius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LogoImageClip(strokeWidth: strokeWidth),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: logoSize,
          width: logoSize,
          child: LayoutGrid(
            rowGap: 12,
            columnGap: 12,
            areas: '''
                . 2 .
                . . .
                7 . .
              ''',
            rowSizes: [
              1.fr,
              1.fr,
              1.fr,
            ],
            columnSizes: [
              1.fr,
              1.fr,
              1.fr,
            ],
            children: [
              gridArea('2').containing(
                Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: square2Radius,
                    ),
                  ),
                ),
              ),
              gridArea('7').containing(
                Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: square7Radius,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
