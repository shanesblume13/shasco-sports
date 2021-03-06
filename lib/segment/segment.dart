import 'package:cloud_firestore/cloud_firestore.dart';

class Segment {
  DocumentReference? reference;
  String name;
  DateTime startDate;
  DateTime lockDate;
  DateTime endDate;
  bool isLocked;
  bool isComplete;
  DocumentReference seasonReference;

  Segment({
    this.reference,
    required this.name,
    required this.startDate,
    required this.lockDate,
    required this.endDate,
    required this.isLocked,
    required this.isComplete,
    required this.seasonReference,
  });

  Segment.fromQueryDocumentSnapshot(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
    this.reference,
  )   : name = snapshot['name'] as String,
        startDate = (snapshot['startDate'] as Timestamp).toDate(),
        lockDate = (snapshot['lockDate'] as Timestamp).toDate(),
        endDate = (snapshot['endDate'] as Timestamp).toDate(),
        isLocked = snapshot['isLocked'] as bool,
        isComplete = snapshot['isComplete'] as bool,
        seasonReference = snapshot['seasonReference'] as DocumentReference;

  Segment.fromDocumentSnapshot(
    DocumentSnapshot snapshot,
    this.reference,
  )   : name = snapshot['name'] as String,
        startDate = (snapshot['startDate'] as Timestamp).toDate(),
        lockDate = (snapshot['lockDate'] as Timestamp).toDate(),
        endDate = (snapshot['endDate'] as Timestamp).toDate(),
        isLocked = snapshot['isLocked'] as bool,
        isComplete = snapshot['isComplete'] as bool,
        seasonReference = snapshot['seasonReference'] as DocumentReference;
}
