import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/core/services/firestore_matchup_service.dart';

final allMatchupsStateProvider =
    StateNotifierProvider<AllMatchupsState, AsyncValue<List<Matchup>>>((ref) {
  final AllMatchupsState allMatchupsState = AllMatchupsState();
  allMatchupsState.init();
  return allMatchupsState;
});

final matchupsByLegStateProvider = StateNotifierProvider.family<
    MatchupsByLegState, AsyncValue<List<Matchup>>, Leg>((ref, leg) {
  final MatchupsByLegState matchupsByLegState = MatchupsByLegState(ref, leg);
  matchupsByLegState.init();
  return matchupsByLegState;
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
  MatchupsByLegState(this.ref, this.leg)
      : super(const AsyncLoading<List<Matchup>>());

  final Ref ref;
  final Leg leg;

  void init() async {
    state = const AsyncLoading<List<Matchup>>();
    final allMatchups = ref.watch(allMatchupsStateProvider).value;
    List<Matchup> matchups = [];

    matchups = allMatchups
            ?.where((matchup) => matchup.legReference == leg.reference)
            .toList() ??
        [];

    state = AsyncData<List<Matchup>>(matchups);
  }
}
