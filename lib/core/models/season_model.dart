import 'package:cloud_firestore/cloud_firestore.dart';

class Season {
  String id;
  String name;
  String league;
  String startDate;
  String endDate;
  bool isLocked;
  bool isComplete;

  Season({
    required this.id,
    required this.name,
    required this.league,
    required this.startDate,
    required this.endDate,
    required this.isLocked,
    required this.isComplete,
  });

  Season.fromQueryDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot, this.id)
      : name = snapshot['name'],
        league = snapshot['league'],
        startDate = snapshot['startDate'],
        endDate = snapshot['endDate'],
        isLocked = snapshot['isLocked'],
        isComplete = snapshot['isComplete'];

  Season.fromDocumentSnapshot(DocumentSnapshot snapshot, this.id)
      : name = snapshot['name'],
        league = snapshot['league'],
        startDate = snapshot['startDate'],
        endDate = snapshot['endDate'],
        isLocked = snapshot['isLocked'],
        isComplete = snapshot['isComplete'];

  toJson() {
    return {
      'name': name,
      'league': league,
      'startDate': startDate,
      'endDate': endDate,
      'isLocked': isLocked,
      'isComplete': isComplete,
    };
  }
}
