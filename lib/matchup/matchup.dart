import 'package:cloud_firestore/cloud_firestore.dart';

class Matchup {
  DocumentReference? reference;
  DocumentReference awayTeamReference;
  DocumentReference homeTeamReference;
  DocumentReference? winningTeamReference;
  DateTime startDateTime;
  DateTime lockDateTime;
  bool isLocked;
  bool isComplete;
  double homeTeamSpread;
  DocumentReference segmentReference;

  Matchup({
    required this.reference,
    required this.awayTeamReference,
    required this.homeTeamReference,
    this.winningTeamReference,
    required this.startDateTime,
    required this.lockDateTime,
    required this.isLocked,
    required this.isComplete,
    required this.homeTeamSpread,
    required this.segmentReference,
  });

  Matchup.fromQueryDocumentSnapshot(
    QueryDocumentSnapshot snapshot,
    this.reference,
  )   : awayTeamReference = snapshot['awayTeamReference'] as DocumentReference,
        homeTeamReference = snapshot['homeTeamReference'] as DocumentReference,
        // winningTeamReference =
        //     snapshot['winningTeamReference'] as DocumentReference?,
        startDateTime = (snapshot['startDateTime'] as Timestamp).toDate(),
        lockDateTime = (snapshot['lockDateTime'] as Timestamp).toDate(),
        isLocked = snapshot['isLocked'] as bool,
        isComplete = snapshot['isComplete'] as bool,
        homeTeamSpread =
            double.tryParse(snapshot['homeTeamSpread'].toString()) ?? 0.0,
        segmentReference = snapshot['segmentReference'] as DocumentReference;

  Matchup.fromDocumentSnapshot(DocumentSnapshot snapshot, this.reference)
      : awayTeamReference = snapshot['awayTeamReference'] as DocumentReference,
        homeTeamReference = snapshot['homeTeamReference'] as DocumentReference,
        // winningTeamReference =
        //     snapshot['winningTeamReference'] as DocumentReference?,
        startDateTime = (snapshot['startDateTime'] as Timestamp).toDate(),
        lockDateTime = (snapshot['lockDateTime'] as Timestamp).toDate(),
        isLocked = snapshot['isLocked'] as bool,
        isComplete = snapshot['isComplete' as bool],
        homeTeamSpread =
            double.tryParse(snapshot['homeTeamSpread'].toString()) ?? 0.0,
        segmentReference = snapshot['segmentReference'] as DocumentReference;

  toJson() {
    return {
      'awayTeamReference': homeTeamReference,
      'homeTeamReference': awayTeamReference,
      'winningTeamReference': winningTeamReference,
      'startDateTime': startDateTime,
      'lockDateTime': lockDateTime,
      'isLocked': isLocked,
      'isComplete': isComplete,
      'homeTeamSpread': homeTeamSpread,
      'segmentReference': segmentReference,
    };
  }
}
