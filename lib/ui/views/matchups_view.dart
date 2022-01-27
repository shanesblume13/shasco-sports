import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/core/models/pick_model.dart';
import 'package:pick/core/models/team_model.dart';
import 'package:pick/core/providers/matchups_provider.dart';
import 'package:pick/core/providers/picks_provider.dart';
import 'package:pick/core/providers/teams_provider.dart';
import 'package:pick/ui/widgets/matchups/matchup_cards_listview.dart';

class MatchupsView extends HookConsumerWidget {
  const MatchupsView({
    Key? key,
    required this.leg,
  }) : super(key: key);

  final Leg leg;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Matchup>> matchups =
        ref.watch(selectedLegMatchupsStateProvider);

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     Navigator.pushNamed(context, '/addLeg');
      //   },
      // ),
      appBar: AppBar(
        title: Center(
          child: Text(leg.name),
        ),
      ),
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
                        child: MatchupCardsListview(
                          matchups: matchups,
                          teams: teams,
                          picks: picks,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              child: const Text('Save Picks'),
                              onPressed: () {
                                ref
                                    .watch(
                                        selectedLegPicksStateProvider.notifier)
                                    .savePicks(matchups: matchups);
                              },
                            ),
                          ],
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
