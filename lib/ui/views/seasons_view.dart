import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/league_model.dart';
import 'package:pick/core/models/season_model.dart';
import 'package:pick/core/providers/leagues_provider.dart';
import 'package:pick/core/providers/seasons_provider.dart';
import 'package:pick/ui/widgets/seasons/season_cards_listview.dart';

class SeasonsView extends HookConsumerWidget {
  const SeasonsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Season>> seasons = ref.watch(allSeasonsStateProvider);
    final League? selectedLeague = ref.watch(selectedLeagueStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(selectedLeague?.name ?? 'Seasons'),
        ),
      ),
      body: seasons.when(
        data: (seasons) => SeasonCardsListview(seasons: seasons),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => const Center(child: Text('Something went wrong!')),
      ),
    );
  }
}
