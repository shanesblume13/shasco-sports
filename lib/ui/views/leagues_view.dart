import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/league_model.dart';
import 'package:pick/core/models/sport_model.dart';
import 'package:pick/core/providers/leagues_provider.dart';
import 'package:pick/ui/shared/gradient_scaffold.dart';
import 'package:pick/ui/widgets/leagues/league_cards_listview.dart';

class LeaguesView extends HookConsumerWidget {
  const LeaguesView({
    Key? key,
    required this.sport,
  }) : super(key: key);

  final Sport sport;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<League>> leagues =
        ref.watch(leaguesBySportStateProvider(sport));

    return GradientScaffold(
      appBarText: sport.name,
      body: leagues.when(
        data: (leagues) => LeagueCardsListview(leagues: leagues),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => const Center(child: Text('Error getting leagues!')),
      ),
    );
  }
}
