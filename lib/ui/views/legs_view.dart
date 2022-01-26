import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/models/season_model.dart';
import 'package:pick/core/providers/legs_provider.dart';
import 'package:pick/ui/widgets/legs/leg_cards_listview.dart';

class LegsView extends HookConsumerWidget {
  const LegsView({
    Key? key,
    required this.season,
  }) : super(key: key);

  final Season season;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Leg>> legs = ref.watch(legsBySeasonStateProvider(season));

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     Navigator.pushNamed(context, '/addLeg');
      //   },
      // ),
      appBar: AppBar(
        title: Center(
          child: Text(season.name),
        ),
      ),
      body: legs.when(
        data: (legs) => LegCardsListview(legs: legs),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => const Center(child: Text('Error getting legs!')),
      ),
    );
  }
}
