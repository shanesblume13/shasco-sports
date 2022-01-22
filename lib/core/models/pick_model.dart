import 'package:cloud_firestore/cloud_firestore.dart';

class Pick {
  String id;
  String uid;
  DocumentReference matchupReference;
  DocumentReference? teamReference;
  int points;

  Pick({
    required this.id,
    required this.uid,
    required this.matchupReference,
    this.teamReference,
    required this.points,
  });

  Pick.fromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot, this.id)
      : uid = snapshot['uid'] as String,
        matchupReference = snapshot['matchupReference'] as DocumentReference,
        teamReference = snapshot['teamReference'] as DocumentReference,
        points = snapshot['points'] as int;

  Pick.fromDocumentSnapshot(DocumentSnapshot snapshot, this.id)
      : uid = snapshot['uid'] as String,
        matchupReference = snapshot['matchupReference'] as DocumentReference,
        teamReference = snapshot['teamReference'] as DocumentReference,
        points = snapshot['points'] as int;

  toJson() {
    return {
      'uid': uid,
      'matchupReference': matchupReference,
      'teamReference': teamReference,
      'points': points,
    };
  }
}
