import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/core/models/pick_model.dart';
import 'package:pick/core/models/team_model.dart';
import 'package:pick/core/providers/images_provider.dart';
import 'package:pick/core/providers/picks_provider.dart';
import 'package:pick/ui/widgets/matchups/matchup_pick_score_divider.dart';
import 'package:pick/ui/widgets/matchups/team_image_container.dart';
import 'package:pick/ui/widgets/matchups/matchup_card_team_name_container.dart';

class MatchupCard extends HookConsumerWidget {
  const MatchupCard({
    Key? key,
    required this.matchup,
    required this.awayTeam,
    required this.homeTeam,
    this.pick,
  }) : super(key: key);

  final Matchup matchup;
  final Team awayTeam;
  final Team homeTeam;
  final Pick? pick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<String>> imagePaths = ref.watch(allImagePathsStateProvider);

    return imagePaths.when(
      data: (imagePaths) {
        String defaultImagePath = 'assets/images/logos/nfl/nfl.jpeg';
        String awayImagePath = defaultImagePath;
        String homeImagePath = defaultImagePath;

        if (imagePaths.contains(
            'assets/images/logos/nfl/${awayTeam.nickname.toLowerCase()}.gif')) {
          awayImagePath =
              'assets/images/logos/nfl/${awayTeam.nickname.toLowerCase()}.gif';
        }

        if (imagePaths.contains(
            'assets/images/logos/nfl/${homeTeam.nickname.toLowerCase()}.gif')) {
          homeImagePath =
              'assets/images/logos/nfl/${homeTeam.nickname.toLowerCase()}.gif';
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 6,
            child: LayoutGrid(
              areas: '''
                        awayLogo awayName scoreDivider homeName homeLogo
                      ''',
              rowSizes: const [auto],
              columnSizes: [1.fr, 2.fr, auto, 2.fr, 1.fr],
              children: [
                gridArea('awayLogo').containing(
                  InkWell(
                    onTap: () => ref
                        .watch(selectedLegPicksStateProvider.notifier)
                        .updatePickedTeam(matchup: matchup, team: awayTeam),
                    splashColor: Colors.transparent,
                    child: TeamImageContainer(
                      isPicked: pick?.teamReference == awayTeam.reference,
                      team: awayTeam,
                      isHome: false,
                      imagePath: awayImagePath,
                    ),
                  ),
                ),
                gridArea('awayName').containing(
                  InkWell(
                    onTap: () => ref
                        .watch(selectedLegPicksStateProvider.notifier)
                        .updatePickedTeam(matchup: matchup, team: awayTeam),
                    splashColor: Colors.transparent,
                    child: MatchupCardTeamNameContainer(
                      isPicked: pick?.teamReference == awayTeam.reference,
                      team: awayTeam,
                      isHome: false,
                    ),
                  ),
                ),
                gridArea('scoreDivider').containing(
                  InkWell(
                    onTap: () =>
                        null, //_updatePoints(), //_savePickScore(pickScoreIndex),
                    splashColor: Colors.transparent,
                    child: MatchupPickScoreDivider(
                      homePicked: pick?.teamReference == homeTeam.reference,
                      awayPicked: pick?.teamReference == awayTeam.reference,
                      points: 0, //_points, //_pickScores[pickScoreIndex],
                    ),
                  ),
                ),
                gridArea('homeName').containing(
                  InkWell(
                    onTap: () => ref
                        .watch(selectedLegPicksStateProvider.notifier)
                        .updatePickedTeam(matchup: matchup, team: homeTeam),
                    splashColor: Colors.transparent,
                    child: MatchupCardTeamNameContainer(
                      isPicked: pick?.teamReference == homeTeam.reference,
                      team: homeTeam,
                      isHome: true,
                    ),
                  ),
                ),
                gridArea('homeLogo').containing(
                  InkWell(
                    onTap: () => ref
                        .watch(selectedLegPicksStateProvider.notifier)
                        .updatePickedTeam(matchup: matchup, team: homeTeam),
                    splashColor: Colors.transparent,
                    child: TeamImageContainer(
                      isPicked: pick?.teamReference == homeTeam.reference,
                      team: homeTeam,
                      isHome: true,
                      imagePath: homeImagePath,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => const Center(child: Text('Error getting images!')),
    );
  }

  // Future _initImages() async {
  //   // >> To get paths you need these 2 lines
  //   final manifestContent = await rootBundle.loadString('AssetManifest.json');

  //   final Map<String, dynamic> manifestMap = json.decode(manifestContent);
  //   // >> To get paths you need these 2 lines

  //   final imagePaths = manifestMap.keys
  //       .where((String key) => key.contains('images/'))
  //       .toList();

  //   setState(() {
  //     _imagePaths = imagePaths;
  //   });
  // }

  // void _savePick({required Team team}) {
  //   DocumentReference? pickedTeamReference = _pickedTeamReference;

  //   if (pickedTeamReference == team.reference) {
  //     pickedTeamReference = null;
  //   } else {
  //     pickedTeamReference = team.reference;
  //   }

  //   setState(() {
  //     _pickedTeamReference = pickedTeamReference;
  //   });
  // }

  // _updatePoints() {
  //   int points = _points;

  //   points++;
  //   if (points > 10) {
  //     points = 0;
  //   }

  //   setState(() {
  //     _points = points;
  //   });
  // }
}
