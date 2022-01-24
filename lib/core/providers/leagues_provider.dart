import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/league_model.dart';
import 'package:pick/core/models/sport_model.dart';
import 'package:pick/core/providers/sports_provider.dart';

final leaguesProvider = StateNotifierProvider<Leagues, List<League>>((ref) {
  return Leagues(ref);
});

final selectedSportProvider =
    StateNotifierProvider<SelectedSport, Sport?>((ref) {
  return SelectedSport(ref);
});

class Leagues extends StateNotifier<List<League>> {
  Leagues(this.ref) : super([]) {
    load();
  }

  final Ref ref;

  void load() {
    state = League.leagues;
  }

  void loadBySelectedSport() {
    Sport? sport = ref.watch(selectedSportProvider);

    state =
        League.leagues.where((league) => league.sport == sport?.name).toList();
  }
}

// TODO: Remove this
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
