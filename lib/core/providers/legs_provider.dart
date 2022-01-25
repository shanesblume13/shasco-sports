import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/models/season_model.dart';
import 'package:pick/core/providers/seasons_provider.dart';
import 'package:pick/core/services/firestore_leg_service.dart';

final allLegsStateProvider =
    StateNotifierProvider<AllLegsState, AsyncValue<List<Leg>>>((ref) {
  final AllLegsState allLegsState = AllLegsState();
  allLegsState.init();
  return allLegsState;
});

final legsBySelectedSeasonStateProvider =
    StateNotifierProvider<LegsBySelectedSeasonState, AsyncValue<List<Leg>>>(
        (ref) {
  final LegsBySelectedSeasonState legsBySelectedSeasonState =
      LegsBySelectedSeasonState(ref);
  legsBySelectedSeasonState.init();
  return legsBySelectedSeasonState;
});

class AllLegsState extends StateNotifier<AsyncValue<List<Leg>>> {
  AllLegsState() : super(const AsyncLoading<List<Leg>>());

  void init() async {
    state = const AsyncLoading<List<Leg>>();
    final legs = await FirestoreLegService().fetchLegs(null);
    state = AsyncData<List<Leg>>(legs);
  }
}

class LegsBySelectedSeasonState extends StateNotifier<AsyncValue<List<Leg>>> {
  LegsBySelectedSeasonState(this.ref) : super(const AsyncLoading<List<Leg>>());

  final Ref ref;

  void init() async {
    final Season? selectedSeasonState = ref.watch(selectedSeasonStateProvider);

    state = const AsyncLoading<List<Leg>>();
    final allLegs = ref.watch(allLegsStateProvider).value;
    List<Leg> legs = [];

    if (selectedSeasonState != null) {
      legs = allLegs
              ?.where(
                  (leg) => leg.seasonReference == selectedSeasonState.reference)
              .toList() ??
          [];
    } else {
      legs = allLegs ?? [];
    }

    state = AsyncData<List<Leg>>(legs);
  }
}
