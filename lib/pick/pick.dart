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

  Pick copyWith(
      {DocumentReference? reference,
      String? uid,
      DocumentReference? segmentReference,
      DocumentReference? matchupReference,
      DocumentReference? teamReference,
      int? points}) {
    return Pick(
      reference: reference ?? this.reference,
      uid: uid ?? this.uid,
      segmentReference: segmentReference ?? this.segmentReference,
      matchupReference: matchupReference ?? this.matchupReference,
      teamReference: teamReference ?? this.teamReference,
      points: points ?? this.points,
    );
  }

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
