import 'package:flutter/material.dart';

class TeamNameLocation extends StatelessWidget {
  const TeamNameLocation({
    Key? key,
    required this.teamLocation,
    required this.isHome,
    required this.isPicked,
  }) : super(key: key);

  final String teamLocation;
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
            fontSize: isPicked ? 12 : 10,
            fontWeight: isPicked ? FontWeight.bold : FontWeight.normal,
          ),
          child: Text(
            teamLocation,
          ),
        ),
      ],
    );
  }
}
