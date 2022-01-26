import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/leg_matchup_count_model.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/models/season_model.dart';
import 'package:pick/core/providers/matchups_provider.dart';
import 'package:pick/core/services/firestore_leg_service.dart';

final allLegsStateProvider =
    StateNotifierProvider<AllLegsState, AsyncValue<List<Leg>>>((ref) {
  final AllLegsState allLegsState = AllLegsState();
  allLegsState.init();
  return allLegsState;
});

final legsBySeasonStateProvider = StateNotifierProvider.family<
    LegsBySeasonState, AsyncValue<List<Leg>>, Season>((ref, season) {
  final LegsBySeasonState legsBySeasonState = LegsBySeasonState(ref, season);
  legsBySeasonState.init();
  return legsBySeasonState;
});

final legMatchupCountsStateProvider =
    StateNotifierProvider<LegMatchupCountsState, List<LegMatchupCount>>((ref) {
  final LegMatchupCountsState legMatchupCountsState =
      LegMatchupCountsState(ref);
  legMatchupCountsState.init();
  return legMatchupCountsState;
});

final selectedLegStateProvider =
    StateNotifierProvider<SelectedLegState, Leg?>((ref) {
  final SelectedLegState selectedLegState = SelectedLegState();
  return selectedLegState;
});

class AllLegsState extends StateNotifier<AsyncValue<List<Leg>>> {
  AllLegsState() : super(const AsyncLoading<List<Leg>>());

  void init() async {
    state = const AsyncLoading<List<Leg>>();
    final legs = await FirestoreLegService().fetchLegs(null);
    state = AsyncData<List<Leg>>(legs);
  }
}

class LegsBySeasonState extends StateNotifier<AsyncValue<List<Leg>>> {
  LegsBySeasonState(this.ref, this.season)
      : super(const AsyncLoading<List<Leg>>());

  final Ref ref;
  final Season season;

  void init() async {
    state = const AsyncLoading<List<Leg>>();
    final allLegs = ref.watch(allLegsStateProvider).value;
    List<Leg> legs = [];

    legs = allLegs
            ?.where((leg) => leg.seasonReference == season.reference)
            .toList() ??
        [];

    state = AsyncData<List<Leg>>(legs);
  }
}

class LegMatchupCountsState extends StateNotifier<List<LegMatchupCount>> {
  LegMatchupCountsState(this.ref) : super([]);

  final Ref ref;

  void init() {
    List<Leg>? legs = ref.watch(allLegsStateProvider).value;
    List<LegMatchupCount> legMatchupCounts = [];

    if (legs != null) {
      for (Leg leg in legs) {
        legMatchupCounts.add(LegMatchupCount(
          leg: leg,
          count: ref
                  .watch(allMatchupsStateProvider)
                  .value
                  ?.where((matchup) => matchup.legReference == leg.reference)
                  .length ??
              0,
        ));
      }
    }

    state = legMatchupCounts;
  }
}

class SelectedLegState extends StateNotifier<Leg?> {
  SelectedLegState() : super(null);

  void selectLeague(Leg leg) {
    state = leg;
  }
}
