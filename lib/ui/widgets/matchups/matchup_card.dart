import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/core/models/pick_model.dart';
import 'package:pick/core/models/team_model.dart';
import 'package:pick/core/providers/teams_provider.dart';
import 'package:pick/ui/widgets/matchups/matchup_pick_score_divider.dart';
import 'package:pick/ui/widgets/matchups/team_image_container.dart';
import 'package:pick/ui/widgets/matchups/matchup_card_team_name_container.dart';

class MatchupCard extends HookConsumerWidget {
  const MatchupCard({
    Key? key,
    required this.matchup,
    this.pick,
  }) : super(key: key);

  final Matchup matchup;
  final Pick? pick;

//   @override
//   State<MatchupCard> createState() => _MatchupCardState();
// }

// class _MatchupCardState extends State<MatchupCard> {
//   List<String> _imagePaths = [];
//   DocumentReference? _pickedTeamReference;
//   int _points = 0;

  // @override
  // void initState() {
  //   _pickedTeamReference = widget.pick?.teamReference;
  //   _points = widget.pick?.points ?? 0;
  //   _initImages();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: use teams by selected state.
    AsyncValue<List<Team>> teams = ref.watch(selectedLeagueTeamsStateProvider);
    String defaultImagePath = 'assets/images/logos/nfl/nfl.jpeg';
    String awayImagePath = defaultImagePath;
    String homeImagePath = defaultImagePath;

    // if (_imagePaths.contains(
    //     'assets/images/logos/nfl/${awayTeam.nickname.toLowerCase()}.gif')) {
    //   awayImagePath =
    //       'assets/images/logos/nfl/${awayTeam.nickname.toLowerCase()}.gif';
    // }

    // if (_imagePaths.contains(
    //     'assets/images/logos/nfl/${homeTeam.nickname.toLowerCase()}.gif')) {
    //   homeImagePath =
    //       'assets/images/logos/nfl/${homeTeam.nickname.toLowerCase()}.gif';
    // }

    return teams.when(
      data: (teams) {
        Team awayTeam = teams
            .firstWhere((team) => matchup.awayTeamReference == team.reference);
        Team homeTeam = teams
            .firstWhere((team) => matchup.homeTeamReference == team.reference);
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
                    onTap: () => null, //_savePick(team: awayTeam),
                    splashColor: Colors.transparent,
                    child: TeamImageContainer(
                      isPicked:
                          false, // _pickedTeamReference == awayTeam.reference,
                      team: awayTeam,
                      isHome: false,
                      imagePath: awayImagePath,
                    ),
                  ),
                ),
                gridArea('awayName').containing(
                  InkWell(
                    onTap: () => null, //_savePick(team: awayTeam),
                    splashColor: Colors.transparent,
                    child: MatchupCardTeamNameContainer(
                      isPicked:
                          false, //_pickedTeamReference == awayTeam.reference,
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
                    child: const MatchupPickScoreDivider(
                      homePicked:
                          false, //_pickedTeamReference == homeTeam.reference,
                      awayPicked:
                          false, //_pickedTeamReference == awayTeam.reference,
                      points: 0, //_points, //_pickScores[pickScoreIndex],
                    ),
                  ),
                ),
                gridArea('homeName').containing(
                  InkWell(
                    onTap: () => null, //_savePick(team: homeTeam),
                    splashColor: Colors.transparent,
                    child: MatchupCardTeamNameContainer(
                      isPicked:
                          false, //_pickedTeamReference == homeTeam.reference,
                      team: homeTeam,
                      isHome: true,
                    ),
                  ),
                ),
                gridArea('homeLogo').containing(
                  InkWell(
                    onTap: () => null, //_savePick(team: homeTeam),
                    splashColor: Colors.transparent,
                    child: TeamImageContainer(
                      isPicked:
                          false, //_pickedTeamReference == homeTeam.reference,
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
      error: (e, s) => const Center(child: Text('Something went wrong!')),
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
