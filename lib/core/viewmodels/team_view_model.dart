import 'package:pick/core/models/team_model.dart';

class TeamViewModel {
  List<Team> teams = Team.teams;

  List<Team> fetchTeamsByLeague({required int leagueId}) {
    return teams.where((team) => team.leagueId == leagueId).toList();
  }

  Team getTeamById(int id) {
    return teams.firstWhere((game) => game.id == id);
  }
}
