import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/sport/sport.dart';

final sportsStateProvider =
    StateNotifierProvider<SportsState, AsyncValue<List<Sport>>>((ref) {
  final SportsState sportsState = SportsState();
  sportsState.init();

  return sportsState;
});

class SportsState extends StateNotifier<AsyncValue<List<Sport>>> {
  SportsState() : super(const AsyncLoading<List<Sport>>());

  void init() async {
    state = const AsyncLoading<List<Sport>>();
    //TODO: Remove delayed when leagues are on firestore.
    final sports = await Future.delayed(const Duration(milliseconds: 100))
        .then((_) => Sport.sports);
    state = AsyncData<List<Sport>>(sports);
  }
}
