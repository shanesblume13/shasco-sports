import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick/matchup/matchup.dart';
import 'package:pick/pick/pick_model.dart';
import 'package:pick/segment/segment.dart';

class PicksFirestoreService extends ChangeNotifier {
  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('picks');

  Future<List<Pick>> fetchPicks() async {
    var result = await collection.get();

    return result.docs
        .map(
          (doc) => Pick.fromQueryDocumentSnapshot(doc, doc.reference),
        )
        .toList();
  }

  Future<List<Pick>> fetchPicksByMatchup({required Matchup matchup}) async {
    var result = await collection
        .where('matchupReference', isEqualTo: matchup.reference)
        .get();

    return result.docs
        .map(
          (doc) => Pick.fromQueryDocumentSnapshot(doc, doc.reference),
        )
        .toList();
  }

  Future<List<Pick>> fetchPicksBySegment({required Segment segment}) async {
    var result = await collection
        .where('segmentReference', isEqualTo: segment.reference)
        .get();

    return result.docs
        .map(
          (doc) => Pick.fromQueryDocumentSnapshot(doc, doc.reference),
        )
        .toList();
  }
}
