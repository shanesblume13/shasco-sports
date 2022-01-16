import 'package:flutter/material.dart';
import 'package:pick/ui/widgets/matchups/team_name_location.dart';
import 'package:pick/ui/widgets/matchups/team_name_mascot.dart';

class TeamNameContainer extends StatelessWidget {
  const TeamNameContainer({
    Key? key,
    required this.isPicked,
    required this.teamName,
    required this.isHome,
  }) : super(key: key);

  final bool isPicked;
  final String teamName;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: isPicked ? Colors.black : Colors.transparent,
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
              TeamNameLocation(
                teamLocation: teamName,
                isHome: isHome,
                isPicked: isPicked,
              ),
              TeamNameMascot(
                teamName: teamName,
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
