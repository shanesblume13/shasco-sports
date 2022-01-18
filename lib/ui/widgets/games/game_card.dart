import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:pick/core/models/game.dart';
import 'package:pick/ui/widgets/games/game_card_image_clip.dart';
import 'package:pick/ui/widgets/games/game_card_name_container.dart';

class GameCard extends StatelessWidget {
  const GameCard({
    Key? key,
    required this.game,
  }) : super(key: key);

  final Game game;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        null;
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => const LegssView(),
        //   ),
        // );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 6,
          child: LayoutGrid(
            areas: '''
                image name
              ''',
            rowSizes: const [
              auto,
            ],
            columnSizes: [
              1.fr,
              3.fr,
            ],
            children: [
              gridArea('image').containing(
                GameCardImageClip(
                  iconData: game.iconData,
                ),
              ),
              gridArea('name').containing(
                GameCardNameConatiner(name: game.name),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
