import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/league_model.dart';
import 'package:pick/core/models/season_leg_count_model.dart';
import 'package:pick/core/models/season_model.dart';
import 'package:pick/core/providers/legs_provider.dart';
import 'package:pick/core/services/firestore_season_service.dart';

final allSeasonsStateProvider =
    StateNotifierProvider<AllSeasonsState, AsyncValue<List<Season>>>((ref) {
  final AllSeasonsState allSeasonsState = AllSeasonsState();
  allSeasonsState.init();
  return allSeasonsState;
});

final seasonsByLeagueStateProvider = StateNotifierProvider.family<
    SeasonsByLeagueState, AsyncValue<List<Season>>, League>((ref, league) {
  final SeasonsByLeagueState seasonsByLeagueState =
      SeasonsByLeagueState(ref, league);
  seasonsByLeagueState.init();
  return seasonsByLeagueState;
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
    final List<Season> seasons =
        await FirestoreSeasonService().fetchSeasons('');
    state = AsyncData<List<Season>>(seasons);
  }
}

class SeasonsByLeagueState extends StateNotifier<AsyncValue<List<Season>>> {
  SeasonsByLeagueState(this.ref, this.league)
      : super(const AsyncLoading<List<Season>>());

  final Ref ref;
  final League league;

  void init() async {
    state = const AsyncLoading<List<Season>>();
    final List<Season>? allSeasons = ref.watch(allSeasonsStateProvider).value;
    List<Season> seasons = [];

    seasons = allSeasons
            ?.where((season) =>
                season.league.toLowerCase() == league.name.toLowerCase())
            .toList() ??
        [];

    state = AsyncData<List<Season>>(seasons);
  }
}

class SeasonLegCountsState extends StateNotifier<List<SeasonLegCount>> {
  SeasonLegCountsState(this.ref) : super([]);

  final Ref ref;

  void init() {
    final List<Season>? seasons = ref.watch(allSeasonsStateProvider).value;
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
