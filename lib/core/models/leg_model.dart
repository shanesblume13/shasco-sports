import 'package:cloud_firestore/cloud_firestore.dart';

class Leg {
  String id;
  String name;
  String startDate;
  String lockDate;
  String endDate;
  bool isLocked;
  bool isComplete;
  String seasonId;

  Leg({
    required this.id,
    required this.name,
    required this.startDate,
    required this.lockDate,
    required this.endDate,
    required this.isLocked,
    required this.isComplete,
    required this.seasonId,
  });

  Leg.fromQueryDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot, this.id)
      : name = snapshot['name'],
        startDate = snapshot['startDate'],
        lockDate = snapshot['lockDate'],
        endDate = snapshot['endDate'],
        isLocked = snapshot['isLocked'],
        isComplete = snapshot['isComplete'],
        seasonId = snapshot['seasonId'];

  Leg.fromDocumentSnapshot(DocumentSnapshot snapshot, this.id)
      : name = snapshot['name'],
        startDate = snapshot['startDate'],
        lockDate = snapshot['lockDate'],
        endDate = snapshot['endDate'],
        isLocked = snapshot['isLocked'],
        isComplete = snapshot['isComplete'],
        seasonId = snapshot['seasonId'];

  toJson() {
    return {
      'name': name,
      'startDate': startDate,
      'lockDate': lockDate,
      'endDate': endDate,
      'isLocked': isLocked,
      'isComplete': isComplete,
      'seasonId': seasonId,
    };
  }
}
