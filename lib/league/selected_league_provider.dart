import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/league/league.dart';

final selectedLeagueStateProvider =
    StateNotifierProvider<SelectedLeagueState, League?>((ref) {
  final SelectedLeagueState selectedLeagueState = SelectedLeagueState();

  return selectedLeagueState;
});

class SelectedLeagueState extends StateNotifier<League?> {
  SelectedLeagueState() : super(null);

  void selectLeague(League league) {
    state = league;
  }
}
