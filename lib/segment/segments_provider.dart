import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/season/season.dart';
import 'package:pick/season/selected_season_provider.dart';
import 'package:pick/segment/segment.dart';
import 'package:pick/segment/segments_firestore_service.dart';

final segmentsStateProvider =
    StateNotifierProvider<SegmentsState, AsyncValue<List<Segment>>>((ref) {
  final SegmentsState segmentsState = SegmentsState();
  segmentsState.init();
  return segmentsState;
});

final segmentsProvider = Provider((ref) => ref.watch(segmentsStateProvider));

final segmentsBySelectedSeasonStateProvider = StateNotifierProvider<
    SegmentsBySelectedSeasonState, AsyncValue<List<Segment>>>((ref) {
  final SegmentsBySelectedSeasonState segmentsBySelectedSeasonState =
      SegmentsBySelectedSeasonState(ref);
  segmentsBySelectedSeasonState.init();
  return segmentsBySelectedSeasonState;
});

final segmentsBySelectedSeasonProvider =
    Provider((ref) => ref.watch(segmentsBySelectedSeasonStateProvider));

class SegmentsState extends StateNotifier<AsyncValue<List<Segment>>> {
  SegmentsState() : super(const AsyncLoading<List<Segment>>());

  void init() async {
    state = const AsyncLoading<List<Segment>>();
    final List<Segment> segments =
        await SegmentsFirestoreService().fetchSegments();
    state = AsyncData<List<Segment>>(segments);
  }
}

class SegmentsBySelectedSeasonState
    extends StateNotifier<AsyncValue<List<Segment>>> {
  SegmentsBySelectedSeasonState(this.ref)
      : super(const AsyncLoading<List<Segment>>());

  final Ref ref;

  void init() async {
    state = const AsyncLoading<List<Segment>>();
    final Season selectedSeason = ref.watch(selectedSeasonProvider)!;
    final List<Segment> segments = await SegmentsFirestoreService()
        .fetchSegmentsBySeason(season: selectedSeason);
    state = AsyncData<List<Segment>>(segments);
  }
}
