import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/ui/widgets/matchups/matchup_pick_score_divider.dart';
import 'package:pick/ui/widgets/matchups/team_image_container.dart';
import 'package:pick/ui/widgets/matchups/team_name_container.dart';

class MatchupCardsListview extends StatelessWidget {
  MatchupCardsListview({
    Key? key,
    required this.matchups,
  }) : super(key: key);

  final List<Matchup> matchups;
  final List<Widget> matchupCards = [];

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < matchups.length; i++) {
      String defaultImagePath = 'assets/images/logos/nfl/nfl.jpeg';
      String awayImagePath = defaultImagePath;
      String homeImagePath = defaultImagePath;

      // if (_imagePaths.contains(
      //     'assets/images/logos/nfl/${_teams[i].toLowerCase()}.gif')) {
      //   awayImagePath =
      //       'assets/images/logos/nfl/${_teams[i].toLowerCase()}.gif';
      // }

      // if (_imagePaths.contains(
      //     'assets/images/logos/nfl/${_teams[i + 1].toLowerCase()}.gif')) {
      //   homeImagePath =
      //       'assets/images/logos/nfl/${_teams[i + 1].toLowerCase()}.gif';
      // }

      matchupCards.add(
        Padding(
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
                    onTap: () => null, //_savePick(i, false),
                    splashColor: Colors.transparent,
                    child: TeamImageContainer(
                      isPicked: false, //_picks.contains(i),
                      imagePath: awayImagePath,
                      isHome: false,
                    ),
                  ),
                ),
                gridArea('awayName').containing(
                  InkWell(
                    onTap: () => null, //_savePick(i, false),
                    splashColor: Colors.transparent,
                    child: TeamNameContainer(
                      isPicked: false, //_picks.contains(i),
                      // TODO: Get team name from id
                      teamName: matchups[i].awayTeamId.toString(),
                      isHome: false,
                    ),
                  ),
                ),
                gridArea('scoreDivider').containing(
                  InkWell(
                    onTap: () => null, //_savePickScore(pickScoreIndex),
                    splashColor: Colors.transparent,
                    child: const MatchupPickScoreDivider(
                      homePicked: false, //_picks.contains(i + 1),
                      awayPicked: false, //_picks.contains(i),
                      pickScore: '0', //_pickScores[pickScoreIndex],
                    ),
                  ),
                ),
                gridArea('homeName').containing(
                  InkWell(
                    onTap: () => null, //_savePick(i + 1, true),
                    splashColor: Colors.transparent,
                    child: TeamNameContainer(
                      isPicked: false, //_picks.contains(i + 1),
                      // TODO: Get team name from id
                      teamName: matchups[i].homeTeamId.toString(),
                      isHome: true,
                    ),
                  ),
                ),
                gridArea('homeLogo').containing(
                  InkWell(
                    onTap: () => null, //_savePick(i + 1, true),
                    splashColor: Colors.transparent,
                    child: TeamImageContainer(
                      isPicked: false, //_picks.contains(i + 1),
                      imagePath: homeImagePath,
                      isHome: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return ListView(children: matchupCards);
  }
}
