import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/flat_outlined_option.dart';
import 'package:pick/matchup/matchup.dart';
import 'package:pick/palette.dart';
import 'package:pick/pick/picks_provider.dart';

class MatchupsSummaryContainer extends HookConsumerWidget {
  const MatchupsSummaryContainer({
    Key? key,
    required this.matchups,
  }) : super(key: key);

  final List<Matchup> matchups;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Palette.shascoGrey[900],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlinedButton(
              onPressed: () => resetPicks(
                ref: ref,
              ),
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Undo Changes'),
            ),
            ElevatedButton(
              onPressed: () => savePicks(
                ref: ref,
              ),
              child: const Text('Save Picks'),
            ),
          ],
        ),
      ),
    );
  }

  void savePicks({required WidgetRef ref}) async {
    ref.watch(picksBySelectedSegmentStateProvider.notifier).saveSegmentPicks();
  }

  void resetPicks({required WidgetRef ref}) async {
    ref.watch(picksBySelectedSegmentStateProvider.notifier).resetSegmentPicks();
  }
}
