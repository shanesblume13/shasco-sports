import 'package:flutter/material.dart';

class LeagueCardSeasonCountContainer extends StatelessWidget {
  const LeagueCardSeasonCountContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('0'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Active Seasons'),
          ],
        ),
      ],
    );
  }
}
