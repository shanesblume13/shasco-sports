import 'package:flutter/material.dart';
import 'package:pick/matchup/matchup-card/matchup_card_team_image_clipper.dart';
import 'package:pick/matchup/matchup.dart';
import 'package:pick/pick/pick_model.dart';
import 'package:pick/team/team_model.dart';
import 'package:pick/palette.dart';

class MatchupCardTeamImage extends StatelessWidget {
  const MatchupCardTeamImage({
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
    return AnimatedContainer(
        color: pick?.teamReference == team.reference
            ? Palette.shascoBlue[50]
            : Colors.transparent,
        duration: const Duration(milliseconds: 300),
        child: ClipPath(
          clipper: matchup.homeTeamReference == team.reference
              ? MatchupCardTeamImageClipper(clipLeft: true)
              : MatchupCardTeamImageClipper(clipRight: true),
          child: Image(
            height: 60,
            fit: BoxFit.cover,
            color: pick == null
                ? Colors.transparent
                : pick?.teamReference == team.reference
                    ? Colors.transparent
                    : Palette.shascoGrey,
            colorBlendMode: BlendMode.hardLight,
            image: AssetImage(imagePath),
          ),
        ));
  }
}
