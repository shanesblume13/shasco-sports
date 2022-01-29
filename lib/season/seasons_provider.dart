import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/league/league.dart';
import 'package:pick/season/season.dart';
import 'package:pick/league/selected_league_provider.dart';
import 'package:pick/season/seasons_firestore_service.dart';

final seasonsStateProvider =
    StateNotifierProvider<SeasonsState, AsyncValue<List<Season>>>((ref) {
  final SeasonsState seasonsState = SeasonsState();
  seasonsState.init();
  return seasonsState;
});

final seasonsBySelectedLeagueStateProvider = StateNotifierProvider<
    SeasonsBySelectedLeagueState, AsyncValue<List<Season>>>((ref) {
  final SeasonsBySelectedLeagueState seasonsBySelectedLeagueState =
      SeasonsBySelectedLeagueState(ref);
  seasonsBySelectedLeagueState.init();
  return seasonsBySelectedLeagueState;
});

class SeasonsState extends StateNotifier<AsyncValue<List<Season>>> {
  SeasonsState() : super(const AsyncLoading<List<Season>>());

  void init() async {
    state = const AsyncLoading<List<Season>>();
    final List<Season> seasons = await SeasonsFirestoreService().fetchSeasons();
    state = AsyncData<List<Season>>(seasons);
  }
}

class SeasonsBySelectedLeagueState
    extends StateNotifier<AsyncValue<List<Season>>> {
  SeasonsBySelectedLeagueState(this.ref)
      : super(const AsyncLoading<List<Season>>());

  final Ref ref;

  void init() async {
    state = const AsyncLoading<List<Season>>();
    final League selectedLeague = ref.watch(selectedLeagueProvider)!;
    final List<Season> seasons = await SeasonsFirestoreService()
        .fetchSeasonsByLeague(league: selectedLeague);
    state = AsyncData<List<Season>>(seasons);
  }
}
