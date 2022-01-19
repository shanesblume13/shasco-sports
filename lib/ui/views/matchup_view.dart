import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/core/viewmodels/matchup_view_model.dart';
import 'package:pick/ui/widgets/matchups/matchup_listview.dart';
import 'package:provider/provider.dart';

class MatchupsView extends StatefulWidget {
  const MatchupsView({Key? key}) : super(key: key);

  @override
  _MatchupsViewState createState() => _MatchupsViewState();
}

class _MatchupsViewState extends State<MatchupsView> {
  List<Matchup> matchups = [];

  @override
  Widget build(BuildContext context) {
    final matchupProvider = Provider.of<MatchupViewModel>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/addMatchup');
        },
      ),
      appBar: AppBar(
        title: const Center(
          child: Text('Matchup View'),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: matchupProvider.fetchMatchupsAsStream(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            matchups = snapshot.data?.docs
                    .map(
                        (doc) => Matchup.fromQueryDocumentSnapshot(doc, doc.id))
                    .toList() ??
                [];

            return MatchupsListview(matchups: matchups);
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
