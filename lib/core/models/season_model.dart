import 'package:cloud_firestore/cloud_firestore.dart';

class Season {
  String id;
  String name;
  String league;
  String startDate;
  String endDate;

  Season({
    required this.id,
    required this.name,
    required this.league,
    required this.startDate,
    required this.endDate,
  });

  Season.fromQueryDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot, this.id)
      : name = snapshot['name'],
        league = snapshot['league'],
        startDate = snapshot['startDate'],
        endDate = snapshot['endDate'];

  Season.fromDocumentSnapshot(DocumentSnapshot snapshot, this.id)
      : name = snapshot['name'],
        league = snapshot['league'],
        startDate = snapshot['startDate'],
        endDate = snapshot['endDate'];

  toJson() {
    return {
      'name': name,
      'league': league,
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}
