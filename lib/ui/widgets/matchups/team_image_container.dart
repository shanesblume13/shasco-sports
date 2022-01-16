import 'package:flutter/material.dart';
import 'package:pick/ui/widgets/matchups/team_image_clip.dart';

class TeamImageContainer extends StatelessWidget {
  const TeamImageContainer({
    Key? key,
    required this.isPicked,
    required this.imagePath,
    required this.isHome,
  }) : super(key: key);

  final bool isPicked;
  final String imagePath;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      //color: isPicked ? Colors.white : Colors.grey,
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: isPicked ? Colors.black : Colors.transparent,
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
