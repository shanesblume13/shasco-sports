import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/league_model.dart';
import 'package:pick/core/models/sport_model.dart';
import 'package:pick/core/providers/sports_provider.dart';

final allLeaguesProvider =
    StateNotifierProvider<AllLeagues, List<League>>((ref) {
  return AllLeagues(ref);
});

final leaguesBySelectedSportProvider =
    StateNotifierProvider<LeaguesBySelectedSport, List<League>>((ref) {
  return LeaguesBySelectedSport(ref);
});

class AllLeagues extends StateNotifier<List<League>> {
  AllLeagues(this.ref) : super([]) {
    getLeagues();
  }

  final Ref ref;

  void getLeagues() {
    state = League.leagues.toList();
  }
}

class LeaguesBySelectedSport extends StateNotifier<List<League>> {
  LeaguesBySelectedSport(this.ref) : super([]) {
    getLeagues();
  }

  final Ref ref;

  void getLeagues() {
    Sport? selectedSport = ref.watch(selectedSportProvider);

    state = League.leagues
        .where((league) =>
            league.sport.toLowerCase() == selectedSport?.name.toLowerCase())
        .toList();
  }
}
