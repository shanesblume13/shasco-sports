import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:pick/core/models/season_model.dart';
import 'package:pick/ui/views/legs_view.dart';
import 'package:pick/ui/widgets/seasons/season_card_image_clip.dart';
import 'package:pick/ui/widgets/seasons/season_card_name_container.dart';
import 'package:pick/ui/widgets/seasons/season_card_leg_count_container.dart';

class SeasonCard extends StatelessWidget {
  const SeasonCard({
    Key? key,
    required this.season,
  }) : super(key: key);

  final Season season;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        null;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LegsView(
              season: season,
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
                image name legCount
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
                const SeasonCardImageClip(),
              ),
              gridArea('name').containing(
                SeasonCardNameConatiner(name: season.name),
              ),
              gridArea('legCount').containing(
                SeasonCardLegCountContainer(season: season),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
