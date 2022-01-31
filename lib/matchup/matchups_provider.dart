import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/matchup/matchup.dart';
import 'package:pick/matchup/matchups_firestore_service.dart';
import 'package:pick/segment/segment.dart';
import 'package:pick/segment/selected_segment_provider.dart';

final matchupsStateProvider =
    StateNotifierProvider<MatchupsState, AsyncValue<List<Matchup>>>((ref) {
  final MatchupsState matchupsState = MatchupsState();
  matchupsState.init();

  return matchupsState;
});

final matchupsBySelectedSegmentStateProvider = StateNotifierProvider<
    MatchupsBySelectedSegmentState, AsyncValue<List<Matchup>>>((ref) {
  final MatchupsBySelectedSegmentState matchupsBySelectedSegmentState =
      MatchupsBySelectedSegmentState(ref);
  matchupsBySelectedSegmentState.init();

  return matchupsBySelectedSegmentState;
});

class MatchupsState extends StateNotifier<AsyncValue<List<Matchup>>> {
  MatchupsState() : super(const AsyncLoading<List<Matchup>>());

  void init() async {
    state = const AsyncLoading<List<Matchup>>();
    final List<Matchup> matchups =
        await MatchupsFirestoreService().fetchMatchups();
    state = AsyncData<List<Matchup>>(matchups);
  }
}

class MatchupsBySelectedSegmentState
    extends StateNotifier<AsyncValue<List<Matchup>>> {
  MatchupsBySelectedSegmentState(this.ref)
      : super(const AsyncLoading<List<Matchup>>());

  final Ref ref;

  void init() async {
    state = const AsyncLoading<List<Matchup>>();
    final Segment selectedSegment = ref.watch(selectedSegmentStateProvider)!;
    final List<Matchup> matchups = await MatchupsFirestoreService()
        .fetchMatchupsBySegment(segment: selectedSegment);
    state = AsyncData<List<Matchup>>(matchups);
  }
}
