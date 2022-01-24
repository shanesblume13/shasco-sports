import 'package:flutter/material.dart';
import 'package:pick/core/models/season_model.dart';
import 'package:pick/core/providers/season_view_model.dart';
import 'package:provider/provider.dart';

class LeagueCardSeasonCountContainer extends StatefulWidget {
  final String league;

  const LeagueCardSeasonCountContainer({
    Key? key,
    required this.league,
  }) : super(key: key);

  @override
  State<LeagueCardSeasonCountContainer> createState() =>
      _LeagueCardSeasonCountContainerState();
}

class _LeagueCardSeasonCountContainerState
    extends State<LeagueCardSeasonCountContainer> {
  @override
  Widget build(BuildContext context) {
    final SeasonViewModel seasonProvider =
        Provider.of<SeasonViewModel>(context);
    int seasonCount = 0;

    return FutureBuilder<List<Season>>(
        future: seasonProvider.fetchSeasons(widget.league),
        builder: (context, AsyncSnapshot<List<Season>> snapshot) {
          if (snapshot.hasData) {
            seasonCount = snapshot.data?.length ?? 0;
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('$seasonCount'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Active Seasons'),
                ],
              ),
            ],
          );
        });
  }
}
