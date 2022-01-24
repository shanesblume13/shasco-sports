import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/sport_league_count.dart';
import 'package:pick/core/providers/sports_provider.dart';

class SportCardLeagueCountContainer extends HookConsumerWidget {
  const SportCardLeagueCountContainer({
    Key? key,
    required this.sport,
  }) : super(key: key);

  final String sport;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<SportLeagueCount> sportLeagueCounts =
        ref.watch(sportLeagueCountsStateProvider);
    int sportLeagueCount = sportLeagueCounts
        .firstWhere(
            (data) => data.sport.name.toLowerCase() == sport.toLowerCase())
        .count;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(sportLeagueCount.toString()),
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
