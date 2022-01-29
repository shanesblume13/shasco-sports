import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/league_model.dart';
import 'package:pick/core/models/league_season_count_model.dart';
import 'package:pick/core/models/sport_model.dart';
import 'package:pick/core/providers/seasons_provider.dart';
import 'package:pick/sport/selected_sport_provider.dart';

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

final leagueSeasonCountsStateProvider =
    StateNotifierProvider<LeagueSeasonCountsState, List<LeagueSeasonCount>>(
        (ref) {
  final LeagueSeasonCountsState leagueSeasonCountsState =
      LeagueSeasonCountsState(ref);
  leagueSeasonCountsState.init();
  return leagueSeasonCountsState;
});

class AllLeaguesState extends StateNotifier<AsyncValue<List<League>>> {
  AllLeaguesState() : super(const AsyncLoading<List<League>>());

  void init() async {
    state = const AsyncLoading<List<League>>();
    //TODO: Remove delayed when leagues are on firestore.
    final leagues = await Future.delayed(const Duration(milliseconds: 100))
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
    state = const AsyncLoading<List<League>>();
    final Sport sport = ref.watch(selectedSportProvider)!;
    //TODO: Remove delayed when leagues are on firestore.
    final leagues =
        await Future.delayed(const Duration(milliseconds: 100)).then((_) {
      return League.leagues
          .where((league) =>
              league.sport.toLowerCase() == sport.name.toLowerCase())
          .toList();
    });

    state = AsyncData<List<League>>(leagues);
  }
}

class LeagueSeasonCountsState extends StateNotifier<List<LeagueSeasonCount>> {
  LeagueSeasonCountsState(this.ref) : super([]);

  final Ref ref;

  void init() {
    List<League>? leagues = ref.watch(allLeaguesStateProvider).value;
    List<LeagueSeasonCount> leagueSeasonCounts = [];

    if (leagues != null) {
      for (League league in leagues) {
        leagueSeasonCounts.add(LeagueSeasonCount(
          league: league,
          count: ref
                  .watch(allSeasonsStateProvider)
                  .value
                  ?.where((season) =>
                      season.league.toLowerCase() == league.name.toLowerCase())
                  .length ??
              0,
        ));
      }
    }

    state = leagueSeasonCounts;
  }
}
