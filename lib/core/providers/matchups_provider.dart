import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/core/services/firestore_matchup_service.dart';
import 'package:pick/segment/segment.dart';
import 'package:pick/segment/selected_segment_provider.dart';

final allMatchupsStateProvider =
    StateNotifierProvider<AllMatchupsState, AsyncValue<List<Matchup>>>((ref) {
  final AllMatchupsState allMatchupsState = AllMatchupsState();
  allMatchupsState.init();
  return allMatchupsState;
});

final matchupsByLegStateProvider = StateNotifierProvider.family<
    MatchupsByLegState, AsyncValue<List<Matchup>>, Segment>((ref, leg) {
  final MatchupsByLegState matchupsByLegState = MatchupsByLegState(ref, leg);
  matchupsByLegState.init();
  return matchupsByLegState;
});

final selectedLegMatchupsStateProvider =
    StateNotifierProvider<SelectedLegMatchupsState, AsyncValue<List<Matchup>>>(
        (ref) {
  final SelectedLegMatchupsState selectedLegMatchupsState =
      SelectedLegMatchupsState(ref);
  selectedLegMatchupsState.init();
  return selectedLegMatchupsState;
});

class AllMatchupsState extends StateNotifier<AsyncValue<List<Matchup>>> {
  AllMatchupsState() : super(const AsyncLoading<List<Matchup>>());

  void init() async {
    state = const AsyncLoading<List<Matchup>>();
    final matchups = await FirestoreMatchupService().fetchMathchups(null);
    state = AsyncData<List<Matchup>>(matchups);
  }
}

class MatchupsByLegState extends StateNotifier<AsyncValue<List<Matchup>>> {
  MatchupsByLegState(this.ref, this.segment)
      : super(const AsyncLoading<List<Matchup>>());

  final Ref ref;
  final Segment segment;

  void init() async {
    state = const AsyncLoading<List<Matchup>>();
    final allMatchups = ref.watch(allMatchupsStateProvider).value;
    List<Matchup> matchups = [];

    matchups = allMatchups
            ?.where((matchup) => matchup.legReference.id == segment.id)
            .toList() ??
        [];

    state = AsyncData<List<Matchup>>(matchups);
  }
}

class SelectedLegMatchupsState
    extends StateNotifier<AsyncValue<List<Matchup>>> {
  SelectedLegMatchupsState(this.ref)
      : super(const AsyncLoading<List<Matchup>>());

  final Ref ref;

  void init() async {
    state = const AsyncLoading<List<Matchup>>();
    final selectedLeg = ref.watch(selectedSegmentStateProvider);
    final selectedLegMatchups =
        ref.watch(matchupsByLegStateProvider(selectedLeg!)).value;

    if (selectedLegMatchups != null) {
      state = AsyncData<List<Matchup>>(selectedLegMatchups);
    }
  }
}
