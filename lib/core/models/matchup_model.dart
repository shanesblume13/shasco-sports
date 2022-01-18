import 'package:cloud_firestore/cloud_firestore.dart';

class Matchup {
  String id;
  DocumentReference legId;
  int legOrder;
  String homeTeamId;
  String awayTeamId;
  bool isLocked;
  bool isComplete;
  double homeTeamSpread;
  String winningTeamId;

  Matchup({
    required this.id,
    required this.legId,
    required this.legOrder,
    required this.homeTeamId,
    required this.awayTeamId,
    required this.isLocked,
    required this.isComplete,
    required this.homeTeamSpread,
    required this.winningTeamId,
  });

  Matchup.fromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot, this.id)
      : legId = snapshot['legId'],
        legOrder = snapshot['legOrder'],
        homeTeamId = snapshot['homeTeamId'],
        awayTeamId = snapshot['awayTeamId'],
        isLocked = snapshot['isLocked'],
        isComplete = snapshot['isComplete'],
        homeTeamSpread = snapshot['homeTeamSpread'],
        winningTeamId = snapshot['winningTeamId'];

  Matchup.fromDocumentSnapshot(DocumentSnapshot snapshot, this.id)
      : legId = snapshot['legId'],
        legOrder = snapshot['legOrder'],
        homeTeamId = snapshot['homeTeamId'],
        awayTeamId = snapshot['awayTeamId'],
        isLocked = snapshot['isLocked'],
        isComplete = snapshot['isComplete'],
        homeTeamSpread = snapshot['homeTeamSpread'],
        winningTeamId = snapshot['winningTeamId'];

  Matchup.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        legId = map['legId'],
        legOrder = map['legOrder'],
        homeTeamId = map['homeTeamId'],
        awayTeamId = map['awayTeamId'],
        isLocked = map['isLocked'],
        isComplete = map['isComplete'],
        homeTeamSpread = map['homeTeamSpread'],
        winningTeamId = map['winningTeamId'];

  toJson() {
    return {
      'legId': legId,
      'legOrder': legOrder,
      'homeTeamId': homeTeamId,
      'awayTeamId': awayTeamId,
      'isLocked': isLocked,
      'isComplete': isComplete,
      'homeTeamSpread': homeTeamSpread,
      'winningTeamId': winningTeamId,
    };
  }
}
