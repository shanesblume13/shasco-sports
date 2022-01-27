import 'package:flutter/material.dart';

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
                ? Colors.black
                : isPicked
                    ? Colors.black
                    : Colors.grey,
            fontSize: !hasPick
                ? 16
                : isPicked
                    ? 18
                    : 16,
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
