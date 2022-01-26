import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/core/services/firestore_api_service.dart';

class FirestoreMatchupService extends ChangeNotifier {
  final FirestoreApiService _apiService = FirestoreApiService('matchups');

  Future<List<Matchup>> fetchMathchups(Leg? leg) async {
    List<Matchup> matchups = [];
    var result = await _apiService.getDataCollection();

    if (leg == null) {
      matchups = result.docs
          .map(
            (doc) => Matchup.fromQueryDocumentSnapshot(doc, doc.id),
          )
          .toList();
    } else {
      matchups = result.docs
          .map(
            (doc) => Matchup.fromQueryDocumentSnapshot(doc, doc.id),
          )
          .where((matchup) => matchup.legReference == leg.reference)
          .toList();
    }

    return matchups;
  }

  Stream<List<Matchup>> fetchMatchupsAsStream(Leg? leg) {
    Stream<List<Matchup>> matchupsStream;
    Stream<QuerySnapshot<Map<String, dynamic>>> result =
        _apiService.streamDataCollection();

    if (leg == null) {
      matchupsStream = result.map(
        (snapshot) {
          return snapshot.docs
              .map(
                (doc) => Matchup.fromQueryDocumentSnapshot(doc, doc.id),
              )
              .toList();
        },
      );
    } else {
      matchupsStream = result.map(
        (snapshot) {
          return snapshot.docs
              .map(
                (doc) => Matchup.fromQueryDocumentSnapshot(doc, doc.id),
              )
              .where((matchup) => matchup.legReference == leg.reference)
              .toList();
        },
      );
    }

    return matchupsStream;
  }
}
