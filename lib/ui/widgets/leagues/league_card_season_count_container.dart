import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/league_season_count.dart';
import 'package:pick/core/providers/leagues_provider.dart';

class LeagueCardSeasonCountContainer extends HookConsumerWidget {
  const LeagueCardSeasonCountContainer({
    Key? key,
    required this.league,
  }) : super(key: key);

  final String league;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<LeagueSeasonCount> leagueSeasonCounts =
        ref.watch(leagueSeasonCountsStateProvider);
    int leagueSeasonCount = leagueSeasonCounts
        .firstWhere(
            (data) => data.league.name.toLowerCase() == league.toLowerCase())
        .count;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(leagueSeasonCount.toString()),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Seasons'),
          ],
        ),
      ],
    );
  }
}
