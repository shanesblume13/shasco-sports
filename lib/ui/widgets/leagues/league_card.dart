import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/league_model.dart';
import 'package:pick/core/providers/leagues_provider.dart';
import 'package:pick/ui/views/seasons_view.dart';
import 'package:pick/ui/widgets/leagues/league_card_image_clip.dart';
import 'package:pick/ui/widgets/leagues/league_card_name_container.dart';
import 'package:pick/ui/widgets/leagues/league_card_season_count_container.dart';

class LeagueCard extends HookConsumerWidget {
  const LeagueCard({
    Key? key,
    required this.league,
  }) : super(key: key);

  final League league;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.watch(selectedLeagueStateProvider.notifier).select(league);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const SeasonsView(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 6,
          child: LayoutGrid(
            areas: '''
                image name seasonCount
              ''',
            rowSizes: const [
              auto,
            ],
            columnSizes: [
              1.fr,
              3.fr,
              2.fr,
            ],
            children: [
              gridArea('image').containing(
                LeagueCardImageClip(
                  imagePath: league.imagePath,
                ),
              ),
              gridArea('name').containing(
                LeagueCardNameConatiner(name: league.name),
              ),
              gridArea('seasonCount').containing(
                LeagueCardSeasonCountContainer(
                  league: league.name,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
