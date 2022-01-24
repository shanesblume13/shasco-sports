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

final leaguesBySelectedSportStateProvider = StateNotifierProvider<
    LeaguesBySelectedSportState, AsyncValue<List<League>>>((ref) {
  final LeaguesBySelectedSportState leaguesBySelectedSportState =
      LeaguesBySelectedSportState(ref);
  leaguesBySelectedSportState.init();
  return leaguesBySelectedSportState;
});

final selectedLeagueStateProvider =
    StateNotifierProvider<SelectedLeagueState, League?>((ref) {
  return SelectedLeagueState();
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

class LeaguesBySelectedSportState
    extends StateNotifier<AsyncValue<List<League>>> {
  LeaguesBySelectedSportState(this.ref)
      : super(const AsyncLoading<List<League>>());

  final Ref ref;

  void init() async {
    final Sport? selectedSportState = ref.watch(selectedSportStateProvider);

    state = const AsyncLoading<List<League>>();
    final leagues = await Future.delayed(const Duration(seconds: 1)).then((_) {
      if (selectedSportState != null) {
        return League.leagues
            .where((league) =>
                league.sport.toLowerCase() ==
                selectedSportState.name.toLowerCase())
            .toList();
      } else {
        return League.leagues;
      }
    });

    state = AsyncData<List<League>>(leagues);
  }
}

class SelectedLeagueState extends StateNotifier<League?> {
  SelectedLeagueState() : super(null);

  void select(League? league) {
    state = league;
  }
}
