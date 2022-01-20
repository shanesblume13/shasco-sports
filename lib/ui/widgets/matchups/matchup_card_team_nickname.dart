import 'package:flutter/material.dart';

class MatchupCardTeamNickname extends StatelessWidget {
  const MatchupCardTeamNickname({
    Key? key,
    required this.teamName,
    required this.isHome,
    required this.isPicked,
  }) : super(key: key);

  final String teamName;
  final bool isHome;
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
            color: isPicked ? Colors.black : Colors.grey,
            fontSize: isPicked ? 18 : 16,
            fontWeight: isPicked ? FontWeight.bold : FontWeight.normal,
          ),
          child: Text(
            teamName,
          ),
        ),
      ],
    );
  }
}
