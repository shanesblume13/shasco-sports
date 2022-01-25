import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/leg_matchup_count_model.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/models/season_model.dart';
import 'package:pick/core/providers/matchups_provider.dart';
import 'package:pick/core/providers/seasons_provider.dart';
import 'package:pick/core/services/firestore_leg_service.dart';

final allLegsStateProvider =
    StateNotifierProvider<AllLegsState, AsyncValue<List<Leg>>>((ref) {
  final AllLegsState allLegsState = AllLegsState();
  allLegsState.init();
  return allLegsState;
});

final legsBySelectedSeasonStateProvider =
    StateNotifierProvider<LegsBySelectedSeasonState, AsyncValue<List<Leg>>>(
        (ref) {
  final LegsBySelectedSeasonState legsBySelectedSeasonState =
      LegsBySelectedSeasonState(ref);
  legsBySelectedSeasonState.init();
  return legsBySelectedSeasonState;
});

final selectedLegStateProvider =
    StateNotifierProvider<SelectedLegState, Leg?>((ref) {
  return SelectedLegState();
});

final legMatchupCountsStateProvider =
    StateNotifierProvider<LegMatchupCountsState, List<LegMatchupCount>>((ref) {
  final LegMatchupCountsState legMatchupCountsState =
      LegMatchupCountsState(ref);
  legMatchupCountsState.init();
  return legMatchupCountsState;
});

class AllLegsState extends StateNotifier<AsyncValue<List<Leg>>> {
  AllLegsState() : super(const AsyncLoading<List<Leg>>());

  void init() async {
    state = const AsyncLoading<List<Leg>>();
    final legs = await FirestoreLegService().fetchLegs(null);
    state = AsyncData<List<Leg>>(legs);
  }
}

class LegsBySelectedSeasonState extends StateNotifier<AsyncValue<List<Leg>>> {
  LegsBySelectedSeasonState(this.ref) : super(const AsyncLoading<List<Leg>>());

  final Ref ref;

  void init() async {
    final Season? selectedSeasonState = ref.watch(selectedSeasonStateProvider);

    state = const AsyncLoading<List<Leg>>();
    final allLegs = ref.watch(allLegsStateProvider).value;
    List<Leg> legs = [];

    if (selectedSeasonState != null) {
      legs = allLegs
              ?.where(
                  (leg) => leg.seasonReference == selectedSeasonState.reference)
              .toList() ??
          [];
    } else {
      legs = allLegs ?? [];
    }

    state = AsyncData<List<Leg>>(legs);
  }
}

class SelectedLegState extends StateNotifier<Leg?> {
  SelectedLegState() : super(null);

  void select(Leg? leg) {
    state = leg;
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
