import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/core/models/pick_model.dart';
import 'package:pick/core/models/team_model.dart';
import 'package:pick/core/providers/auth_provider.dart';
import 'package:pick/core/providers/legs_provider.dart';
import 'package:pick/core/services/firestore_pick_service.dart';
import 'package:collection/collection.dart';

final userPicksStateProvider =
    StateNotifierProvider<UserPicksState, AsyncValue<List<Pick>>>((ref) {
  final UserPicksState userPicksState = UserPicksState(ref);
  userPicksState.init();
  return userPicksState;
});

final userPicksByLegStateProvider =
    StateNotifierProvider<UserPicksByLegState, AsyncValue<List<Pick>>>((ref) {
  final UserPicksByLegState picksByLegState = UserPicksByLegState(ref);
  picksByLegState.init();
  return picksByLegState;
});

final selectedLegPicksStateProvider =
    StateNotifierProvider<SelectedLegPicksState, AsyncValue<List<Pick>>>((ref) {
  final SelectedLegPicksState selectedLegPicksState =
      SelectedLegPicksState(ref);
  selectedLegPicksState.init();
  return selectedLegPicksState;
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
    final Leg? leg = ref.watch(selectedLegStateProvider);

    if (uid == null || leg == null) {
      state = const AsyncData<List<Pick>>([]);
      return;
    }

    final picks =
        await FirestorePickService().fetchUserLegPicks(uid: uid, leg: leg);
    state = AsyncData<List<Pick>>(picks);
  }
}

class UserPicksByLegState extends StateNotifier<AsyncValue<List<Pick>>> {
  UserPicksByLegState(this.ref) : super(const AsyncLoading<List<Pick>>());

  final Ref ref;

