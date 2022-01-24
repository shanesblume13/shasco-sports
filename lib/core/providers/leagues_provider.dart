import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/league_model.dart';
import 'package:pick/core/models/sport_model.dart';
import 'package:pick/core/providers/sports_provider.dart';

final allLeaguesStateProvider =
    StateNotifierProvider<AllLeaguesState, AsyncValue<List<League>>>((ref) {
  final AllLeaguesState allLeaguesState = AllLeaguesState();
  allLeaguesState.init();
  return allLeaguesState;
});

final leaguesBySelectedSportProvider =
    StateNotifierProvider<LeaguesBySelectedSport, List<League>>((ref) {
  return LeaguesBySelectedSport(ref);
});

final selectedLeagueStateProvider =
    StateNotifierProvider<SelectedLeagueState, League?>((ref) {
  return SelectedLeagueState(ref);
});

class AllLeaguesState extends StateNotifier<AsyncValue<List<League>>> {
  AllLeaguesState() : super(const AsyncLoading<List<League>>());

  void init() async {
    state = const AsyncLoading<List<League>>();
    final leagues = await Future.delayed(const Duration(seconds: 1))
        .then((_) => League.leagues);
    state = AsyncData<List<League>>(leagues);
  }
}

class LeaguesBySelectedSport extends StateNotifier<List<League>> {
  LeaguesBySelectedSport(this.ref) : super([]) {
    getLeagues();
  }

  final Ref ref;

  void getLeagues() {
    Sport? selectedSport = ref.watch(selectedSportStateProvider);

    state = League.leagues
        .where((league) =>
            league.sport.toLowerCase() == selectedSport?.name.toLowerCase())
        .toList();
  }
}

class SelectedLeagueState extends StateNotifier<League?> {
  SelectedLeagueState(this.ref) : super(null);

  final Ref ref;

  void select(League? league) {
    state = league;
  }
}
