import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/gradient_scaffold.dart';
import 'package:pick/matchup/matchup.dart';
import 'package:pick/matchup/matchup_row.dart';
import 'package:pick/matchup/matchups_provider.dart';
import 'package:pick/matchup/matchups_summary_container.dart';
import 'package:pick/segment/segment.dart';
import 'package:pick/segment/selected_segment_provider.dart';

class MatchupsView extends HookConsumerWidget {
  const MatchupsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Segment segment = ref.watch(selectedSegmentProvider)!;

    return GradientScaffold(
      appBarText: segment.name,
      body: ref.watch(matchupsBySelectedSegmentStateProvider).when(
            data: (matchups) => Column(
              children: [
                Expanded(
                  flex: 1,
                  child: MatchupsSummaryContainer(matchups: matchups),
                ),
                Expanded(
                  flex: 5,
                  child: getMatchupCardListView(
                    context: context,
                    ref: ref,
                    segment: segment,
                    matchups: matchups,
                  ),
                ),
              ],
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) =>
                const Center(child: Text('Error getting matchups!')),
          ),
    );
  }

  Widget getMatchupCardListView({
    required BuildContext context,
    required WidgetRef ref,
    required Segment segment,
    required List<Matchup> matchups,
  }) {
    final List<Widget> matchupCards = [];

    for (var matchup in matchups) {
      matchupCards.add(
        MatchupRow(
          matchup: matchup,
        ),
      );
    }

    return ListView(children: matchupCards);
  }
}
