import 'package:flutter/material.dart';
import 'package:pick/matchup/matchup.dart';
import 'package:pick/palette.dart';
import 'package:pick/pick/pick.dart';
import 'package:pick/team/team.dart';

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
            fontSize: 12,
            color: Palette.shascoBlue,
          ),
          child: Text(
            team.location,
          ),
        ),
      ],
    );
  }
}
