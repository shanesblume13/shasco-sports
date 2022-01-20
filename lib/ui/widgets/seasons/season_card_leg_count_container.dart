import 'package:flutter/material.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/models/season_model.dart';
import 'package:pick/core/viewmodels/leg_view_model.dart';
import 'package:provider/provider.dart';

class SeasonCardLegCountContainer extends StatefulWidget {
  const SeasonCardLegCountContainer({
    Key? key,
    required this.season,
  }) : super(key: key);

  final Season season;

  @override
  State<SeasonCardLegCountContainer> createState() =>
      _SeasonCardLegCountContainerState();
}

class _SeasonCardLegCountContainerState
    extends State<SeasonCardLegCountContainer> {
  List<Leg> legs = [];

  @override
  Widget build(BuildContext context) {
    final LegViewModel legProvider = Provider.of<LegViewModel>(context);
    int legCount = 0;

    return FutureBuilder<List<Leg>>(
        future: legProvider.fetchLegs(season: widget.season),
        builder: (context, AsyncSnapshot<List<Leg>> snapshot) {
          if (snapshot.hasData) {
            legCount = snapshot.data?.length ?? 0;
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('$legCount'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Legs'),
                ],
              ),
            ],
          );
        });
  }
}
