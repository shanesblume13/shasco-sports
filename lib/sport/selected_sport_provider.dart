import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/sport_model.dart';

final selectedSportStateProvider =
    StateNotifierProvider<SelectedSportState, Sport?>((ref) {
  final SelectedSportState selectedSportState = SelectedSportState();
  return selectedSportState;
});

final selectedSportProvider =
    Provider<Sport?>((ref) => ref.watch(selectedSportStateProvider));

class SelectedSportState extends StateNotifier<Sport?> {
  SelectedSportState() : super(null);

  void selectSport(Sport sport) {
    state = sport;
  }
}
