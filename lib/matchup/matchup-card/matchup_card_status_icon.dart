import 'package:flutter/material.dart';
import 'package:pick/card_image_clipper.dart';
import 'package:pick/matchup/matchup.dart';
import 'package:pick/palette.dart';
import 'package:pick/pick/pick.dart';
import 'package:pick/team/team.dart';

class MatchupCardStatusIcon extends StatelessWidget {
  const MatchupCardStatusIcon({
    Key? key,
    required this.team,
    required this.matchup,
    required this.pick,
    required this.imagePath,
  }) : super(key: key);

  final Team team;
  final Matchup matchup;
  final Pick? pick;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    IconData? iconData =
        pick?.teamReference == team.reference ? Icons.check_box_outlined : null;
    Color iconColor = Palette.shascoBlue;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 60,
      child: ClipPath(
        clipper: matchup.homeTeamReference == team.reference
            ? CardImageClipper(clipLeft: true)
            : CardImageClipper(clipRight: true),
        child: Container(
          height: 60,
          child: Center(
            child: Icon(
              iconData,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
