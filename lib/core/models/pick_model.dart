import 'package:cloud_firestore/cloud_firestore.dart';

class Pick {
  String id;
  String uid;
  DocumentReference legReference;
  DocumentReference matchupReference;
  DocumentReference? teamReference;
  int points;

  Pick({
    required this.id,
    required this.uid,
    required this.legReference,
    required this.matchupReference,
    this.teamReference,
    required this.points,
  });

  Pick.fromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot, this.id)
      : uid = snapshot['uid'] as String,
        legReference = snapshot['legReference'] as DocumentReference,
        matchupReference = snapshot['matchupReference'] as DocumentReference,
        teamReference = snapshot['teamReference'] as DocumentReference,
        points = snapshot['points'] as int;

  Pick.fromDocumentSnapshot(DocumentSnapshot snapshot, this.id)
      : uid = snapshot['uid'] as String,
        legReference = snapshot['legReference'] as DocumentReference,
        matchupReference = snapshot['matchupReference'] as DocumentReference,
        teamReference = snapshot['teamReference'] as DocumentReference,
        points = snapshot['points'] as int;

  toJson() {
    return {
      'uid': uid,
      'legReference': legReference,
      'matchupReference': matchupReference,
      'teamReference': teamReference,
      'points': points,
    };
  }
}
