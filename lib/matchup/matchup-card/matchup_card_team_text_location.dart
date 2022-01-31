import 'package:flutter/material.dart';
import 'package:pick/matchup/matchup.dart';
import 'package:pick/palette.dart';
import 'package:pick/pick/pick_model.dart';
import 'package:pick/team/team_model.dart';

class MatchupCardTeamTextLocation extends StatelessWidget {
  const MatchupCardTeamTextLocation({
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
    return Row(
      mainAxisAlignment: team.reference == matchup.homeTeamReference
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: TextStyle(
            color: pick == null
                ? Palette.shascoBlue
                : pick?.teamReference == team.reference
                    ? Palette.shascoBlue
                    : Palette.shascoBlue[200],
            fontSize: pick == null
                ? 12
                : pick?.teamReference == team.reference
                    ? 12
                    : 9,
            fontWeight: pick == null
                ? FontWeight.normal
                : pick?.teamReference == team.reference
                    ? FontWeight.bold
                    : FontWeight.normal,
          ),
          child: Text(
            team.location,
          ),
        ),
      ],
    );
  }
}
