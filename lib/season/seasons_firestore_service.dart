import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick/core/models/league_model.dart';
import 'package:pick/core/models/season_model.dart';

class SeasonsFirestoreService extends ChangeNotifier {
  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('seasons');

  Future<List<Season>> fetchSeasons() async {
    var result = await collection.get();

    return result.docs
        .map(
          (doc) => Season.fromQueryDocumentSnapshot(doc, doc.id),
        )
        .toList();
  }

  Future<List<Season>> fetchSeasonsByLeague({required League league}) async {
    var result =
        await collection.where('leagueReference', isEqualTo: league.name).get();

    return result.docs
        .map(
          (doc) => Season.fromQueryDocumentSnapshot(doc, doc.id),
        )
        .toList();
  }
}