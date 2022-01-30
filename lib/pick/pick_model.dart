import 'package:cloud_firestore/cloud_firestore.dart';

class Pick {
  DocumentReference? reference;
  String uid;
  DocumentReference segmentReference;
  DocumentReference matchupReference;
  DocumentReference? teamReference;
  int points;

  Pick({
    required this.reference,
    required this.uid,
    required this.segmentReference,
    required this.matchupReference,
    this.teamReference,
    required this.points,
  });

  Pick.fromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot, this.reference)
      : uid = snapshot['uid'] as String,
        segmentReference = snapshot['segmentReference'] as DocumentReference,
        matchupReference = snapshot['matchupReference'] as DocumentReference,
        teamReference = snapshot['teamReference'] as DocumentReference,
        points = snapshot['points'] as int;

  Pick.fromDocumentSnapshot(DocumentSnapshot snapshot, this.reference)
      : uid = snapshot['uid'] as String,
        segmentReference = snapshot['segmentReference'] as DocumentReference,
        matchupReference = snapshot['matchupReference'] as DocumentReference,
        teamReference = snapshot['teamReference'] as DocumentReference,
        points = snapshot['points'] as int;

  toJson() {
    return {
      'reference': reference,
      'uid': uid,
      'segmentReference': segmentReference,
      'matchupReference': matchupReference,
      'teamReference': teamReference,
      'points': points,
    };
  }
}
