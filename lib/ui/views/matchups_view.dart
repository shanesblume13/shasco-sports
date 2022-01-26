import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/core/providers/matchups_provider.dart';
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
        ref.watch(matchupsByLegStateProvider(leg));

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
        data: (matchups) => MatchupCardsListview(matchups: matchups),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => const Center(child: Text('Error getting matchups!')),
      ),
    );
  }
}
