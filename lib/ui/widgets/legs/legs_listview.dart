import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/ui/views/leg_detail.dart';
import 'package:pick/ui/widgets/legs/leg_name_container.dart';
import 'package:pick/ui/widgets/legs/leg_start_clip.dart';

class LegsListview extends StatelessWidget {
  LegsListview({
    Key? key,
    required this.legs,
  }) : super(key: key);

  final List<Leg> legs;
  final List<Widget> legCards = [];

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < legs.length; i++) {
      legCards.add(
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => LegDetail(leg: legs[i])));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 6,
              child: LayoutGrid(
                areas: '''
                    order legName startDate matchupCount
                    order legName lockDate matchupCount
                    order legName endDate matchtupCountLabel
                  ''',
                rowSizes: const [
                  auto,
                  auto,
                  auto,
                ],
                columnSizes: [1.fr, 2.fr, 3.fr, auto],
                children: [
                  gridArea('order').containing(
                    LegStartClip(startDate: legs[i].startDate),
                  ),
                  gridArea('legName').containing(
                    LegNameContainer(name: legs[i].name),
                  ),
                  gridArea('startDate').containing(
                    Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          size: 12,
                          color: Colors.green,
                        ),
                        Text(
                          'Start: ${legs[i].startDate.toString()}',
                        ),
                      ],
                    ),
                  ),
                  gridArea('lockDate').containing(
                    Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          size: 12,
                          color: Colors.green,
                        ),
                        Text(
                          'Lock: ${legs[i].lockDate.toString()}',
                        ),
                      ],
                    ),
                  ),
                  gridArea('endDate').containing(
                    Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          size: 12,
                          color: Colors.green,
                        ),
                        Text(
                          'End: ${legs[i].endDate.toString()}',
                        ),
                      ],
                    ),
                  ),
                  gridArea('matchupCount').containing(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('10'),
                      ],
                    ),
                  ),
                  gridArea('matchtupCountLabel').containing(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('matchtupCountLabel'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return ListView(children: legCards);
  }
}
