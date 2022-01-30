import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/gradient_scaffold.dart';
import 'package:pick/icon-card/icon_card_list.dart';
import 'package:pick/league/league.dart';
import 'package:pick/season/season.dart';
import 'package:pick/league/selected_league_provider.dart';
import 'package:pick/season/seasons_provider.dart';
import 'package:pick/season/selected_season_provider.dart';
import 'package:pick/segment/segments_view.dart';

class SeasonsView extends HookConsumerWidget {
  const SeasonsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final League league = ref.watch(selectedLeagueProvider)!;
    final test = ref.watch(seasonsBySelectedLeagueStateProvider);

    return GradientScaffold(
      appBarText: league.name,
      body: test.when(
        data: (seasons) => getSeasonOptionsListView(
          context: context,
          ref: ref,
          league: league,
          seasons: seasons,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => const Center(child: Text('Error getting seasons!')),
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
        IconCard(
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
                builder: (_) => const SegmentsView(),
              ),
            );
          },
        ),
      );
    }

    return ListView(children: iconOptionContainers);
  }
}
