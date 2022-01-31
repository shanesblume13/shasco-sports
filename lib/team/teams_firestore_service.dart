import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick/league/league.dart';
import 'package:pick/team/team.dart';

class TeamsFirestoreService extends ChangeNotifier {
  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('teams');

  Future<List<Team>> fetchTeams() async {
    var result = await collection.get();

    return result.docs
        .map(
          (doc) => Team.fromQueryDocumentSnapshot(doc, doc.reference),
        )
        .toList();
  }

  Future<List<Team>> fetchTeamsByLeague({required League league}) async {
    var result = await collection.where('leagueId', isEqualTo: league.id).get();

    return result.docs
        .map(
          (doc) => Team.fromQueryDocumentSnapshot(doc, doc.reference),
        )
        .toList();
  }
}
