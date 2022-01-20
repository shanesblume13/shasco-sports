import 'package:cloud_firestore/cloud_firestore.dart';

class Team {
  String id;
  int leagueId;
  String location;
  String nickname;
  String imagePath;
  DocumentReference? reference;

  Team({
    required this.id,
    required this.leagueId,
    required this.location,
    required this.nickname,
    required this.imagePath,
    this.reference,
  });

  Team.fromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot, this.id)
      : leagueId = snapshot['leagueId'] as int,
        location = snapshot['location'] as String,
        nickname = snapshot['nickname'] as String,
        imagePath = 'assets/images/logos/nfl/${snapshot['nickname']}.gif',
        reference = snapshot.reference;

  Team.fromDocumentSnapshot(DocumentSnapshot snapshot, this.id)
      : leagueId = snapshot['leagueId'] as int,
        location = snapshot['location'] as String,
        nickname = snapshot['nickname'] as String,
        imagePath = 'assets/images/logos/nfl/${snapshot['nickname']}.gif',
        reference = snapshot.reference;
}
