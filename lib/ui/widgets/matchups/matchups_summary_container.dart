import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/matchup/matchup.dart';
import 'package:pick/pick/picks_provider_old.dart';
import 'package:pick/palette.dart';

class MatchupsSummaryContainer extends HookConsumerWidget {
  const MatchupsSummaryContainer({
    Key? key,
    required this.matchups,
  }) : super(key: key);

  final List<Matchup> matchups;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Palette.shascoGrey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ref
                    .watch(selectedSegmentPicksStateProvider.notifier)
                    .savePicks(matchups: matchups);
              },
              child: const Text('Save Picks'),
            ),
          ],
        ),
      ),
    );
  }
}
