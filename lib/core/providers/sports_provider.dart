import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/sport_league_count.dart';
import 'package:pick/core/models/sport_model.dart';
import 'package:pick/core/providers/leagues_provider.dart';

final allSportsStateProvider =
    StateNotifierProvider<Sports, List<Sport>>((ref) {
  return Sports(ref);
});

final sportLeagueCountsStateProvider =
    StateNotifierProvider<SportLeagueCountsState, List<SportLeagueCount>>(
        (ref) {
  return SportLeagueCountsState(ref);
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

class SportLeagueCountsState extends StateNotifier<List<SportLeagueCount>> {
  SportLeagueCountsState(this.ref) : super([]) {
    getSportLeagueCounts();
  }

  final Ref ref;

  void getSportLeagueCounts() {
    List<Sport> sports = ref.watch(allSportsStateProvider);
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
