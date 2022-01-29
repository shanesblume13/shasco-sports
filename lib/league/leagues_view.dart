import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/league_model.dart';
import 'package:pick/sport/sport.dart';
import 'package:pick/league/leagues_provider.dart';
import 'package:pick/league/selected_league_provider.dart';
import 'package:pick/season/seasons_view.dart';
import 'package:pick/sport/selected_sport_provider.dart';
import 'package:pick/ui/shared/gradient_scaffold.dart';
import 'package:pick/icon-list-option/icon_list_option.dart';

class LeaguesView extends HookConsumerWidget {
  const LeaguesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Sport sport = ref.watch(selectedSportProvider)!;

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
        IconListOption(
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
