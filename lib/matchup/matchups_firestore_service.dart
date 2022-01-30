import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick/matchup/matchup.dart';
import 'package:pick/segment/segment.dart';

class MatchupsFirestoreService extends ChangeNotifier {
  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('matchups');

  Future<List<Matchup>> fetchMatchups() async {
    var result = await collection.get();

    return result.docs
        .map(
          (doc) => Matchup.fromQueryDocumentSnapshot(doc, doc.reference),
        )
        .toList();
  }

  Future<List<Matchup>> fetchMatchupsBySegment(
      {required Segment segment}) async {
    var result = await collection
        .where('segmentReference', isEqualTo: segment.reference)
        .get();

    return result.docs
        .map(
          (doc) => Matchup.fromQueryDocumentSnapshot(doc, doc.reference),
        )
        .toList();
  }
}
