import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/providers/sports_provider.dart';

class SportCardLeagueCountContainer extends HookConsumerWidget {
  const SportCardLeagueCountContainer({
    Key? key,
    required this.sport,
  }) : super(key: key);

  final String sport;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var sportLeagueCount = ref.watch(sportLeagueCountsProvider);
    var test = sportLeagueCount
        .firstWhere(
            (data) => data.sport.name.toLowerCase() == sport.toLowerCase())
        .count;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(test.toString()),
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
