import 'package:flutter/material.dart';
import 'package:pick/matchup/matchup-card/matchup_card_team_divider_clipper.dart';
import 'package:pick/matchup/matchup.dart';
import 'package:pick/palette.dart';
import 'package:pick/pick/pick.dart';
// import 'packages:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

class MatchupCardTeamDivider extends StatelessWidget {
  const MatchupCardTeamDivider({
    Key? key,
    required this.matchup,
    required this.pick,
  }) : super(key: key);

  final Matchup matchup;
  final Pick? pick;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: pick != null ? Palette.shascoBlue[50] : Palette.shascoGrey[50],
      duration: const Duration(milliseconds: 300),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 60,
            width: 0,
            color: Palette.shascoBlue,
          ),
          ClipPath(
            clipper: pick?.teamReference == matchup.homeTeamReference
                ? MatchupCardTeamDividerClipper(clipLeft: true)
                : pick?.teamReference == matchup.awayTeamReference
                    ? MatchupCardTeamDividerClipper(clipRight: true)
                    : null,
            child: Container(
                // width: 30,
                // height: 48,
                // color: pick != null ? Palette.shascoBlue : Colors.transparent,
                // child: Center(
                //   child: pick?.teamReference == matchup.homeTeamReference
                //       ? Icon(
                //           Icons.chevron_right,
                //           color: Palette.shascoGrey[50],
                //           size: 24,
                //         )
                //       : pick?.teamReference == matchup.awayTeamReference
                //           ? Icon(
                //               Icons.chevron_left,
                //               color: Palette.shascoGrey[50],
                //               size: 24,
                //             )
                //           : null,
                // ),
                ),
          ),
        ],
      ),
    );
  }
}
