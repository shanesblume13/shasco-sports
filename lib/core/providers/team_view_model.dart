import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick/core/models/league_model.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/core/models/team_model.dart';
import 'package:pick/core/services/team_api_service.dart';
import 'package:pick/locator.dart';

class TeamViewModel extends ChangeNotifier {
  final TeamApiService _apiService = locator<TeamApiService>();

  List<Team> teams = [];

  Future<List<Team>> fetchTeams({
    required League league,
  }) async {
    var result = await _apiService.getDataCollection();
    teams = result.docs
        .map((doc) => Team.fromQueryDocumentSnapshot(doc, doc.id))
        .where((team) => team.leagueId == league.id)
        .toList();

    teams.sort((a, b) => a.location.compareTo(b.location));
    return teams;
  }

  Stream<List<Team>> fetchMatchupsAsStream({
    required League league,
  }) {
    Stream<List<Team>> teamsStream;
    Stream<QuerySnapshot<Map<String, dynamic>>> result =
        _apiService.streamDataCollection();

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

    return teamsStream;
  }

  Future<Team> getTeamById(String id) async {
    var doc = await _apiService.getDocumentById(id);
    return Team.fromDocumentSnapshot(doc, doc.id);
  }

  Future<List<Team>> getTeamsByMatchup(Matchup matchup) async {
    List<Team> teams = [];
    DocumentSnapshot awayTeamDocument =
        await _apiService.getDocumentById(matchup.awayTeamReference.id);
    DocumentSnapshot homeTeamDocument =
        await _apiService.getDocumentById(matchup.homeTeamReference.id);
    //DocumentSnapshot winningTeamDocument = await _apiService.getDocumentById(matchup.homeTeamReference.id);

    teams.add(Team.fromDocumentSnapshot(awayTeamDocument, awayTeamDocument.id));
    teams.add(Team.fromDocumentSnapshot(homeTeamDocument, homeTeamDocument.id));

    return teams;
  }
}
