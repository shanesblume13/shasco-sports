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

final matchupsBySegmentStateProvider = StateNotifierProvider.family<
    MatchupsBySegmentState, AsyncValue<List<Matchup>>, Segment>((ref, segment) {
  final MatchupsBySegmentState matchupsBySegmentState =
      MatchupsBySegmentState(ref, segment);
  matchupsBySegmentState.init();
  return matchupsBySegmentState;
});

final selectedSegmentMatchupsStateProvider = StateNotifierProvider<
    SelectedSegmentMatchupsState, AsyncValue<List<Matchup>>>((ref) {
  final SelectedSegmentMatchupsState selectedSegmentMatchupsState =
      SelectedSegmentMatchupsState(ref);
  selectedSegmentMatchupsState.init();
  return selectedSegmentMatchupsState;
});

class AllMatchupsState extends StateNotifier<AsyncValue<List<Matchup>>> {
  AllMatchupsState() : super(const AsyncLoading<List<Matchup>>());

  void init() async {
    state = const AsyncLoading<List<Matchup>>();
    final matchups = await FirestoreMatchupService().fetchMathchups(null);
    state = AsyncData<List<Matchup>>(matchups);
  }
}

class MatchupsBySegmentState extends StateNotifier<AsyncValue<List<Matchup>>> {
  MatchupsBySegmentState(this.ref, this.segment)
      : super(const AsyncLoading<List<Matchup>>());

  final Ref ref;
  final Segment segment;

  void init() async {
    state = const AsyncLoading<List<Matchup>>();
    final allMatchups = ref.watch(allMatchupsStateProvider).value;
    List<Matchup> matchups = [];

    matchups = allMatchups
            ?.where((matchup) => matchup.segmentReference.id == segment.id)
            .toList() ??
        [];

    state = AsyncData<List<Matchup>>(matchups);
  }
}

class SelectedSegmentMatchupsState
    extends StateNotifier<AsyncValue<List<Matchup>>> {
  SelectedSegmentMatchupsState(this.ref)
      : super(const AsyncLoading<List<Matchup>>());

  final Ref ref;

  void init() async {
    state = const AsyncLoading<List<Matchup>>();
    final selectedSegment = ref.watch(selectedSegmentStateProvider);
    final selectedSegmentMatchups =
        ref.watch(matchupsBySegmentStateProvider(selectedSegment!)).value;

    if (selectedSegmentMatchups != null) {
      state = AsyncData<List<Matchup>>(selectedSegmentMatchups);
    }
  }
}
