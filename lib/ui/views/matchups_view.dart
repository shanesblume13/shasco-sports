import 'package:flutter/material.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/core/models/pick_model.dart';
import 'package:pick/core/providers/matchup_view_model.dart';
import 'package:pick/core/providers/pick_view_model.dart';
import 'package:pick/ui/widgets/matchups/matchup_cards_listview.dart';
import 'package:provider/provider.dart';

class MatchupsView extends StatefulWidget {
  const MatchupsView({
    Key? key,
    required this.leg,
  }) : super(key: key);

  final Leg leg;

  @override
  _MatchupsViewState createState() => _MatchupsViewState();
}

class _MatchupsViewState extends State<MatchupsView> {
  List<Matchup> matchups = [];

  @override
  Widget build(BuildContext context) {
    final matchupProvider = Provider.of<MatchupViewModel>(context);
    final pickProvider = Provider.of<PickViewModel>(context);

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     Navigator.pushNamed(context, '/addMatchup');
      //   },
      // ),
      appBar: AppBar(
        title: Center(
          child: Text(widget.leg.name),
        ),
      ),
      body: StreamBuilder<List<Matchup>>(
        stream: matchupProvider.fetchMatchupsAsStream(leg: widget.leg),
        builder: (context, AsyncSnapshot<List<Matchup>> snapshot) {
          if (snapshot.hasData) {
            matchups = snapshot.data?.toList() ?? [];

            return FutureBuilder<List<Pick>?>(
              future: pickProvider.fetchPicks(matchups: matchups),
              builder: (context, AsyncSnapshot<List<Pick>?> snapshot) {
                if (snapshot.hasData) {
                  return MatchupCardsListview(
                      matchups: matchups, picks: snapshot.data);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
