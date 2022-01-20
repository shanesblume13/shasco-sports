import 'package:cloud_firestore/cloud_firestore.dart';

class Matchup {
  String id;
  int homeTeamId;
  int awayTeamId;
  DateTime startDateTime;
  DateTime lockDateTime;
  bool isLocked;
  bool isComplete;
  double homeTeamSpread;
  int winningTeamId;
  DocumentReference legReference;
  DocumentReference? reference;

  Matchup({
    required this.id,
    required this.homeTeamId,
    required this.awayTeamId,
    required this.startDateTime,
    required this.lockDateTime,
    required this.isLocked,
    required this.isComplete,
    required this.homeTeamSpread,
    required this.winningTeamId,
    required this.legReference,
    this.reference,
  });

  Matchup.fromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot, this.id)
      : homeTeamId = snapshot['homeTeamId'] as int,
        awayTeamId = snapshot['awayTeamId'] as int,
        startDateTime = (snapshot['startDateTime'] as Timestamp).toDate(),
        lockDateTime = (snapshot['lockDateTime'] as Timestamp).toDate(),
        isLocked = snapshot['isLocked'] as bool,
        isComplete = snapshot['isComplete'] as bool,
        homeTeamSpread = snapshot['homeTeamSpread'] as double,
        winningTeamId = snapshot['winningTeamId'] as int,
        legReference = snapshot['legReference'] as DocumentReference,
        reference = snapshot.reference;

  Matchup.fromDocumentSnapshot(DocumentSnapshot snapshot, this.id)
      : homeTeamId = snapshot['homeTeamId'] as int,
        awayTeamId = snapshot['awayTeamId'] as int,
        startDateTime = (snapshot['startDateTime'] as Timestamp).toDate(),
        lockDateTime = (snapshot['lockDateTime'] as Timestamp).toDate(),
        isLocked = snapshot['isLocked'] as bool,
        isComplete = snapshot['isComplete' as bool],
        homeTeamSpread = snapshot['homeTeamSpread'] as double,
        winningTeamId = snapshot['winningTeamId'] as int,
        legReference = snapshot['legReference'] as DocumentReference,
        reference = snapshot.reference;

  toJson() {
    return {
      'homeTeamId': homeTeamId,
      'awayTeamId': awayTeamId,
      'startDateTime': startDateTime,
      'lockDateTime': lockDateTime,
      'isLocked': isLocked,
      'isComplete': isComplete,
      'homeTeamSpread': homeTeamSpread,
      'winningTeamId': winningTeamId,
      'legReference': legReference,
      'reference': reference,
    };
  }
}
