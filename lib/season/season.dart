import 'package:cloud_firestore/cloud_firestore.dart';

class Season {
  DocumentReference? reference;
  String name;
  String league;
  DateTime startDate;
  DateTime endDate;

  Season({
    required this.reference,
    required this.name,
    required this.league,
    required this.startDate,
    required this.endDate,
  });

  Season.fromQueryDocumentSnapshot(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
    this.reference,
  )   : name = snapshot['name'] as String,
        league = snapshot['league'] as String,
        startDate = (snapshot['startDate'] as Timestamp).toDate(),
        endDate = (snapshot['endDate'] as Timestamp).toDate();

  Season.fromDocumentSnapshot(
    DocumentSnapshot snapshot,
    this.reference,
  )   : name = snapshot['name'] as String,
        league = snapshot['league'] as String,
        startDate = (snapshot['startDate'] as Timestamp).toDate(),
        endDate = (snapshot['endDate'] as Timestamp).toDate();

  toJson() {
    return {
      'reference': reference,
      'name': name,
      'league': league,
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}
