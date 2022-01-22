import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/core/models/team_model.dart';
import 'package:pick/core/viewmodels/team_view_model.dart';
import 'package:pick/ui/widgets/matchups/matchup_pick_score_divider.dart';
import 'package:pick/ui/widgets/matchups/team_image_container.dart';
import 'package:pick/ui/widgets/matchups/matchup_card_team_name_container.dart';
import 'package:provider/provider.dart';

class MatchupCard extends StatefulWidget {
  const MatchupCard({
    Key? key,
    required this.matchup,
  }) : super(key: key);

  final Matchup matchup;

  @override
  State<MatchupCard> createState() => _MatchupCardState();
}

class _MatchupCardState extends State<MatchupCard> {
  List<String> _imagePaths = [];

  @override
  void initState() {
    _initImages();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TeamViewModel teamProvider = Provider.of<TeamViewModel>(context);
    List<Team> teams = [];
    String defaultImagePath = 'assets/images/logos/nfl/nfl.jpeg';
    String awayImagePath = defaultImagePath;
    String homeImagePath = defaultImagePath;

    return FutureBuilder<List<Team>>(
      future: teamProvider.getTeamsByMatchup(widget.matchup),
      builder: (context, AsyncSnapshot<List<Team>> snapshot) {
        if (snapshot.hasData) {
          teams = snapshot.data?.toList() ?? [];

          Team awayTeam = teams[0];
          Team homeTeam = teams[1];

          if (_imagePaths.contains(
              'assets/images/logos/nfl/${awayTeam.nickname.toLowerCase()}.gif')) {
            awayImagePath =
                'assets/images/logos/nfl/${awayTeam.nickname.toLowerCase()}.gif';
          }

          if (_imagePaths.contains(
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
                      onTap: () {}, //_savePick(i, false),
                      splashColor: Colors.transparent,
                      child: TeamImageContainer(
                        isPicked: false, //_picks.contains(i),
                        team: awayTeam,
                        isHome: false,
                        imagePath: awayImagePath,
                      ),
                    ),
                  ),
                  gridArea('awayName').containing(
                    InkWell(
                      onTap: () {}, //_savePick(i, false),
                      splashColor: Colors.transparent,
                      child: MatchupCardTeamNameContainer(
                        isPicked: false, //_picks.contains(i),
                        team: awayTeam,
                        isHome: false,
                      ),
                    ),
                  ),
                  gridArea('scoreDivider').containing(
                    InkWell(
                      onTap: () {}, //_savePickScore(pickScoreIndex),
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
                      onTap: () {}, //_savePick(i + 1, true),
                      splashColor: Colors.transparent,
                      child: MatchupCardTeamNameContainer(
                        isPicked: false, //_picks.contains(i + 1),
                        team: homeTeam,
                        isHome: true,
                      ),
                    ),
                  ),
                  gridArea('homeLogo').containing(
                    InkWell(
                      onTap: () {}, //_savePick(i + 1, true),
                      splashColor: Colors.transparent,
                      child: TeamImageContainer(
                        isPicked: false, //_picks.contains(i + 1),
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
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future _initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('images/'))
        .toList();

    setState(() {
      _imagePaths = imagePaths;
    });
  }
}
