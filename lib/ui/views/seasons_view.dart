import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick/core/models/season_model.dart';
import 'package:pick/core/viewmodels/season_view_model.dart';
import 'package:provider/provider.dart';

class SeasonsView extends StatefulWidget {
  final String league;

  const SeasonsView({
    Key? key,
    required this.league,
  }) : super(key: key);

  @override
  _SeasonsViewState createState() => _SeasonsViewState();
}

class _SeasonsViewState extends State<SeasonsView> {
  List<Season> seasons = [];

  @override
  Widget build(BuildContext context) {
    final seasonProvider = Provider.of<SeasonViewModel>(context);
    String league = widget.league;

    return Scaffold(
      // TODO: Figure out ADD/EDIT/DELETE UX and create views.
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     Navigator.pushNamed(context, '/addSeason');
      //   },
      // ),
      appBar: AppBar(
        title: const Center(
          child: Text('Seasons View'),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: seasonProvider.fetchSeasonsAsStream(league),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            seasons = snapshot.data?.docs
                    .map((doc) => Season.fromQueryDocumentSnapshot(doc, doc.id))
                    .where((season) =>
                        season.league.toString().toLowerCase() ==
                        league.toLowerCase())
                    .toList() ??
                [];
            return Text(
              'Season count: ${seasons.length}',
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
