import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/core/services/api_service.dart';
import 'package:pick/locator.dart';

class MatchupCrudModel extends ChangeNotifier {
  final ApiService _apiService = locator<ApiService>();

  List<Matchup> matchups = [];

  Future<List<Matchup>> fetchMatchups() async {
    var result = await _apiService.getDataCollection();
    matchups = result.docs
        .map((doc) => Matchup.fromQueryDocumentSnapshot(doc, doc.id))
        .toList();
    return matchups;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchMatchupsAsStream() {
    return _apiService.streamDataCollection();
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
    var result = await _apiService.addDocument(data.toJson());

    return;
  }
}
