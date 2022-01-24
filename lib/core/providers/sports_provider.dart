import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/sport_league_count.dart';
import 'package:pick/core/models/sport_model.dart';
import 'package:pick/core/providers/leagues_provider.dart';

final sportsProvider = StateNotifierProvider<Sports, List<Sport>>((ref) {
  return Sports(ref);
});

final selectedSportProvider =
    StateNotifierProvider<SelectedSport, Sport?>((ref) {
  return SelectedSport(ref);
});

final sportLeagueCountsProvider =
    StateNotifierProvider<SportLeagueCounts, List<SportLeagueCount>>((ref) {
  return SportLeagueCounts(ref);
});

class Sports extends StateNotifier<List<Sport>> {
  Sports(this.ref) : super([]) {
    getSports();
  }

  final Ref ref;

  void getSports() {
    state = Sport.sports;
  }
}

class SelectedSport extends StateNotifier<Sport?> {
  SelectedSport(this.ref) : super(null) {
    select(null);
  }

  final Ref ref;

  void select(Sport? sport) {
    state = sport;
  }
}

class SportLeagueCounts extends StateNotifier<List<SportLeagueCount>> {
  SportLeagueCounts(this.ref) : super([]) {
    getSportLeagueCounts();
  }

  final Ref ref;

  void getSportLeagueCounts() {
    List<Sport> sports = ref.watch(sportsProvider);
    List<SportLeagueCount> sportLeagueCounts = [];

    for (Sport sport in sports) {
      sportLeagueCounts.add(SportLeagueCount(
        sport: sport,
        count: ref
            .watch(allLeaguesProvider)
            .where((league) =>
                league.sport.toLowerCase() == sport.name.toLowerCase())
            .length,
      ));
    }

    state = sportLeagueCounts;
  }
}
