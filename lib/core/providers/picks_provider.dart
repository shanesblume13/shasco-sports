import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/core/models/pick_model.dart';
import 'package:pick/core/services/firestore_pick_service.dart';

final allPicksStateProvider =
    StateNotifierProvider<AllPicksState, AsyncValue<List<Pick>>>((ref) {
  final AllPicksState allPicksState = AllPicksState();
  allPicksState.init();
  return allPicksState;
});

final pickByMatchupStateProvider =
    StateNotifierProvider.family<PickByMatchupState, AsyncValue<Pick>, Matchup>(
        (ref, matchup) {
  final PickByMatchupState pickByMatchupState =
      PickByMatchupState(ref, matchup);
  pickByMatchupState.init();
  return pickByMatchupState;
});

class AllPicksState extends StateNotifier<AsyncValue<List<Pick>>> {
  AllPicksState() : super(const AsyncLoading<List<Pick>>());

  void init() async {
    state = const AsyncLoading<List<Pick>>();
    final picks = await FirestorePickService().fetchPicks(null);
    state = AsyncData<List<Pick>>(picks);
  }
}

class PickByMatchupState extends StateNotifier<AsyncValue<List<Pick>>> {
  PickByMatchupState(this.ref, this.matchup)
      : super(const AsyncLoading<List<Pick>>());

  final Ref ref;
  final Matchup matchup;

  void init() async {
    state = const AsyncLoading<List<Pick>>();
    final allPicks = ref.watch(allPicksStateProvider).value;
    List<Pick> picks = [];

    picks = allPicks
            ?.where((pick) => pick.matchupReference == matchup.reference)
            .toList() ??
        [];

    state = AsyncData<List<Pick>>(picks);
  }
}
