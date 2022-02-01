import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick/matchup/matchup.dart';
import 'package:pick/pick/pick.dart';
import 'package:pick/segment/segment.dart';

class PicksFirestoreService extends ChangeNotifier {
  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('picks');

  Future<List<Pick>> fetchPicks() async {
    var result = await collection.get();

    return result.docs
        .map(
          (doc) => Pick.fromQueryDocumentSnapshot(doc, doc.id),
        )
        .toList();
  }

  Future<List<Pick>> fetchPicksByMatchup({required Matchup matchup}) async {
    var result = await collection
        .where('matchupReference', isEqualTo: matchup.reference)
        .get();

    return result.docs
        .map(
          (doc) => Pick.fromQueryDocumentSnapshot(doc, doc.id),
        )
        .toList();
  }

  Future<List<Pick>> fetchPicksBySegment({required Segment segment}) async {
    var result = await collection
        .where('segmentReference', isEqualTo: segment.reference)
        .get();

    return result.docs
        .map(
          (doc) => Pick.fromQueryDocumentSnapshot(doc, doc.id),
        )
        .toList();
  }

  Future<void> addPick({required Pick pick}) async {
    await collection.add(
      pick.toJson(),
    );
  }

  Future<void> updatePick({required Pick pick}) async {
    await collection.doc(pick.id).update(
          pick.toJson(),
        );
  }

  Future<void> deletePick({required Pick pick}) async {
    await collection.doc(pick.id).delete();
  }

  Future<void> deletePicksBySegment({required Segment segment}) async {
    var picks = await collection
        .where('segmentReference', isEqualTo: segment.reference)
        .get();

    for (var doc in picks.docs) {
      collection.doc(doc.reference.id).delete();
    }
  }
}
