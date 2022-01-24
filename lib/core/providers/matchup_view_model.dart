import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/core/services/matchup_api_service.dart';
import 'package:pick/locator.dart';

class MatchupViewModel extends ChangeNotifier {
  final MatchupApiService _apiService = locator<MatchupApiService>();

  List<Matchup> matchups = [];

  Future<List<Matchup>> fetchMatchups({
    required Leg leg,
  }) async {
    var result = await _apiService.getDataCollection();
    matchups = result.docs
        .map((doc) => Matchup.fromQueryDocumentSnapshot(doc, doc.id))
        .where((matchup) => matchup.legReference == leg.reference)
        .toList();

    matchups.sort((a, b) => a.startDateTime.compareTo(b.startDateTime));
    return matchups;
  }

  Stream<List<Matchup>> fetchMatchupsAsStream({
    required Leg leg,
  }) {
    Stream<List<Matchup>> matchupsStream;
    Stream<QuerySnapshot<Map<String, dynamic>>> result =
        _apiService.streamDataCollection();

    matchupsStream = result.map(
      (snapshot) {
        List<Matchup> matchups = snapshot.docs
            .map((doc) => Matchup.fromQueryDocumentSnapshot(doc, doc.id))
            .where((matchup) => matchup.legReference == leg.reference)
            .toList();

        matchups.sort((a, b) => a.startDateTime.compareTo(b.startDateTime));

        return matchups;
      },
    );

    return matchupsStream;
  }

  Future<Matchup> getMatchupById(String id) async {
    var doc = await _apiService.getDocumentById(id);
    return Matchup.fromDocumentSnapshot(doc, doc.id);
  }

  Future removeMatchup(String id) async {
    await _apiService.removeDocument(id);
    return;
  }

  Future updateMatchup(Matchup data, String id) async {
    await _apiService.updateDocument(data.toJson(), id);
    return;
  }

  Future addMatchup(Matchup data) async {
    // var result = await _apiService.addDocument(data.toJson());
    await _apiService.addDocument(data.toJson());

    return;
  }
}
