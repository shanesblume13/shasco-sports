import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/gradient_scaffold.dart';
import 'package:pick/matchup/matchup_row_list_view.dart';
import 'package:pick/matchup/matchups_provider.dart';
import 'package:pick/matchup/matchups_summary_container.dart';
import 'package:pick/pick/pick.dart';
import 'package:pick/pick/picks_provider.dart';
import 'package:pick/segment/segment.dart';
import 'package:pick/segment/selected_segment_provider.dart';
import 'package:pick/team/team.dart';
import 'package:pick/team/teams_provider.dart';

class MatchupsView extends HookConsumerWidget {
  const MatchupsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Segment segment = ref.watch(selectedSegmentStateProvider)!;

    return GradientScaffold(
      appBarText: segment.name,
      body: ref.watch(matchupsBySelectedSegmentStateProvider).when(
            data: (matchups) {
              AsyncValue<List<Team>> teams =
                  ref.watch(teamsBySelectedLeagueStateProvider);

              return teams.when(
                data: (teams) {
                  AsyncValue<List<Pick>> picks =
                      ref.watch(picksBySelectedSegmentStateProvider);

                  return picks.when(
                    data: (picks) {
                      return Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: MatchupsSummaryContainer(matchups: matchups),
                          ),
                          Expanded(
                            flex: 5,
                            child: MatchupRowListView(
                              segment: segment,
                              matchups: matchups,
                              teams: teams,
                              picks: picks,
                            ),
                          ),
                        ],
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, s) =>
                        const Center(child: Text('Error getting picks!')),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, s) =>
                    const Center(child: Text('Error getting teams!')),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) =>
                const Center(child: Text('Error getting matchups!')),
          ),
    );
  }
}
