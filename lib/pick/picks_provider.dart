import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/matchup/matchup.dart';
import 'package:pick/pick/pick.dart';
import 'package:pick/pick/picks_firestore_service.dart';
import 'package:pick/segment/segment.dart';
import 'package:pick/segment/selected_segment_provider.dart';
import 'package:pick/team/team.dart';
import 'package:collection/collection.dart';

String? uid = FirebaseAuth.instance.currentUser?.uid;

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
    final List<Pick> picks = await PicksFirestoreService(uid: uid).fetchPicks();
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
    final List<Pick> picks = await PicksFirestoreService(uid: uid)
        .fetchPicksBySegment(segment: selectedSegment);
    state = AsyncData<List<Pick>>(picks);
  }

  void incrementPickScore({required Pick pick}) {
    if (state.value != null) {
      List<Pick> newPickState = [
        for (final Pick statePick in state.value!)
          if (statePick == pick)
            statePick.copyWith(
              points: statePick.points + 1 <= 10 ? statePick.points + 1 : 0,
            )
          else
            statePick,
      ];

      state = AsyncData<List<Pick>>(newPickState);
    }
  }

  void addNewPick({
    required Matchup matchup,
    required Team team,
  }) {
    Segment? segment = ref.watch(selectedSegmentStateProvider);

    if (uid != null && state.value != null && segment != null) {
      List<Pick> newPickState = state.value!;
      newPickState.add(
        Pick(
          uid: uid!,
          segmentReference: segment.reference!,
          matchupReference: matchup.reference!,
          teamReference: team.reference,
          points: 0,
        ),
      );

      state = AsyncData<List<Pick>>(newPickState);
    }
  }

  void deletePick({
    required Pick pick,
  }) {
    if (state.value != null) {
      List<Pick> newPickState = state.value!;
      newPickState.removeWhere(
          (statePick) => statePick.matchupReference == pick.matchupReference);

      state = AsyncData<List<Pick>>(newPickState);
    }
  }

  void updatePickTeam({required Pick pick, required Team team}) {
    if (state.value != null) {
      List<Pick> newPickState = [
        for (final Pick statePick in state.value!)
          if (statePick == pick)
            statePick.copyWith(
              teamReference: team.reference,
            )
          else
            statePick,
      ];

      state = AsyncData<List<Pick>>(newPickState);
    }
  }

  void saveSegmentPicks() async {
    final Segment? segment = ref.watch(selectedSegmentStateProvider);
    List<Pick> dbPicks = [];

    if (uid != null && state.value != null && segment != null) {
      dbPicks = await PicksFirestoreService(uid: uid).fetchPicksBySegment(
        segment: segment,
      );

      // delete picks no longer in segment
      for (Pick dbPick in dbPicks) {
        if (state.value!.firstWhereOrNull((statePick) =>
                statePick.matchupReference == dbPick.matchupReference) ==
            null) {
          await PicksFirestoreService(uid: uid).deletePick(pick: dbPick);
        }
      }

      // update picks that are in segment
      for (Pick statePick in state.value!) {
        if (dbPicks.firstWhereOrNull((dbPick) =>
                dbPick.matchupReference == statePick.matchupReference) !=
            null) {
          await PicksFirestoreService(uid: uid).updatePick(pick: statePick);
        }
      }

      // add new picks to segment
      for (Pick statePick in state.value!) {
        if (dbPicks.firstWhereOrNull((dbPick) =>
                dbPick.matchupReference == statePick.matchupReference) ==
            null) {
          await PicksFirestoreService(uid: uid).addPick(pick: statePick);
        }
      }
    }

    ref.read(picksBySelectedSegmentStateProvider.notifier).init();
  }

  void resetSegmentPicks() {
    ref.read(picksBySelectedSegmentStateProvider.notifier).init();
  }
}
