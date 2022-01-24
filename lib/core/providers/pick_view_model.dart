import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/core/models/pick_model.dart';
import 'package:pick/core/services/pick_api_service.dart';
import 'package:pick/locator.dart';

class PickViewModel extends ChangeNotifier {
  final PickApiService _apiService = locator<PickApiService>();

  List<Pick> picks = [];

  Future<List<Pick>> fetchPicks({
    required List<Matchup> matchups,
  }) async {
    var result = await _apiService.getDataCollection();
    List<DocumentReference> matchupReferences =
        matchups.map((Matchup matchup) => matchup.reference!).toList();

    picks = result.docs
        .map((doc) => Pick.fromQueryDocumentSnapshot(doc, doc.id))
        .where((pick) => matchupReferences.contains(pick.matchupReference))
        .toList();

    return picks;
  }

  Stream<List<Pick>> fetchMatchupsAsStream({
    required List<Matchup> matchups,
  }) {
    Stream<List<Pick>> picksStream;
    Stream<QuerySnapshot<Map<String, dynamic>>> result =
        _apiService.streamDataCollection();
    List<DocumentReference> matchupReferences =
        matchups.map((Matchup matchup) => matchup.reference!).toList();

    picksStream = result.map(
      (snapshot) {
        List<Pick> picks = snapshot.docs
            .map((doc) => Pick.fromQueryDocumentSnapshot(doc, doc.id))
            .where((pick) => matchupReferences.contains(pick.matchupReference))
            .toList();

        return picks;
      },
    );

    return picksStream;
  }

  Future<Pick> getPickById(String id) async {
    var doc = await _apiService.getDocumentById(id);
    return Pick.fromDocumentSnapshot(doc, doc.id);
  }

  Future removePick(String id) async {
    await _apiService.removeDocument(id);
    return;
  }

  Future updatePick(Matchup data, String id) async {
    await _apiService.updateDocument(data.toJson(), id);
    return;
  }

  Future addPick(Matchup data) async {
    // var result = await _apiService.addDocument(data.toJson());
    await _apiService.addDocument(data.toJson());

    return;
  }
}
