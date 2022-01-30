import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick/league/league.dart';
import 'package:pick/season/season.dart';

class SeasonsFirestoreService extends ChangeNotifier {
  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('seasons');

  Future<List<Season>> fetchSeasons() async {
    var result = await collection.get();

    return result.docs
        .map(
          (doc) => Season.fromQueryDocumentSnapshot(doc, doc.reference),
        )
        .toList();
  }

  Future<List<Season>> fetchSeasonsByLeague({required League league}) async {
    var result =
        await collection.where('leagueReference', isEqualTo: league.name).get();

    return result.docs
        .map(
          (doc) => Season.fromQueryDocumentSnapshot(doc, doc.reference),
        )
        .toList();
  }
}
