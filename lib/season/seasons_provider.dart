import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/season_model.dart';
import 'package:pick/core/services/firestore_season_service.dart';
import 'package:pick/league/selected_league_provider.dart';

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
    final List<Season> seasons =
        await FirestoreSeasonService().fetchSeasons('');
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
    final List<Season>? allSeasons = ref.watch(seasonsStateProvider).value;
    final league = ref.watch(selectedLeagueProvider)!;
    List<Season> seasons = [];

    seasons = allSeasons
            ?.where((season) =>
                season.league.toLowerCase() == league.name.toLowerCase())
            .toList() ??
        [];

    state = AsyncData<List<Season>>(seasons);
  }
}
