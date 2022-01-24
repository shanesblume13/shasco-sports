import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/season_model.dart';
import 'package:pick/core/services/firestore_season_service.dart';

final allSeasonsState = StateNotifierProvider.autoDispose<AllSeasonsState,
    AsyncValue<List<Season>>>((ref) {
  final allSeasonsState = AllSeasonsState();
  allSeasonsState.init();
  return allSeasonsState;
});

class AllSeasonsState extends StateNotifier<AsyncValue<List<Season>>> {
  AllSeasonsState() : super(const AsyncLoading<List<Season>>());

  void init() async {
    state = const AsyncLoading<List<Season>>();
    final seasons = await FirestoreSeasonService().fetchSeasons('');
    state = AsyncData<List<Season>>(seasons);
  }
}
