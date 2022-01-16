import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick/core/models/week_model.dart';
import 'package:pick/core/services/api_service.dart';
import 'package:pick/locator.dart';

class WeekCrudModel extends ChangeNotifier {
  final ApiService _apiService = locator<ApiService>();

  List<Week> weeks = [];

  Future<List<Week>> fetchWeeks() async {
    var result = await _apiService.getDataCollection();
    weeks = result.docs
        .map((doc) => Week.fromQueryDocumentSnapshot(doc, doc.id))
        .toList();
    return weeks;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchWeeksAsStream() {
    return _apiService.streamDataCollection();
  }

  Future<Week> getWeekById(String id) async {
    var doc = await _apiService.getDocumentById(id);
    return Week.fromDocumentSnapshot(doc, doc.id);
  }

  Future removeWeek(String id) async {
    await _apiService.removeDocument(id);
    return;
  }

  Future updateWeek(Week data, String id) async {
    await _apiService.updateDocument(data.toJson(), id);
    return;
  }

  Future addWeek(Week data) async {
    var result = await _apiService.addDocument(data.toJson());

    return;
  }
}
