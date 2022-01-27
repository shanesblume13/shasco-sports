import 'package:flutter/material.dart';

class MatchupCardTeamLocation extends StatelessWidget {
  const MatchupCardTeamLocation({
    Key? key,
    required this.teamLocation,
    required this.isHome,
    required this.hasPick,
    required this.isPicked,
  }) : super(key: key);

  final String teamLocation;
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
                ? 10
                : isPicked
                    ? 12
                    : 10,
            fontWeight: !hasPick
                ? FontWeight.normal
                : isPicked
                    ? FontWeight.bold
                    : FontWeight.normal,
          ),
          child: Text(
            teamLocation,
          ),
        ),
      ],
    );
  }
}
