import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/sport_model.dart';

final sportProvider = StateNotifierProvider<SportsStateNotifier, List<Sport>>(
    (ref) => SportsStateNotifier());

class SportsStateNotifier extends StateNotifier<List<Sport>> {
  SportsStateNotifier({
    this.id,
  }) : super([]) {
    fetchAllSports();
  }

  int? id;
  List<Sport> sports = Sport.sports;

  void fetchAllSports() {
    state = sports;
  }

  void fetchSportById() {
    state = [sports.firstWhere((sport) => sport.id == id)];
  }
}
