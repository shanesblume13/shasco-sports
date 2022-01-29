import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/league_model.dart';
import 'package:pick/core/models/season_model.dart';
import 'package:pick/season/seasons_provider.dart';
import 'package:pick/ui/shared/gradient_scaffold.dart';
import 'package:pick/ui/widgets/seasons/season_cards_listview.dart';

class SeasonsView extends HookConsumerWidget {
  const SeasonsView({
    Key? key,
    required this.league,
  }) : super(key: key);

  final League league;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Season>> seasons =
        ref.watch(seasonsBySelectedLeagueStateProvider);

    return GradientScaffold(
      appBarText: league.name,
      body: seasons.when(
        data: (seasons) => SeasonCardsListview(seasons: seasons),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => const Center(child: Text('Error getting seasons!')),
      ),
    );
  }
}
