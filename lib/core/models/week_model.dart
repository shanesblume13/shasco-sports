import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pick/core/models/season.dart';

class Week {
  String id;
  String name;
  String startDate;
  String lockDate;
  String endDate;
  bool isLocked;
  bool isComplete;
  Season? season;

  Week({
    required this.id,
    required this.name,
    required this.startDate,
    required this.lockDate,
    required this.endDate,
    required this.isLocked,
    required this.isComplete,
    this.season,
  });

  Week.fromQueryDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot, this.id)
      : name = snapshot['name'],
        startDate = snapshot['startDate'],
        lockDate = snapshot['lockDate'],
        endDate = snapshot['endDate'],
        isLocked = snapshot['isLocked'],
        isComplete = snapshot['isComplete'],
        season = Season.fromQueryDocumentSnapshot(
            snapshot['season'], snapshot['season']['id']);

  Week.fromDocumentSnapshot(DocumentSnapshot snapshot, this.id)
      : name = snapshot['name'],
        startDate = snapshot['startDate'],
        lockDate = snapshot['lockDate'],
        endDate = snapshot['endDate'],
        isLocked = snapshot['isLocked'],
        isComplete = snapshot['isComplete'],
        season = Season.fromDocumentSnapshot(
            snapshot['season'], snapshot['season']['id']);

  toJson() {
    return {
      'name': name,
      'startDate': startDate,
      'lockDate': lockDate,
      'endDate': endDate,
      'isLocked': isLocked,
      'isComplete': isComplete,
      'season': season?.toJson(),
    };
  }
}
