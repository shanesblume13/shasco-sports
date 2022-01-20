import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick/core/models/season_model.dart';
import 'package:pick/core/services/season_api_service.dart';
import 'package:pick/locator.dart';

class SeasonViewModel extends ChangeNotifier {
  final SeasonApiService _apiService = locator<SeasonApiService>();

  Future<List<Season>> fetchSeasons(String league) async {
    List<Season> seasons = [];
    var result = await _apiService.getDataCollection();

    seasons = result.docs
        .map(
          (doc) => Season.fromQueryDocumentSnapshot(doc, doc.id),
        )
        .where((season) => season.league.toLowerCase() == league.toLowerCase())
        .toList();

    return seasons;
  }

  Stream<List<Season>> fetchSeasonsAsStream(String league) {
    Stream<List<Season>> seasonsStream;
    Stream<QuerySnapshot<Map<String, dynamic>>> result =
        _apiService.streamDataCollection();

    seasonsStream = result.map(
      (snapshot) {
        return snapshot.docs
            .map(
              (doc) => Season.fromQueryDocumentSnapshot(doc, doc.id),
            )
            .where(
                (season) => season.league.toLowerCase() == league.toLowerCase())
            .toList();
      },
    );

    return seasonsStream;
  }

  Future<Season> getSeasonById(String id) async {
    var doc = await _apiService.getDocumentById(id);
    return Season.fromDocumentSnapshot(doc, doc.id);
  }

  Future removeSeason(String id) async {
    await _apiService.removeDocument(id);
    return;
  }

  Future updateSeason(Season data, String id) async {
    await _apiService.updateDocument(data.toJson(), id);
    return;
  }

  Future addSeason(Season data) async {
    // var result = await _apiService.addDocument(data.toJson());
    await _apiService.addDocument(data.toJson());

    return;
  }
}
