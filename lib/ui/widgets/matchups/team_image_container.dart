import 'package:flutter/material.dart';
import 'package:pick/team/team_model.dart';
import 'package:pick/palette.dart';
import 'package:pick/ui/widgets/matchups/team_image_clip.dart';

class TeamImageContainer extends StatelessWidget {
  const TeamImageContainer({
    Key? key,
    required this.hasPick,
    required this.isPicked,
    required this.team,
    required this.isHome,
    required this.imagePath,
  }) : super(key: key);

  final bool hasPick;
  final bool isPicked;
  final Team team;
  final bool isHome;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: isPicked ? Palette.shascoBlue[50] : Colors.transparent,
      duration: const Duration(milliseconds: 300),
      child: TeamImageClip(
        imagePath: imagePath,
        hasPick: hasPick,
        isPicked: isPicked,
        isHome: isHome,
      ),
    );
  }
}
