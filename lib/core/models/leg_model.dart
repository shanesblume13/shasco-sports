import 'package:cloud_firestore/cloud_firestore.dart';

class Leg {
  String id;
  String name;
  DateTime startDate;
  DateTime lockDate;
  DateTime endDate;
  bool isLocked;
  bool isComplete;
  DocumentReference seasonReference;
  DocumentReference? reference;

  Leg({
    required this.id,
    required this.name,
    required this.startDate,
    required this.lockDate,
    required this.endDate,
    required this.isLocked,
    required this.isComplete,
    required this.seasonReference,
    this.reference,
  });

  Leg.fromQueryDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot, this.id)
      : name = snapshot['name'] as String,
        startDate = (snapshot['startDate'] as Timestamp).toDate(),
        lockDate = (snapshot['lockDate'] as Timestamp).toDate(),
        endDate = (snapshot['endDate'] as Timestamp).toDate(),
        isLocked = snapshot['isLocked'] as bool,
        isComplete = snapshot['isComplete'] as bool,
        seasonReference = snapshot['seasonReference'] as DocumentReference,
        reference = snapshot.reference;

  Leg.fromDocumentSnapshot(DocumentSnapshot snapshot, this.id)
      : name = snapshot['name'] as String,
        startDate = (snapshot['startDate'] as Timestamp).toDate(),
        lockDate = (snapshot['lockDate'] as Timestamp).toDate(),
        endDate = (snapshot['endDate'] as Timestamp).toDate(),
        isLocked = snapshot['isLocked'] as bool,
        isComplete = snapshot['isComplete'] as bool,
        seasonReference = snapshot['seasonReference'] as DocumentReference,
        reference = snapshot.reference;

  toJson() {
    return {
      'name': name,
      'startDate': startDate,
      'lockDate': lockDate,
      'endDate': endDate,
      'isLocked': isLocked,
      'isComplete': isComplete,
      'seasonReference': seasonReference,
      'reference': reference,
    };
  }
}
