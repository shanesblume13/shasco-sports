import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/league_model.dart';

final selectedLeagueStateProvider =
    StateNotifierProvider<SelectedLeagueState, League?>((ref) {
  final SelectedLeagueState selectedLeagueState = SelectedLeagueState();
  return selectedLeagueState;
});

final selectedLeagueProvider =
    Provider<League?>((ref) => ref.watch(selectedLeagueStateProvider));

class SelectedLeagueState extends StateNotifier<League?> {
  SelectedLeagueState() : super(null);

  void selectLeague(League league) {
    state = league;
  }
}
