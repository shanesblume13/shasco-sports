import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/sport/sport.dart';

final selectedSportStateProvider =
    StateNotifierProvider<SelectedSportState, Sport?>((ref) {
  final SelectedSportState selectedSportState = SelectedSportState();
  return selectedSportState;
});

class SelectedSportState extends StateNotifier<Sport?> {
  SelectedSportState() : super(null);

  void selectSport(Sport sport) {
    state = sport;
  }
}
