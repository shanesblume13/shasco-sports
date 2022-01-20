import 'package:cloud_firestore/cloud_firestore.dart';

class Season {
  String id;
  String name;
  String league;
  DateTime startDate;
  DateTime endDate;
  DocumentReference reference;

  Season({
    required this.id,
    required this.name,
    required this.league,
    required this.startDate,
    required this.endDate,
    required this.reference,
  });

  Season.fromQueryDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot, this.id)
      : name = snapshot['name'],
        league = snapshot['league'],
        startDate = (snapshot['startDate'] as Timestamp).toDate(),
        endDate = (snapshot['endDate'] as Timestamp).toDate(),
        reference = snapshot.reference;

  Season.fromDocumentSnapshot(DocumentSnapshot snapshot, this.id)
      : name = snapshot['name'],
        league = snapshot['league'],
        startDate = (snapshot['startDate'] as Timestamp).toDate(),
        endDate = (snapshot['endDate'] as Timestamp).toDate(),
        reference = snapshot.reference;

  toJson() {
    return {
      'name': name,
      'league': league,
      'startDate': startDate,
      'endDate': endDate,
      'reference': reference,
    };
  }
}
