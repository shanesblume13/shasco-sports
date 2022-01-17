import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:pick/ui/shared/logo_square_image_clip.dart';

class LogoView extends StatefulWidget {
  const LogoView({
    Key? key,
  }) : super(key: key);

  @override
  State<LogoView> createState() => _LogoViewState();
}

class _LogoViewState extends State<LogoView> {
  Color square2Color = Colors.blue;
  Color square7Color = Colors.transparent;
  Color logoColor = Colors.black;
  double logoSize = 120;
  Alignment logoAlignment = Alignment.center;
  int colorStep = 0;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500)).then(
      (value) => setState(
        () {
          square7Color = Colors.red;
        },
      ),
    );
    Future.delayed(const Duration(milliseconds: 1000)).then(
      (value) => setState(
        () {
          square7Color = Colors.transparent;
        },
      ),
    );
    Future.delayed(const Duration(milliseconds: 1500)).then(
      (value) => setState(
        () {
          square7Color = Colors.red;
        },
      ),
    );
    Future.delayed(const Duration(milliseconds: 2000)).then(
      (value) => setState(
        () {
          square7Color = Colors.transparent;
        },
      ),
    );
    Future.delayed(const Duration(milliseconds: 2500)).then(
      (value) => setState(
        () {
          square2Color = Colors.green;
          logoColor = Colors.green;
        },
      ),
    );
    Future.delayed(const Duration(milliseconds: 3500)).then(
      (value) => setState(
        () {
          square2Color = Colors.transparent;
          logoSize = 30;
          logoAlignment = Alignment.centerLeft;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Animated Logo'),
        ),
      ),
      body: Center(
        child: AnimatedAlign(
          alignment: logoAlignment,
          duration: const Duration(milliseconds: 1000),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: LogoSquare(
              logoSize: logoSize,
              logoColor: logoColor,
              square2Color: square2Color,
              square7Color: square7Color,
            ),
          ),
        ),
      ),
    );
  }
}

class LogoSquare extends StatelessWidget {
  const LogoSquare({
    Key? key,
    required this.logoSize,
    required this.logoColor,
    required this.square2Color,
    required this.square7Color,
  }) : super(key: key);

  final double logoSize;
  final Color logoColor;
  final Color square2Color;
  final Color square7Color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LogoSquareImageClip(color: logoColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
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
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  child: CircleAvatar(
                    backgroundColor: square2Color,
                  ),
                ),
              ),
              gridArea('7').containing(
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  child: CircleAvatar(
                    backgroundColor: square7Color,
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
