import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/league/league.dart';
import 'package:pick/sport/sport.dart';
import 'package:pick/sport/selected_sport_provider.dart';

final leaguesStateProvider =
    StateNotifierProvider<LeaguesState, AsyncValue<List<League>>>((ref) {
  final LeaguesState leaguesState = LeaguesState();
  leaguesState.init();

  return leaguesState;
});

final leaguesBySelectedSportStateProvider = StateNotifierProvider<
    LeaguesBySelectedSportState, AsyncValue<List<League>>>((ref) {
  final LeaguesBySelectedSportState leaguesBySelectedSportState =
      LeaguesBySelectedSportState(ref);
  leaguesBySelectedSportState.init();

  return leaguesBySelectedSportState;
});

class LeaguesState extends StateNotifier<AsyncValue<List<League>>> {
  LeaguesState() : super(const AsyncLoading<List<League>>());

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
    final Sport sport = ref.watch(selectedSportStateProvider)!;
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
