import 'package:cloud_firestore/cloud_firestore.dart';

class Team {
  DocumentReference? reference;
  int leagueId;
  String location;
  String nickname;
  String imagePath;

  Team({
    required this.reference,
    required this.leagueId,
    required this.location,
    required this.nickname,
    required this.imagePath,
  });

  Team.fromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot, this.reference)
      : leagueId = snapshot['leagueId'] as int,
        location = snapshot['location'] as String,
        nickname = snapshot['nickname'] as String,
        imagePath = 'assets/images/logos/nfl/${snapshot['nickname']}.gif';

  Team.fromDocumentSnapshot(DocumentSnapshot snapshot, this.reference)
      : leagueId = snapshot['leagueId'] as int,
        location = snapshot['location'] as String,
        nickname = snapshot['nickname'] as String,
        imagePath = 'assets/images/logos/nfl/${snapshot['nickname']}.gif';
}
