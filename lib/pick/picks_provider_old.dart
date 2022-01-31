import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/matchup/matchup.dart';
import 'package:pick/pick/pick_model.dart';
import 'package:pick/pick/picks_firestore_service.dart';
import 'package:pick/team/team_model.dart';
import 'package:pick/auth/auth_provider.dart';
import 'package:collection/collection.dart';
import 'package:pick/segment/segment.dart';
import 'package:pick/segment/selected_segment_provider.dart';

final userPicksStateProvider =
    StateNotifierProvider<UserPicksState, AsyncValue<List<Pick>>>((ref) {
  final UserPicksState userPicksState = UserPicksState(ref);
  userPicksState.init();
  return userPicksState;
});

final userPicksProvider = Provider((ref) => ref.watch(userPicksStateProvider));

final userPicksBySegmentStateProvider =
    StateNotifierProvider<UserPicksBySegmentState, AsyncValue<List<Pick>>>(
        (ref) {
  final UserPicksBySegmentState picksBySegmentState =
      UserPicksBySegmentState(ref);
  picksBySegmentState.init();
  return picksBySegmentState;
});

final userPicksBySegmentProvider =
    Provider((ref) => ref.watch(userPicksBySegmentStateProvider));

final selectedSegmentPicksStateProvider =
    StateNotifierProvider<SelectedSegmentPicksState, AsyncValue<List<Pick>>>(
        (ref) {
  final SelectedSegmentPicksState selectedSegmentPicksState =
      SelectedSegmentPicksState(ref);
  selectedSegmentPicksState.init();
  return selectedSegmentPicksState;
});

final pickByMatchupStateProvider = StateNotifierProvider.family<
    PickByMatchupState, AsyncValue<Pick?>, Matchup>((ref, matchup) {
  final PickByMatchupState pickByMatchupState =
      PickByMatchupState(ref, matchup);
  pickByMatchupState.init();
  return pickByMatchupState;
});

class UserPicksState extends StateNotifier<AsyncValue<List<Pick>>> {
  UserPicksState(this.ref) : super(const AsyncLoading<List<Pick>>());

  final Ref ref;

  void init() async {
    state = const AsyncLoading<List<Pick>>();
    final String? uid = ref.watch(authUidProvider);
    final Segment? segment = ref.watch(selectedSegmentStateProvider);

    if (uid == null || segment == null) {
      state = const AsyncData<List<Pick>>([]);
      return;
    }

    final picks =
        await PicksFirestoreService().fetchPicksBySegment(segment: segment);
    state = AsyncData<List<Pick>>(picks);
  }
}

class UserPicksBySegmentState extends StateNotifier<AsyncValue<List<Pick>>> {
  UserPicksBySegmentState(this.ref) : super(const AsyncLoading<List<Pick>>());

  final Ref ref;

  void init() async {
    state = const AsyncLoading<List<Pick>>();
    final List<Pick>? userPicks = ref.watch(userPicksStateProvider).value;
    final Segment? segment = ref.watch(selectedSegmentStateProvider);
    List<Pick> picks = [];

    if (segment == null) {
      state = const AsyncData<List<Pick>>([]);
      return;
    }

    picks = userPicks
            ?.where((pick) => pick.segmentReference == segment.reference)
            .toList() ??
        [];
    state = AsyncData<List<Pick>>(picks);
  }
}

class PickByMatchupState extends StateNotifier<AsyncValue<Pick?>> {
  PickByMatchupState(this.ref, this.matchup)
      : super(const AsyncLoading<Pick>());

  final Ref ref;
  final Matchup matchup;

  void init() async {
    state = const AsyncLoading<Pick>();
    final allPicks = ref.watch(userPicksStateProvider).value;
    Pick? pick;

    pick = allPicks?.firstWhereOrNull(
        (pick) => pick.matchupReference == matchup.reference);

    state = AsyncData<Pick?>(pick);
  }
}

class SelectedSegmentPicksState extends StateNotifier<AsyncValue<List<Pick>>> {
  SelectedSegmentPicksState(this.ref) : super(const AsyncLoading<List<Pick>>());

  final Ref ref;

  void init() async {
    state = const AsyncLoading<List<Pick>>();
    final selectedSegmentPicks =
        ref.watch(userPicksBySegmentStateProvider).value;

    if (selectedSegmentPicks != null) {
      state = AsyncData<List<Pick>>(selectedSegmentPicks);
    }
  }

