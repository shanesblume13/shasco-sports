import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/season/season.dart';

final selectedSeasonStateProvider =
    StateNotifierProvider<SelectedSeasonState, Season?>((ref) {
  final SelectedSeasonState selectedLeagueState = SelectedSeasonState();
  return selectedLeagueState;
});

final selectedSeasonProvider =
    Provider<Season?>((ref) => ref.watch(selectedSeasonStateProvider));

class SelectedSeasonState extends StateNotifier<Season?> {
  SelectedSeasonState() : super(null);

  void selectSeason(Season season) {
    state = season;
  }
}
