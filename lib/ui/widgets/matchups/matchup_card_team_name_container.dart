import 'package:flutter/material.dart';
import 'package:pick/core/models/team_model.dart';
import 'package:pick/ui/shared/palette.dart';
import 'package:pick/ui/widgets/matchups/matchup_card_team_location.dart';
import 'package:pick/ui/widgets/matchups/matchup_card_team_nickname.dart';

class MatchupCardTeamNameContainer extends StatelessWidget {
  const MatchupCardTeamNameContainer({
    Key? key,
    required this.isPicked,
    required this.team,
    required this.isHome,
  }) : super(key: key);

  final bool isPicked;
  final Team team;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: isPicked ? Palette.shascoBlue : Colors.transparent,
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
                isPicked: isPicked,
              ),
              MatchupCardTeamNickname(
                teamName: team.nickname,
                isHome: isHome,
                isPicked: isPicked,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
