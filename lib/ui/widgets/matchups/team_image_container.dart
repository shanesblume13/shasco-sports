import 'package:flutter/material.dart';
import 'package:pick/core/models/team_model.dart';
import 'package:pick/ui/shared/palette.dart';
import 'package:pick/ui/widgets/matchups/team_image_clip.dart';

class TeamImageContainer extends StatelessWidget {
  const TeamImageContainer({
    Key? key,
    required this.isPicked,
    required this.team,
    required this.isHome,
    required this.imagePath,
  }) : super(key: key);

  final bool isPicked;
  final Team team;
  final bool isHome;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      //color: isPicked ? Colors.white : Colors.grey,
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: isPicked ? Palette.shascoBlue : Colors.transparent,
            width: 3,
          ),
        ),
      ),
      duration: const Duration(milliseconds: 300),
      child: TeamImageClip(
        imagePath: imagePath,
        isPicked: isPicked,
        isHome: isHome,
      ),
    );
  }
}
