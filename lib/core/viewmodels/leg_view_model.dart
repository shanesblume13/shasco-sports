import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/services/leg_api_service.dart';
import 'package:pick/locator.dart';

class LegViewModel extends ChangeNotifier {
  final LegApiService _apiService = locator<LegApiService>();

  List<Leg> legs = [];

  Future<List<Leg>> fetchLegs(String seasonId) async {
    // TODO: use SeasonId to fetch legs (docRef?)
    var result = await _apiService.getDataCollection();
    legs = result.docs
        .map((doc) => Leg.fromQueryDocumentSnapshot(doc, doc.id))
        .toList();
    return legs;
  }

  Stream<List<Leg>> fetchLegsAsStream(String seasonId) {
    Stream<List<Leg>> legsStream;
    Stream<QuerySnapshot<Map<String, dynamic>>> result =
        _apiService.streamDataCollection();

    legsStream = result.map(
      (snapshot) {
        return snapshot.docs
            .map(
              (doc) => Leg.fromQueryDocumentSnapshot(doc, doc.id),
            )
            .where(
                (leg) => leg.seasonId.toLowerCase() == seasonId.toLowerCase())
            .toList();
      },
    );

    return legsStream;
  }

  Future<Leg> getLegById(String id) async {
    var doc = await _apiService.getDocumentById(id);
    return Leg.fromDocumentSnapshot(doc, doc.id);
  }

  Future removeLeg(String id) async {
    await _apiService.removeDocument(id);
    return;
  }

  Future updateLeg(Leg data, String id) async {
    await _apiService.updateDocument(data.toJson(), id);
    return;
  }

  Future addLeg(Leg data) async {
    // var result = await _apiService.addDocument(data.toJson());
    await _apiService.addDocument(data.toJson());

    return;
  }
}
