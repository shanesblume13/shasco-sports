import 'package:flutter/material.dart';
import 'package:pick/ui/shared/palette.dart';

class GradientScaffold extends StatelessWidget {
  const GradientScaffold({
    Key? key,
    this.appBarText,
    this.body,
  }) : super(key: key);

  final String? appBarText;
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Palette.shascoGrey[500]!,
            Palette.shascoBlue,
            Palette.shascoBlue[900]!,
          ],
          center: Alignment.center,
          radius: 6,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(appBarText ?? ''),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: body ?? Container(),
      ),
    );
  }
}
