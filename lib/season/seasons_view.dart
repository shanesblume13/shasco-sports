import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/league_model.dart';
import 'package:pick/core/models/season_model.dart';
import 'package:pick/league/selected_league_provider.dart';
import 'package:pick/season/seasons_provider.dart';
import 'package:pick/season/selected_season_provider.dart';
import 'package:pick/ui/shared/gradient_scaffold.dart';
import 'package:pick/icon-list-option/icon_list_option.dart';
import 'package:pick/ui/views/legs_view.dart';

class SeasonsView extends HookConsumerWidget {
  const SeasonsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final League league = ref.watch(selectedLeagueProvider)!;

    return GradientScaffold(
      appBarText: league.name,
      body: ref.watch(seasonsBySelectedLeagueStateProvider).when(
            data: (seasons) => getSeasonOptionsListView(
              context: context,
              ref: ref,
              league: league,
              seasons: seasons,
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) =>
                const Center(child: Text('Error getting seasons!')),
          ),
    );
  }

  Widget getSeasonOptionsListView({
    required BuildContext context,
    required WidgetRef ref,
    required League league,
    required List<Season> seasons,
  }) {
    final List<Widget> iconOptionContainers = [];

    for (var season in seasons) {
      iconOptionContainers.add(
        IconListOption(
          iconData: Icons.calendar_today,
          text: season.name,
          // TODO Add child count and label
          onTap: () {
            ref
                .watch(selectedSeasonStateProvider.notifier)
                .selectSeason(season);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const LegsView(),
              ),
            );
          },
        ),
      );
    }

    return ListView(children: iconOptionContainers);
  }
}