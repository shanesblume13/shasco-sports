import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/models/season_model.dart';
import 'package:pick/core/services/firestore_api_service.dart';

class FirestoreLegService extends ChangeNotifier {
  final FirestoreApiService _apiService = FirestoreApiService('legs');

  Future<List<Leg>> fetchLegs(Season? season) async {
    List<Leg> legs = [];
    var result = await _apiService.getDataCollection();

    if (season == null) {
      legs = result.docs
          .map(
            (doc) => Leg.fromQueryDocumentSnapshot(doc, doc.id),
          )
          .toList();
    } else {
      legs = result.docs
          .map(
            (doc) => Leg.fromQueryDocumentSnapshot(doc, doc.id),
          )
          .where((leg) => leg.seasonReference == season.reference)
          .toList();
    }

    return legs;
  }

  Stream<List<Leg>> fetchLegsAsStream(Season? season) {
    Stream<List<Leg>> legsStream;
    Stream<QuerySnapshot<Map<String, dynamic>>> result =
        _apiService.streamDataCollection();

    if (season == null) {
      legsStream = result.map(
        (snapshot) {
          return snapshot.docs
              .map(
                (doc) => Leg.fromQueryDocumentSnapshot(doc, doc.id),
              )
              .toList();
        },
      );
    } else {
      legsStream = result.map(
        (snapshot) {
          return snapshot.docs
              .map(
                (doc) => Leg.fromQueryDocumentSnapshot(doc, doc.id),
              )
              .where((leg) => leg.seasonReference == season.reference)
              .toList();
        },
      );
    }

    return legsStream;
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
