import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:pick/core/models/sport_model.dart';
import 'package:pick/ui/views/leagues_view.dart';
import 'package:pick/ui/widgets/sports/sport_card_image_clip.dart';
import 'package:pick/ui/widgets/sports/sport_card_name_container.dart';

class SportCard extends StatelessWidget {
  const SportCard({
    Key? key,
    required this.sport,
  }) : super(key: key);

  final Sport sport;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LeaguesView(
              sport: sport.name,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 6,
          child: LayoutGrid(
            areas: '''
                image name leagueCount
              ''',
            rowSizes: const [
              auto,
            ],
            columnSizes: [
              1.fr,
              3.fr,
              2.fr,
            ],
            children: [
              gridArea('image').containing(
                SportCardImageClip(
                  iconData: sport.iconData,
                  iconColor: sport.iconColor,
                ),
              ),
              gridArea('name').containing(
                SportCardNameConatiner(name: sport.name),
              ),
              gridArea('leagueCount').containing(
                const Text('0'),
                //SportCardLeagueCountContainer(sport: sport.name),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
