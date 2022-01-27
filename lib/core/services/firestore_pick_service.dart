import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/core/models/pick_model.dart';
import 'package:pick/core/services/firestore_api_service.dart';

class FirestorePickService extends ChangeNotifier {
  final FirestoreApiService _apiService = FirestoreApiService('picks');

  Future<List<Pick>> fetchPicks(Matchup? matchup) async {
    List<Pick> picks = [];
    var result = await _apiService.getDataCollection();

    if (matchup == null) {
      picks = result.docs
          .map(
            (doc) => Pick.fromQueryDocumentSnapshot(doc, doc.id),
          )
          .toList();
    } else {
      picks = result.docs
          .map(
            (doc) => Pick.fromQueryDocumentSnapshot(doc, doc.id),
          )
          .where((pick) => pick.matchupReference == matchup.reference)
          .toList();
    }

    return picks;
  }

  Stream<List<Pick>> fetchPicksAsStream(Matchup? matchup) {
    Stream<List<Pick>> picksStream;
    Stream<QuerySnapshot<Map<String, dynamic>>> result =
        _apiService.streamDataCollection();

    if (matchup == null) {
      picksStream = result.map(
        (snapshot) {
          return snapshot.docs
              .map(
                (doc) => Pick.fromQueryDocumentSnapshot(doc, doc.id),
              )
              .toList();
        },
      );
    } else {
      picksStream = result.map(
        (snapshot) {
          return snapshot.docs
              .map(
                (doc) => Pick.fromQueryDocumentSnapshot(doc, doc.id),
              )
              .where((pick) => pick.matchupReference == matchup.reference)
              .toList();
        },
      );
    }

    return picksStream;
  }

  Future createPick(Pick pick) async {
    await _apiService.addDocument(pick.toJson());
    return;
  }

  Future updatePick(Pick pick) async {
    await _apiService.updateDocument(pick.toJson(), pick.id);
    return;
  }

  Future removePick(Pick pick) async {
    await _apiService.removeDocument(pick.id);
    return;
  }

  // Future<Season> getSeasonById(String id) async {
  //   var doc = await _apiService.getDocumentById(id);
  //   return Season.fromDocumentSnapshot(doc, doc.id);
  // }

  // Future removeSeason(String id) async {
  //   await _apiService.removeDocument(id);
  //   return;
  // }

  // Future updateSeason(Season data, String id) async {
  //   await _apiService.updateDocument(data.toJson(), id);
  //   return;
  // }

  // Future addSeason(Season data) async {
  //   // var result = await _apiService.addDocument(data.toJson());
  //   await _apiService.addDocument(data.toJson());

  //   return;
  // }
}
