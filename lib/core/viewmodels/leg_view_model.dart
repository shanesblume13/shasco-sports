import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/services/api_service.dart';
import 'package:pick/locator.dart';

class LegViewModel extends ChangeNotifier {
  final ApiService _apiService = locator<ApiService>();

  List<Leg> legs = [];

  Future<List<Leg>> fetcLegs() async {
    var result = await _apiService.getDataCollection();
    legs = result.docs
        .map((doc) => Leg.fromQueryDocumentSnapshot(doc, doc.id))
        .toList();
    return legs;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchLegsAsStream() {
    return _apiService.streamDataCollection();
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
    var result = await _apiService.addDocument(data.toJson());

    return;
  }
}
