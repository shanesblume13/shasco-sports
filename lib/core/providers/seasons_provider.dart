import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/league_model.dart';
import 'package:pick/core/models/season_leg_count_model.dart';
import 'package:pick/core/models/season_model.dart';
import 'package:pick/core/providers/leagues_provider.dart';
import 'package:pick/core/providers/legs_provider.dart';
import 'package:pick/core/services/firestore_season_service.dart';

final allSeasonsStateProvider =
    StateNotifierProvider<AllSeasonsState, AsyncValue<List<Season>>>((ref) {
  final AllSeasonsState allSeasonsState = AllSeasonsState();
  allSeasonsState.init();
  return allSeasonsState;
});

final seasonsBySelectedLeagueStateProvider = StateNotifierProvider<
    SeasonsBySelectedLeagueState, AsyncValue<List<Season>>>((ref) {
  final SeasonsBySelectedLeagueState seasonsBySelectedLeagueState =
      SeasonsBySelectedLeagueState(ref);
  seasonsBySelectedLeagueState.init();
  return seasonsBySelectedLeagueState;
});

final selectedSeasonStateProvider =
    StateNotifierProvider<SelectedSeasonState, Season?>((ref) {
  return SelectedSeasonState();
});

final seasonLegCountsStateProvider =
    StateNotifierProvider<SeasonLegCountsState, List<SeasonLegCount>>((ref) {
  final SeasonLegCountsState seasonLegCountsState = SeasonLegCountsState(ref);
  seasonLegCountsState.init();
  return seasonLegCountsState;
});

class AllSeasonsState extends StateNotifier<AsyncValue<List<Season>>> {
  AllSeasonsState() : super(const AsyncLoading<List<Season>>());

  void init() async {
    state = const AsyncLoading<List<Season>>();
    final seasons = await FirestoreSeasonService().fetchSeasons('');
    state = AsyncData<List<Season>>(seasons);
  }
}

class SeasonsBySelectedLeagueState
    extends StateNotifier<AsyncValue<List<Season>>> {
  SeasonsBySelectedLeagueState(this.ref)
      : super(const AsyncLoading<List<Season>>());

  final Ref ref;

  void init() async {
    final League? selectedLeagueState = ref.watch(selectedLeagueStateProvider);

    state = const AsyncLoading<List<Season>>();
    final allSeasons = ref.watch(allSeasonsStateProvider).value;
    List<Season> seasons = [];

    if (selectedLeagueState != null) {
      seasons = allSeasons
              ?.where((season) =>
                  season.league.toLowerCase() ==
                  selectedLeagueState.name.toLowerCase())
              .toList() ??
          [];
    } else {
      seasons = allSeasons ?? [];
    }

    state = AsyncData<List<Season>>(seasons);
  }
}

class SelectedSeasonState extends StateNotifier<Season?> {
  SelectedSeasonState() : super(null);

  void select(Season? season) {
    state = season;
  }
}

class SeasonLegCountsState extends StateNotifier<List<SeasonLegCount>> {
  SeasonLegCountsState(this.ref) : super([]);

  final Ref ref;

  void init() {
    List<Season>? seasons = ref.watch(allSeasonsStateProvider).value;
    List<SeasonLegCount> seasonLegCounts = [];

    if (seasons != null) {
      for (Season season in seasons) {
        seasonLegCounts.add(SeasonLegCount(
          season: season,
          count: ref
                  .watch(allLegsStateProvider)
                  .value
                  ?.where((leg) => leg.seasonReference == season.reference)
                  .length ??
              0,
        ));
      }
    }

    state = seasonLegCounts;
  }
}
