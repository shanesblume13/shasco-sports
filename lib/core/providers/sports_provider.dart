import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/sport_model.dart';

final sportsProvider = StateNotifierProvider<Sports, List<Sport>>((ref) {
  return Sports(ref);
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
