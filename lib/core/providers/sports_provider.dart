import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/sport_model.dart';

final sportsProvider = StateNotifierProvider<Sports, List<Sport>>((ref) {
  return Sports(ref);
});

final selectedSportProvider =
    StateNotifierProvider<SelectedSport, Sport?>((ref) {
  return SelectedSport(ref);
});

class Sports extends StateNotifier<List<Sport>> {
  Sports(this.ref) : super([]) {
    load();
  }

  final Ref ref;

  void load() {
    state = Sport.sports;
  }
}

class SelectedSport extends StateNotifier<Sport?> {
  SelectedSport(this.ref) : super(null) {
    select(null);
  }

  final Ref ref;

  void select(Sport? sport) {
    state = sport;
  }
}
