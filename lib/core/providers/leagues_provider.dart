import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/league_model.dart';
import 'package:pick/core/models/sport_model.dart';
import 'package:pick/core/providers/sports_provider.dart';

final leaguesProvider = StateNotifierProvider<Leagues, List<League>>((ref) {
  return Leagues(ref);
});

class Leagues extends StateNotifier<List<League>> {
  Leagues(this.ref) : super([]) {
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
