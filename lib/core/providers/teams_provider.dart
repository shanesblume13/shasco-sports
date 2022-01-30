import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/league/league.dart';
import 'package:pick/team/team_model.dart';
import 'package:pick/league/selected_league_provider.dart';
import 'package:pick/team/teams_firestore_service.dart';

final allTeamsStateProvider =
    StateNotifierProvider<AllTeamsState, AsyncValue<List<Team>>>((ref) {
  final AllTeamsState allTeamsState = AllTeamsState();
  allTeamsState.init();
  return allTeamsState;
});

final teamsByLeagueStateProvider = StateNotifierProvider.family<
    TeamsByLeagueState, AsyncValue<List<Team>>, League>((ref, league) {
  final TeamsByLeagueState teamsByLeagueState = TeamsByLeagueState(ref, league);
  teamsByLeagueState.init();
  return teamsByLeagueState;
});

final selectedLeagueTeamsStateProvider =
    StateNotifierProvider<SelectedLeagueTeamsState, AsyncValue<List<Team>>>(
        (ref) {
  final SelectedLeagueTeamsState selectedLeagueTeamsState =
      SelectedLeagueTeamsState(ref);
  selectedLeagueTeamsState.init();
  return selectedLeagueTeamsState;
});

class AllTeamsState extends StateNotifier<AsyncValue<List<Team>>> {
  AllTeamsState() : super(const AsyncLoading<List<Team>>());

  void init() async {
    state = const AsyncLoading<List<Team>>();
    final teams = await TeamsFirestoreService().fetchTeams();
    state = AsyncData<List<Team>>(teams);
  }
}

class TeamsByLeagueState extends StateNotifier<AsyncValue<List<Team>>> {
  TeamsByLeagueState(this.ref, this.league)
      : super(const AsyncLoading<List<Team>>());

  final Ref ref;
  final League league;

  void init() async {
    state = const AsyncLoading<List<Team>>();
    final allTeams = ref.watch(allTeamsStateProvider).value;
    List<Team> teams = [];

    teams =
        allTeams?.where((team) => team.leagueId == league.id).toList() ?? [];

    state = AsyncData<List<Team>>(teams);
  }
}

class SelectedLeagueTeamsState extends StateNotifier<AsyncValue<List<Team>>> {
  SelectedLeagueTeamsState(this.ref) : super(const AsyncLoading<List<Team>>());

  final Ref ref;

  void init() async {
    state = const AsyncLoading<List<Team>>();
    final selectedLeague = ref.watch(selectedLeagueProvider);
    final selectedLeagueTeams =
        ref.watch(teamsByLeagueStateProvider(selectedLeague!)).value;

    if (selectedLeagueTeams != null) {
      state = AsyncData<List<Team>>(selectedLeagueTeams);
    }
  }
}