  void init() async {
    state = const AsyncLoading<List<Pick>>();
    final List<Pick>? userPicks = ref.watch(userPicksStateProvider).value;
    final Leg? leg = ref.watch(selectedLegStateProvider);
    List<Pick> picks = [];

    if (leg == null) {
      state = const AsyncData<List<Pick>>([]);
      return;
    }

    picks = userPicks
            ?.where((pick) => pick.legReference == leg.reference)
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

class SelectedLegPicksState extends StateNotifier<AsyncValue<List<Pick>>> {
  SelectedLegPicksState(this.ref) : super(const AsyncLoading<List<Pick>>());

  final Ref ref;

  void init() async {
    state = const AsyncLoading<List<Pick>>();
    final selectedLegPicks = ref.watch(userPicksByLegStateProvider).value;

    if (selectedLegPicks != null) {
      state = AsyncData<List<Pick>>(selectedLegPicks);
    }
  }

  void clearPick({required Matchup matchup}) {
    state = const AsyncLoading<List<Pick>>();
    final selectedLegPicks = ref.read(userPicksByLegStateProvider).value ?? [];

    Pick? pick = selectedLegPicks
        .firstWhereOrNull((pick) => pick.matchupReference == matchup.reference);

    selectedLegPicks.remove(pick);

    state = AsyncData<List<Pick>>(selectedLegPicks);
  }

  void updatePickedTeam({required Matchup matchup, required Team team}) {
    state = const AsyncLoading<List<Pick>>();
    final selectedLegPicks = ref.read(userPicksByLegStateProvider).value ?? [];

    Pick? pick = selectedLegPicks
        .firstWhereOrNull((pick) => pick.matchupReference == matchup.reference);

    if (pick != null) {
      if (pick.teamReference != team.reference) {
        selectedLegPicks.remove(pick);
        pick = Pick(
          id: pick.id,
          uid: pick.uid,
          matchupReference: pick.matchupReference,
          teamReference: team.reference,
          legReference: pick.legReference,
          points: pick.points,
          reference: pick.reference,
        );
        selectedLegPicks.add(pick);
      }
    } else {
      pick = Pick(
        id: '',
        uid: '',
        matchupReference: matchup.reference,
        teamReference: team.reference,
        legReference: matchup.legReference,
        points: 0,
        reference: null,
      );
      selectedLegPicks.add(pick);
    }

    state = AsyncData<List<Pick>>(selectedLegPicks);
  }

  void updatePickScore({required Matchup matchup}) {
    state = const AsyncLoading<List<Pick>>();
    final selectedLegPicks = ref.read(userPicksByLegStateProvider).value ?? [];

    Pick? pick = selectedLegPicks
        .firstWhereOrNull((pick) => pick.matchupReference == matchup.reference);

    int points = pick?.points ?? 0;
    points = points < 10 ? points + 1 : 0;

    if (pick != null) {
      selectedLegPicks.remove(pick);
      pick = Pick(
        id: pick.id,
        uid: pick.uid,
        matchupReference: pick.matchupReference,
        teamReference: pick.teamReference,
        legReference: pick.legReference,
        points: points,
        reference: pick.reference,
      );
      selectedLegPicks.add(pick);
    }

    state = AsyncData<List<Pick>>(selectedLegPicks);
  }

  void savePicks({required List<Matchup> matchups}) async {
    state = const AsyncLoading<List<Pick>>();
    final selectedLegPicks = ref.read(userPicksByLegStateProvider).value ?? [];
    final allPicks = ref.watch(userPicksStateProvider).value ?? [];

    List<Pick> picksToDelete = [];
    List<Pick> picksToCreate = [];
    List<Pick> picksToUpdate = [];

    for (Matchup matchup in matchups) {
      // If allpicks has a pick for this matchup and selectedLegPicks doesn't, delete it
      if (allPicks.firstWhereOrNull(
                  (pick) => pick.matchupReference == matchup.reference) !=
              null &&
          selectedLegPicks.firstWhereOrNull(
                  (pick) => pick.matchupReference == matchup.reference) ==
              null) {
        picksToDelete.addAll(allPicks
            .where((pick) => pick.matchupReference == matchup.reference));
      }
      // If allpicks doesn't have a pick for this matchup and selectedLegPicks does, add it
      if (allPicks.firstWhereOrNull(
                  (pick) => pick.matchupReference == matchup.reference) ==
              null &&
          selectedLegPicks.firstWhereOrNull(
                  (pick) => pick.matchupReference == matchup.reference) !=
              null) {
        picksToCreate.add(selectedLegPicks
            .firstWhere((pick) => pick.matchupReference == matchup.reference));
      }
      // If allpicks has a pick for this matchup and selectedLegPicks also does, update it
      if (allPicks.firstWhereOrNull(
                  (pick) => pick.matchupReference == matchup.reference) !=
              null &&
          selectedLegPicks.firstWhereOrNull(
                  (pick) => pick.matchupReference == matchup.reference) !=
              null) {
        picksToUpdate.add(selectedLegPicks
            .firstWhere((pick) => pick.matchupReference == matchup.reference));
      }
    }

    for (Pick pick in picksToDelete) {
      pick.id = ref
              .watch(userPicksStateProvider)
              .value
              ?.firstWhere((allPicksPick) =>
                  allPicksPick.matchupReference == pick.matchupReference)
              .id ??
          '';
      pick.uid = ref
              .watch(userPicksStateProvider)
              .value
              ?.firstWhere((allPicksPick) =>
                  allPicksPick.matchupReference == pick.matchupReference)
              .uid ??
          '';
      await FirestorePickService().removePick(pick);
    }

    for (Pick pick in picksToCreate) {
      await FirestorePickService().createPick(pick);
    }

    for (Pick pick in picksToUpdate) {
      pick.id = ref
              .watch(userPicksStateProvider)
              .value
              ?.firstWhere((allPicksPick) =>
                  allPicksPick.matchupReference == pick.matchupReference)
              .id ??
          '';
      pick.uid = ref
              .watch(userPicksStateProvider)
              .value
              ?.firstWhere((allPicksPick) =>
                  allPicksPick.matchupReference == pick.matchupReference)
              .uid ??
          '';
      await FirestorePickService().updatePick(pick);
    }

    state = AsyncData<List<Pick>>(selectedLegPicks);
    ref.watch(userPicksStateProvider.notifier).init();
  }
}
