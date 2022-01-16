import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:pick/core/models/week_model.dart';
import 'package:pick/ui/views/week_detail.dart';
import 'package:pick/ui/widgets/weeks/week_name_container.dart';
import 'package:pick/ui/widgets/weeks/week_order_clip.dart';

class WeeksListview extends StatelessWidget {
  WeeksListview({
    Key? key,
    required this.weeks,
  }) : super(key: key);

  final List<Week> weeks;
  final List<Widget> weekCards = [];

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < weeks.length; i++) {
      weekCards.add(
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => WeekDetail(week: weeks[i])));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 6,
              child: LayoutGrid(
                areas: '''
                    order weekName startDate matchupCount
                    order weekName lockDate matchupCount
                    order weekName endDate matchtupCountLabel
                  ''',
                rowSizes: const [
                  auto,
                  auto,
                  auto,
                ],
                columnSizes: [1.fr, 2.fr, 3.fr, auto],
                children: [
                  gridArea('order').containing(
                    WeekOrderClip(order: weeks[i].order),
                  ),
                  gridArea('weekName').containing(
                    WeekNameContainer(name: weeks[i].name),
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
                          'Start: ${weeks[i].startDate.toString()}',
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
                          'Lock: ${weeks[i].lockDate.toString()}',
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
                          'End: ${weeks[i].endDate.toString()}',
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
    return ListView(children: weekCards);
  }
}
