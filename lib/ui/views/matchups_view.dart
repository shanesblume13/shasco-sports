import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/core/providers/legs_provider.dart';
import 'package:pick/core/providers/matchups_provider.dart';
import 'package:pick/ui/widgets/matchups/matchup_cards_listview.dart';

class MatchupsView extends HookConsumerWidget {
  const MatchupsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Matchup>> matchups =
        ref.watch(matchupsBySelectedLegStateProvider);
    final Leg? selectedLeg = ref.watch(selectedLegStateProvider);

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     Navigator.pushNamed(context, '/addLeg');
      //   },
      // ),
      appBar: AppBar(
        title: Center(
          child: Text(selectedLeg?.name ?? 'Matchups'),
        ),
      ),
      body: matchups.when(
        data: (matchups) => MatchupCardsListview(matchups: matchups),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => const Center(child: Text('Something went wrong!')),
      ),
    );
  }
}
