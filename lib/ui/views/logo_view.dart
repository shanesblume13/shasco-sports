import 'package:flutter/material.dart';
import 'package:pick/ui/widgets/logo/logo_image_container.dart';
import 'package:pick/ui/widgets/logo/logo_name_container.dart';

class LogoView extends StatefulWidget {
  const LogoView({
    Key? key,
  }) : super(key: key);

  @override
  State<LogoView> createState() => _LogoViewState();
}

class _LogoViewState extends State<LogoView> {
  double logoSize = 120;
  int animationStep = 0;
  double strokeWidth = 12;
  double logoTextSize = 0;
  double square2Radius = 0;
  double square7Radius = 0;

  @override
  void initState() {
    createAnimationFrames();

    super.initState();
  }

  void createAnimationFrames() {
    Future.delayed(const Duration(milliseconds: 500)).then(
      (value) => setState(
        () {
          //logoColor = Colors.red;
          square7Radius = 30;
        },
      ),
    );
    Future.delayed(const Duration(milliseconds: 1000)).then(
      (value) => setState(
        () {
          //logoColor = Colors.black;
          square7Radius = 0;
        },
      ),
    );
    Future.delayed(const Duration(milliseconds: 1500)).then(
      (value) => setState(
        () {
          //square2Color = Colors.grey;
          //logoColor = Colors.red;
          square7Radius = 30;
        },
      ),
    );
    Future.delayed(const Duration(milliseconds: 2000)).then(
      (value) => setState(
        () {
          //logoColor = Colors.black;
          square7Radius = 0;
        },
      ),
    );
    Future.delayed(const Duration(milliseconds: 2500)).then(
      (value) => setState(
        () {
          //logoColor = Colors.green;
          square2Radius = 30;
        },
      ),
    );
    Future.delayed(const Duration(milliseconds: 3500)).then(
      (value) => setState(
        () {
          //logoColor = Colors.black;
          logoSize = 30;
          strokeWidth = 6;
          square2Radius = 0;
        },
      ),
    );
    Future.delayed(const Duration(milliseconds: 4500)).then(
      (value) => setState(
        () {
          logoTextSize = 24;
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                LogoImageContainer(
                  logoSize: logoSize,
                  strokeWidth: strokeWidth,
                  square2Radius: square2Radius,
                  square7Radius: square7Radius,
                ),
                LogoNameContainer(logoTextSize: logoTextSize),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
