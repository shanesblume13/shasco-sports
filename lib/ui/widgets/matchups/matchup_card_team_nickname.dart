import 'package:flutter/material.dart';
import 'package:pick/ui/shared/palette.dart';

class MatchupCardTeamNickname extends StatelessWidget {
  const MatchupCardTeamNickname({
    Key? key,
    required this.teamName,
    required this.isHome,
    required this.hasPick,
    required this.isPicked,
  }) : super(key: key);

  final String teamName;
  final bool isHome;
  final bool hasPick;
  final bool isPicked;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isHome ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: TextStyle(
            color: !hasPick
                ? Palette.shascoBlue
                : isPicked
                    ? Palette.shascoBlue
                    : Palette.shascoBlue[200],
            fontSize: !hasPick
                ? 15
                : isPicked
                    ? 12
                    : 15,
            fontWeight: !hasPick
                ? FontWeight.normal
                : isPicked
                    ? FontWeight.bold
                    : FontWeight.normal,
          ),
          child: Text(
            teamName,
          ),
        ),
      ],
    );
  }
}
