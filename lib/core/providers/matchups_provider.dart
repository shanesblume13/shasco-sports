import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/core/providers/legs_provider.dart';
import 'package:pick/core/services/firestore_matchup_service.dart';

final allMatchupsStateProvider =
    StateNotifierProvider<AllMatchupsState, AsyncValue<List<Matchup>>>((ref) {
  final AllMatchupsState allMatchupsState = AllMatchupsState();
  allMatchupsState.init();
  return allMatchupsState;
});

final matchupsBySelectedLegStateProvider = StateNotifierProvider<
    MatchupsBySelectedLegState, AsyncValue<List<Matchup>>>((ref) {
  final MatchupsBySelectedLegState matchupsBySelectedLegState =
      MatchupsBySelectedLegState(ref);
  matchupsBySelectedLegState.init();
  return matchupsBySelectedLegState;
});

final selectedMatchupStateProvider =
    StateNotifierProvider<SelectedMatchupState, Matchup?>((ref) {
  return SelectedMatchupState();
});

class AllMatchupsState extends StateNotifier<AsyncValue<List<Matchup>>> {
  AllMatchupsState() : super(const AsyncLoading<List<Matchup>>());

  void init() async {
    state = const AsyncLoading<List<Matchup>>();
    final matchups = await FirestoreMatchupService().fetchMathchups(null);
    state = AsyncData<List<Matchup>>(matchups);
  }
}

class MatchupsBySelectedLegState
    extends StateNotifier<AsyncValue<List<Matchup>>> {
  MatchupsBySelectedLegState(this.ref)
      : super(const AsyncLoading<List<Matchup>>());

  final Ref ref;

  void init() async {
    final Leg? selectedLegState = ref.watch(selectedLegStateProvider);

    state = const AsyncLoading<List<Matchup>>();
    final allMatchups = ref.watch(allMatchupsStateProvider).value;
    List<Matchup> matchups = [];

    if (selectedLegState != null) {
      matchups = allMatchups
              ?.where((matchup) =>
                  matchup.legReference == selectedLegState.reference)
              .toList() ??
          [];
    } else {
      matchups = allMatchups ?? [];
    }

    state = AsyncData<List<Matchup>>(matchups);
  }
}

class SelectedMatchupState extends StateNotifier<Matchup?> {
  SelectedMatchupState() : super(null);

  void select(Matchup? matchup) {
    state = matchup;
  }
}
