import 'package:flutter/material.dart';
import 'package:pick/core/models/team_model.dart';
import 'package:pick/ui/shared/palette.dart';
import 'package:pick/ui/widgets/matchups/matchup_card_team_location.dart';
import 'package:pick/ui/widgets/matchups/matchup_card_team_nickname.dart';

class MatchupCardTeamNameContainer extends StatelessWidget {
  const MatchupCardTeamNameContainer({
    Key? key,
    required this.hasPick,
    required this.isPicked,
    required this.team,
    required this.isHome,
  }) : super(key: key);

  final bool hasPick;
  final bool isPicked;
  final Team team;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        //color: Palette.shascoBlue[50]!,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: !hasPick
                ? Colors.transparent
                : isPicked
                    ? Palette.shascoBlue
                    : Palette.shascoBlue[100]!,
            width: 3,
          ),
        ),
      ),
      duration: const Duration(milliseconds: 300),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MatchupCardTeamLocation(
                teamLocation: team.location,
                isHome: isHome,
                hasPick: hasPick,
                isPicked: isPicked,
              ),
              MatchupCardTeamNickname(
                teamName: team.nickname,
                isHome: isHome,
                hasPick: hasPick,
                isPicked: isPicked,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
