import 'package:flutter/material.dart';

class LogoView extends StatefulWidget {
  const LogoView({
    Key? key,
  }) : super(key: key);

  @override
  State<LogoView> createState() => _LogoViewState();
}

class _LogoViewState extends State<LogoView> {
  Color color = Colors.red;
  int colorStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Animated Logo'),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            switch (colorStep) {
              case 0:
                color = Colors.green;
                colorStep = 1;
                break;
              case 1:
                color = Colors.blue;
                colorStep = 2;
                break;
              case 2:
                color = Colors.red;
                colorStep = 0;
                break;
            }
          });
        },
        child: Center(
          child: AnimatedContainer(
            width: 60,
            height: 60,
            color: color,
            duration: const Duration(milliseconds: 500),
          ),
        ),
      ),
    );
  }
}
