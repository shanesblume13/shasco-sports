import 'package:flutter/material.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/core/viewmodels/matchup_view_model.dart';
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

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     Navigator.pushNamed(context, '/addMatchup');
      //   },
      // ),
      appBar: AppBar(
        title: const Center(
          child: Text('Matchups View'),
        ),
      ),
      body: StreamBuilder<List<Matchup>>(
        stream: matchupProvider.fetchMatchupsAsStream(leg: widget.leg),
        builder: (context, AsyncSnapshot<List<Matchup>> snapshot) {
          if (snapshot.hasData) {
            matchups = snapshot.data?.toList() ?? [];

            return MatchupCardsListview(matchups: matchups);
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
