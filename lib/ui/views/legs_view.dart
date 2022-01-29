import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/models/season_model.dart';
import 'package:pick/core/providers/legs_provider.dart';
import 'package:pick/season/selected_season_provider.dart';
import 'package:pick/ui/shared/gradient_scaffold.dart';
import 'package:pick/ui/widgets/legs/leg_cards_listview.dart';

class LegsView extends HookConsumerWidget {
  const LegsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Season season = ref.watch(selectedSeasonProvider)!;
    AsyncValue<List<Leg>> legs = ref.watch(legsBySeasonStateProvider(season));

    return GradientScaffold(
      appBarText: season.name,
      body: legs.when(
        data: (legs) => LegCardsListview(legs: legs),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => const Center(child: Text('Error getting legs!')),
      ),
    );
  }
}
