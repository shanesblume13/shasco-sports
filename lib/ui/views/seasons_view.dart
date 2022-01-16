import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick/core/models/season.dart';
import 'package:pick/core/viewmodels/season_crud_mold.dart';
import 'package:provider/provider.dart';

class SeasonsView extends StatefulWidget {
  final String? league;

  const SeasonsView({
    Key? key,
    this.league,
  }) : super(key: key);

  @override
  _SeasonsViewState createState() => _SeasonsViewState();
}

class _SeasonsViewState extends State<SeasonsView> {
  List<Season> seasons = [];

  @override
  Widget build(BuildContext context) {
    final seasonProvider = Provider.of<SeasonCrudModel>(context);
    String? league = widget.league;

    return Scaffold(
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
        stream: seasonProvider.fetchSeasonsAsStream(league ?? ''),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            if (league == null || league == '') {
              seasons = snapshot.data?.docs
                      .map((doc) =>
                          Season.fromQueryDocumentSnapshot(doc, doc.id))
                      .toList() ??
                  [];
            } else {
              seasons = snapshot.data?.docs
                      .map((doc) =>
                          Season.fromQueryDocumentSnapshot(doc, doc.id))
                      .where((season) =>
                          season.league.toString().toLowerCase() ==
                          league.toLowerCase())
                      .toList() ??
                  [];
            }

            // return SeasonsListview(seasons: seasons);
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
