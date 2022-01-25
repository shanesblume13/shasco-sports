import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/season_leg_count_model.dart';
import 'package:pick/core/models/season_model.dart';
import 'package:pick/core/providers/seasons_provider.dart';

class SeasonCardLegCountContainer extends HookConsumerWidget {
  const SeasonCardLegCountContainer({
    Key? key,
    required this.season,
  }) : super(key: key);

  final Season season;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<SeasonLegCount> seasonLegCounts =
        ref.watch(seasonLegCountsStateProvider);
    int seasonLegCount = seasonLegCounts
        .firstWhere((data) => data.season.reference == season.reference)
        .count;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(seasonLegCount.toString()),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Legs'),
          ],
        ),
      ],
    );
  }
}
