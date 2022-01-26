import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick/core/models/league_model.dart';
import 'package:pick/core/models/team_model.dart';
import 'package:pick/core/services/firestore_api_service.dart';

class FirestoreTeamService extends ChangeNotifier {
  final FirestoreApiService _apiService = FirestoreApiService('teams');

  Future<List<Team>> fetchTeams(League? league) async {
    List<Team> teams = [];
    var result = await _apiService.getDataCollection();

    if (league == null) {
      teams = result.docs
          .map(
            (doc) => Team.fromQueryDocumentSnapshot(doc, doc.id),
          )
          .toList();
    } else {
      teams = result.docs
          .map(
            (doc) => Team.fromQueryDocumentSnapshot(doc, doc.id),
          )
          .where((team) => team.leagueId == league.id)
          .toList();
    }

    return teams;
  }

  Stream<List<Team>> fetchTeamsAsStream(League? league) {
    Stream<List<Team>> teamsStream;
    Stream<QuerySnapshot<Map<String, dynamic>>> result =
        _apiService.streamDataCollection();

    if (league == null) {
      teamsStream = result.map(
        (snapshot) {
          return snapshot.docs
              .map(
                (doc) => Team.fromQueryDocumentSnapshot(doc, doc.id),
              )
              .toList();
        },
      );
    } else {
      teamsStream = result.map(
        (snapshot) {
          return snapshot.docs
              .map(
                (doc) => Team.fromQueryDocumentSnapshot(doc, doc.id),
              )
              .where((team) => team.leagueId == league.id)
              .toList();
        },
      );
    }

    return teamsStream;
  }
}
