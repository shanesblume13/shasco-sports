import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/sport_league_count.dart';
import 'package:pick/core/models/sport_model.dart';
import 'package:pick/core/providers/leagues_provider.dart';

final sportsStateProvider = StateNotifierProvider<Sports, List<Sport>>((ref) {
  return Sports(ref);
});

final selectedSportStateProvider =
    StateNotifierProvider<SelectedSportState, Sport?>((ref) {
  return SelectedSportState(ref);
});

final sportLeagueCountsStateProvider =
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

class SelectedSportState extends StateNotifier<Sport?> {
  SelectedSportState(this.ref) : super(null);

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
    List<Sport> sports = ref.watch(sportsStateProvider);
    List<SportLeagueCount> sportLeagueCounts = [];

    for (Sport sport in sports) {
      sportLeagueCounts.add(SportLeagueCount(
        sport: sport,
        count: ref
                .watch(allLeaguesStateProvider)
                .value
                ?.where((league) =>
                    league.sport.toLowerCase() == sport.name.toLowerCase())
                .length ??
            0,
      ));
    }

    state = sportLeagueCounts;
  }
}
