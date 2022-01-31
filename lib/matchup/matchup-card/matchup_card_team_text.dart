import 'package:flutter/material.dart';
import 'package:pick/matchup/matchup-card/matchup_card_team_text_location.dart';
import 'package:pick/matchup/matchup-card/matchup_card_team_text_nickname.dart';
import 'package:pick/matchup/matchup.dart';
import 'package:pick/pick/pick_model.dart';
import 'package:pick/team/team_model.dart';
import 'package:pick/palette.dart';

class MatchupCardTeamText extends StatelessWidget {
  const MatchupCardTeamText({
    Key? key,
    required this.team,
    required this.matchup,
    required this.pick,
  }) : super(key: key);

  final Team team;
  final Matchup matchup;
  final Pick? pick;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: pick?.teamReference == team.reference
          ? Palette.shascoBlue[50]
          : Colors.transparent,
      duration: const Duration(milliseconds: 300),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MatchupCardTeamTextLocation(
                team: team,
                matchup: matchup,
                pick: pick,
              ),
              MatchupCardTeamTextNickname(
                team: team,
                matchup: matchup,
                pick: pick,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
