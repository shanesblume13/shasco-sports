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
    this.reference,
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
        winningTeamReference =
            getWinningTeamReferencefromQueryDocumentSnapshot(snapshot),
        startDateTime = (snapshot['startDateTime'] as Timestamp).toDate(),
        lockDateTime = (snapshot['lockDateTime'] as Timestamp).toDate(),
        isLocked = snapshot['isLocked'] as bool,
        isComplete = snapshot['isComplete'] as bool,
        homeTeamSpread =
            double.tryParse(snapshot['homeTeamSpread'].toString()) ?? 0.0,
        segmentReference = snapshot['segmentReference'] as DocumentReference;

  static DocumentReference? getWinningTeamReferencefromQueryDocumentSnapshot(
    QueryDocumentSnapshot<Object?> snapshot,
  ) {
    DocumentReference? result;

    try {
      result = snapshot['winningTeamReference'] as DocumentReference?;
    } catch (e) {
      result = null;
    }

    return result;
  }

  Matchup.fromDocumentSnapshot(DocumentSnapshot snapshot, this.reference)
      : awayTeamReference = snapshot['awayTeamReference'] as DocumentReference,
        homeTeamReference = snapshot['homeTeamReference'] as DocumentReference,
        winningTeamReference =
            getWinningTeamReferencefromDocumentSnapshot(snapshot),
        startDateTime = (snapshot['startDateTime'] as Timestamp).toDate(),
        lockDateTime = (snapshot['lockDateTime'] as Timestamp).toDate(),
        isLocked = snapshot['isLocked'] as bool,
        isComplete = snapshot['isComplete' as bool],
        homeTeamSpread =
            double.tryParse(snapshot['homeTeamSpread'].toString()) ?? 0.0,
        segmentReference = snapshot['segmentReference'] as DocumentReference;

  static dynamic getWinningTeamReferencefromDocumentSnapshot(
    DocumentSnapshot<Object?> snapshot,
  ) {
    DocumentReference? result;

    try {
      result = snapshot['winningTeamReference'] as DocumentReference?;
    } catch (e) {
      result = null;
    }

    return result;
  }
}
