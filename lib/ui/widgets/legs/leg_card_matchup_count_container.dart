import 'package:flutter/material.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/core/viewmodels/matchup_view_model.dart';
import 'package:provider/provider.dart';

class LegCardMatchupCountContainer extends StatefulWidget {
  const LegCardMatchupCountContainer({
    Key? key,
    required this.leg,
  }) : super(key: key);

  final Leg leg;

  @override
  State<LegCardMatchupCountContainer> createState() =>
      _LegCardMatchupCountContainerState();
}

class _LegCardMatchupCountContainerState
    extends State<LegCardMatchupCountContainer> {
  List<Matchup> matchups = [];

  @override
  Widget build(BuildContext context) {
    final MatchupViewModel matchupProvider =
        Provider.of<MatchupViewModel>(context);
    int matchupCount = 0;

    return FutureBuilder<List<Matchup>>(
        future: matchupProvider.fetchMatchups(leg: widget.leg),
        builder: (context, AsyncSnapshot<List<Matchup>> snapshot) {
          if (snapshot.hasData) {
            matchupCount = snapshot.data?.length ?? 0;
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('$matchupCount'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Matchups'),
                ],
              ),
            ],
          );
        });
  }
}
