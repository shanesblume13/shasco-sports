import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/gradient_scaffold.dart';
import 'package:pick/icon-card/icon_card_list.dart';
import 'package:pick/league/league.dart';
import 'package:pick/sport/sport.dart';
import 'package:pick/league/leagues_provider.dart';
import 'package:pick/league/selected_league_provider.dart';
import 'package:pick/season/seasons_view.dart';
import 'package:pick/sport/selected_sport_provider.dart';

class LeaguesView extends HookConsumerWidget {
  const LeaguesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Sport sport = ref.watch(selectedSportStateProvider)!;

    return GradientScaffold(
      appBarText: sport.name,
      body: ref.watch(leaguesBySelectedSportStateProvider).when(
            data: (leagues) => getLeagueOptionsListView(
              context: context,
              ref: ref,
              sport: sport,
              leagues: leagues,
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) =>
                const Center(child: Text('Error getting leagues!')),
          ),
    );
  }

  Widget getLeagueOptionsListView({
    required BuildContext context,
    required WidgetRef ref,
    required Sport sport,
    required List<League> leagues,
  }) {
    final List<Widget> iconOptionContainers = [];

    for (var league in leagues) {
      iconOptionContainers.add(
        IconCard(
          iconData: sport.iconData,
          text: league.name,
          // TODO Add child count and label
          onTap: () {
            ref
                .watch(selectedLeagueStateProvider.notifier)
                .selectLeague(league);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SeasonsView(),
              ),
            );
          },
        ),
      );
    }

    return ListView(children: iconOptionContainers);
  }
}
