import 'package:flutter/material.dart';
import 'package:pick/core/models/league_model.dart';
import 'package:pick/core/providers/league_view_model.dart';
import 'package:provider/provider.dart';

class SportCardLeagueCountContainer extends StatelessWidget {
  const SportCardLeagueCountContainer({
    Key? key,
    required this.sport,
  }) : super(key: key);

  final String sport;

  @override
  Widget build(BuildContext context) {
    final leagueProvider = Provider.of<LeagueViewModel>(context);
    final List<League> leagues = leagueProvider.fetchLeagues(sport: sport);
    final int leagueCount = leagues.length;

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
