import 'package:pick/core/models/league_model.dart';

class LeagueViewModel {
  List<League> leagues = League.leagues;

  List<League> fetchLeagues({String? sport}) {
    if (sport == null || sport.isEmpty) {
      return leagues;
    } else {
      return leagues
          .where((league) => league.sport.toLowerCase() == sport.toLowerCase())
          .toList();
    }
  }

  League getLeagueById(int id) {
    return leagues.firstWhere((sport) => sport.id == id);
  }
}
