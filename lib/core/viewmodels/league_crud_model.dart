import 'package:pick/core/models/league_model.dart';

class LeagueCrudModel {
  List<League> leagues = [
    League(
      id: 1,
      name: 'NFL',
      imagePath: 'assets/images/logos/nfl/nfl.jpeg',
      sport: 'football',
    ),
    League(
      id: 2,
      name: 'NCAAF',
      imagePath: 'assets/images/logos/ncaa/ncaa.jpeg',
      sport: 'football',
    ),
    League(
      id: 3,
      name: 'NCAAM',
      imagePath: 'assets/images/logos/ncaa/ncaa.jpeg',
      sport: 'basketball',
    ),
  ];

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
