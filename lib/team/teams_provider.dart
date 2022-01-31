import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/league/league.dart';
import 'package:pick/league/selected_league_provider.dart';
import 'package:pick/team/team_model.dart';
import 'package:pick/team/teams_firestore_service.dart';

final teamsStateProvider =
    StateNotifierProvider<TeamsState, AsyncValue<List<Team>>>((ref) {
  final TeamsState teamsState = TeamsState();
  teamsState.init();
  return teamsState;
});

final teamsBySelectedLeagueStateProvider =
    StateNotifierProvider<TeamsBySelectedLeagueState, AsyncValue<List<Team>>>(
        (ref) {
  final TeamsBySelectedLeagueState teamsBySelectedLeagueState =
      TeamsBySelectedLeagueState(ref);
  teamsBySelectedLeagueState.init();
  return teamsBySelectedLeagueState;
});

class TeamsState extends StateNotifier<AsyncValue<List<Team>>> {
  TeamsState() : super(const AsyncLoading<List<Team>>());

  void init() async {
    state = const AsyncLoading<List<Team>>();
    final List<Team> teams = await TeamsFirestoreService().fetchTeams();
    state = AsyncData<List<Team>>(teams);
  }
}

class TeamsBySelectedLeagueState extends StateNotifier<AsyncValue<List<Team>>> {
  TeamsBySelectedLeagueState(this.ref)
      : super(const AsyncLoading<List<Team>>());

  final Ref ref;

  void init() async {
    state = const AsyncLoading<List<Team>>();
    final League selectedLeague = ref.watch(selectedLeagueStateProvider)!;
    final List<Team> teams = await TeamsFirestoreService()
        .fetchTeamsByLeague(league: selectedLeague);
    state = AsyncData<List<Team>>(teams);
  }
}