  void clearPick({required Matchup matchup}) {
    state = const AsyncLoading<List<Pick>>();
    final selectedSegmentPicks =
        ref.read(userPicksBySegmentStateProvider).value ?? [];

    Pick? pick = selectedSegmentPicks
        .firstWhereOrNull((pick) => pick.matchupReference == matchup.reference);

    selectedSegmentPicks.remove(pick);

    state = AsyncData<List<Pick>>(selectedSegmentPicks);
  }

  void updatePickedTeam({required Matchup matchup, required Team team}) {
    state = const AsyncLoading<List<Pick>>();
    final selectedSegmentPicks =
        ref.read(userPicksBySegmentStateProvider).value ?? [];

    Pick? pick = selectedSegmentPicks
        .firstWhereOrNull((pick) => pick.matchupReference == matchup.reference);

    if (pick != null) {
      if (pick.teamReference != team.reference) {
        selectedSegmentPicks.remove(pick);
        pick = Pick(
          reference: pick.reference,
          uid: pick.uid,
          matchupReference: pick.matchupReference,
          teamReference: team.reference,
          segmentReference: pick.segmentReference,
          points: pick.points,
        );
        selectedSegmentPicks.add(pick);
      }
    } else {
      pick = Pick(
        reference: null,
        uid: '',
        matchupReference: matchup.reference,
        teamReference: team.reference,
        segmentReference: matchup.segmentReference,
        points: 0,
      );
      selectedSegmentPicks.add(pick);
    }

    state = AsyncData<List<Pick>>(selectedSegmentPicks);
  }

  void updatePickScore({required Matchup matchup}) {
    state = const AsyncLoading<List<Pick>>();
    final selectedSegmentPicks =
        ref.read(userPicksBySegmentStateProvider).value ?? [];

    Pick? pick = selectedSegmentPicks
        .firstWhereOrNull((pick) => pick.matchupReference == matchup.reference);

    int points = pick?.points ?? 0;
    points = points < 10 ? points + 1 : 0;

    if (pick != null) {
      selectedSegmentPicks.remove(pick);
      pick = Pick(
        reference: pick.reference,
        uid: pick.uid,
        matchupReference: pick.matchupReference,
        teamReference: pick.teamReference,
        segmentReference: pick.segmentReference,
        points: points,
      );
      selectedSegmentPicks.add(pick);
    }

    state = AsyncData<List<Pick>>(selectedSegmentPicks);
  }

  void savePicks({required List<Matchup> matchups}) async {
    state = const AsyncLoading<List<Pick>>();
    final selectedSegmentPicks =
        ref.read(userPicksBySegmentStateProvider).value ?? [];
    final allPicks = ref.watch(userPicksStateProvider).value ?? [];

    List<Pick> picksToDelete = [];
    List<Pick> picksToCreate = [];
    List<Pick> picksToUpdate = [];

    for (Matchup matchup in matchups) {
      // If allpicks has a pick for this matchup and selectedSegmentPicks doesn't, delete it
      if (allPicks.firstWhereOrNull(
                  (pick) => pick.matchupReference == matchup.reference) !=
              null &&
          selectedSegmentPicks.firstWhereOrNull(
                  (pick) => pick.matchupReference == matchup.reference) ==
              null) {
        picksToDelete.addAll(allPicks
            .where((pick) => pick.matchupReference == matchup.reference));
      }
      // If allpicks doesn't have a pick for this matchup and selectedSegmentPicks does, add it
      if (allPicks.firstWhereOrNull(
                  (pick) => pick.matchupReference == matchup.reference) ==
              null &&
          selectedSegmentPicks.firstWhereOrNull(
                  (pick) => pick.matchupReference == matchup.reference) !=
              null) {
        picksToCreate.add(selectedSegmentPicks
            .firstWhere((pick) => pick.matchupReference == matchup.reference));
      }
      // If allpicks has a pick for this matchup and selectedSegmentPicks also does, update it
      if (allPicks.firstWhereOrNull(
                  (pick) => pick.matchupReference == matchup.reference) !=
              null &&
          selectedSegmentPicks.firstWhereOrNull(
                  (pick) => pick.matchupReference == matchup.reference) !=
              null) {
        picksToUpdate.add(selectedSegmentPicks
            .firstWhere((pick) => pick.matchupReference == matchup.reference));
      }
    }

    // for (Pick pick in picksToDelete) {
    //   await PicksFirestoreService().removePick(pick);
    // }

    // for (Pick pick in picksToCreate) {
    //   await PicksFirestoreService().createPick(pick);
    // }

    // for (Pick pick in picksToUpdate) {
    //   await PicksFirestoreService().updatePick(pick);
    // }

    state = AsyncData<List<Pick>>(selectedSegmentPicks);
    ref.watch(userPicksStateProvider.notifier).init();
  }
}
