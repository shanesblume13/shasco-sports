import 'package:flutter/material.dart';

class SportCardLeagueCountContainer extends StatelessWidget {
  const SportCardLeagueCountContainer({
    Key? key,
    required this.sport,
  }) : super(key: key);

  final String sport;

  @override
  Widget build(BuildContext context) {
    const int leagueCount = 0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(leagueCount.toString()),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Leagues'),
          ],
        ),
      ],
    );
  }
}
