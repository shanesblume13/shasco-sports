import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/pick/pick_model.dart';
import 'package:pick/pick/picks_firestore_service.dart';
import 'package:pick/segment/segment.dart';
import 'package:pick/segment/selected_segment_provider.dart';

final picksStateProvider =
    StateNotifierProvider<PicksState, AsyncValue<List<Pick>>>((ref) {
  final PicksState picksState = PicksState();
  picksState.init();

  return picksState;
});

final picksBySelectedSegmentStateProvider =
    StateNotifierProvider<PicksBySelectedSegmentState, AsyncValue<List<Pick>>>(
        (ref) {
  final PicksBySelectedSegmentState picksBySelectedSegmentState =
      PicksBySelectedSegmentState(ref);
  picksBySelectedSegmentState.init();

  return picksBySelectedSegmentState;
});

class PicksState extends StateNotifier<AsyncValue<List<Pick>>> {
  PicksState() : super(const AsyncLoading<List<Pick>>());

  void init() async {
    state = const AsyncLoading<List<Pick>>();
    final List<Pick> picks = await PicksFirestoreService().fetchPicks();
    state = AsyncData<List<Pick>>(picks);
  }
}

class PicksBySelectedSegmentState
    extends StateNotifier<AsyncValue<List<Pick>>> {
  PicksBySelectedSegmentState(this.ref)
      : super(const AsyncLoading<List<Pick>>());

  final Ref ref;

  void init() async {
    state = const AsyncLoading<List<Pick>>();
    final Segment selectedSegment = ref.watch(selectedSegmentStateProvider)!;
    final List<Pick> picks = await PicksFirestoreService()
        .fetchPicksBySegment(segment: selectedSegment);
    state = AsyncData<List<Pick>>(picks);
  }
}
