import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/leg_matchup_count_model.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/providers/legs_provider.dart';

class LegCardMatchupCountContainer extends HookConsumerWidget {
  const LegCardMatchupCountContainer({
    Key? key,
    required this.leg,
  }) : super(key: key);

  final Leg leg;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<LegMatchupCount> legMatchupCounts =
        ref.watch(legMatchupCountsStateProvider);
    int legMatchupCount = legMatchupCounts
        .firstWhere((data) => data.leg.reference == leg.reference)
        .count;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(legMatchupCount.toString()),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Matchups'),
          ],
        ),
      ],
    );
  }
}
