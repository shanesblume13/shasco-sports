import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick/core/models/season_model.dart';
import 'package:pick/core/services/api_service.dart';
import 'package:pick/locator.dart';

class SeasonViewModel extends ChangeNotifier {
  final ApiService _apiService = locator<ApiService>();

  List<Season> seasons = [];

  Future<List<Season>> fetchSeasons(String? league) async {
    var result = await _apiService.getDataCollection();

    if (league == null || league == '') {
      seasons = result.docs
          .map((doc) => Season.fromQueryDocumentSnapshot(doc, doc.id))
          .toList();
    } else {
      seasons = result.docs
          .map((doc) => Season.fromQueryDocumentSnapshot(doc, doc.id))
          .toList();
    }

    return seasons;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchSeasonsAsStream(
      String? league) {
    return _apiService.streamDataCollection();
  }

  Future<Season> getSeasonById(String id) async {
    var doc = await _apiService.getDocumentById(id);
    return Season.fromDocumentSnapshot(doc, doc.id);
  }

  Future removeSeason(String id) async {
    await _apiService.removeDocument(id);
    return;
  }

  Future updateLeg(Season data, String id) async {
    await _apiService.updateDocument(data.toJson(), id);
    return;
  }

  Future addLeg(Season data) async {
    var result = await _apiService.addDocument(data.toJson());

    return;
  }
}
