import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/core/models/pick_model.dart';
import 'package:pick/core/models/team_model.dart';
import 'package:pick/core/providers/matchups_provider.dart';
import 'package:pick/core/providers/picks_provider.dart';
import 'package:pick/core/providers/teams_provider.dart';
import 'package:pick/segment/segment.dart';
import 'package:pick/ui/shared/gradient_scaffold.dart';
import 'package:pick/ui/widgets/matchups/matchup_cards_listview.dart';
import 'package:pick/ui/widgets/matchups/matchups_summary_container.dart';

class MatchupsView extends HookConsumerWidget {
  const MatchupsView({
    Key? key,
    required this.segment,
  }) : super(key: key);

  final Segment segment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Matchup>> matchups =
        ref.watch(selectedLegMatchupsStateProvider);

    return GradientScaffold(
      appBarText: segment.name,
      body: matchups.when(
        data: (matchups) {
          AsyncValue<List<Team>> teams =
              ref.watch(selectedLeagueTeamsStateProvider);

          return teams.when(
            data: (teams) {
              AsyncValue<List<Pick>> picks =
                  ref.watch(selectedLegPicksStateProvider);

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
                        child: MatchupCardsListview(
                          matchups: matchups,
                          teams: teams,
                          picks: picks,
                        ),
                      ),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, s) =>
                    const Center(child: Text('Error getting picks!')),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => const Center(child: Text('Error getting teams!')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => const Center(child: Text('Error getting matchups!')),
      ),
    );
  }
}
