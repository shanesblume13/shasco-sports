import 'package:flutter/material.dart';
// import 'packages:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

class MatchupPickScoreDivider extends StatelessWidget {
  const MatchupPickScoreDivider({
    Key? key,
    required this.homePicked,
    required this.awayPicked,
    required this.pickScore,
  }) : super(key: key);

  final bool homePicked;
  final bool awayPicked;
  final String pickScore;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: homePicked || awayPicked ? Colors.black : Colors.transparent,
            width: 3.0,
          ),
          bottom: BorderSide(
            color: homePicked || awayPicked ? Colors.black : Colors.transparent,
            width: 3.0,
          ),
        ),
      ),
      duration: const Duration(milliseconds: 300),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 60,
            width: 0,
            color: Colors.black,
          ),
          ClipPath(
            clipper: homePicked
                ? MyCustomClipper3()
                : awayPicked
                    ? MyCustomClipper4()
                    : null,
            child: Container(
              width: 30,
              height: 48,
              color: homePicked || awayPicked ? Colors.black : Colors.white,
              child: Center(
                child: Text(
                  pickScore,
                  style: TextStyle(
                    fontSize: 15,
                    color:
                        homePicked || awayPicked ? Colors.white : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyCustomClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    Path path = Path();

    path.lineTo(0, 0);
    path.lineTo(width * .75, 0);
    path.lineTo(width, height * .5);
    path.lineTo(width * .75, height);
    path.lineTo(0, height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class MyCustomClipper4 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    Path path = Path();

    path.lineTo(width, 0);
    path.lineTo(width * .25, 0);
    path.lineTo(0, height * .5);
    path.lineTo(width * .25, height);
    path.lineTo(width, height);
    path.lineTo(width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
