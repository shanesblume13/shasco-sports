import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/league_model.dart';
import 'package:pick/core/models/team_model.dart';
import 'package:pick/core/providers/leagues_provider.dart';
import 'package:pick/core/services/firestore_team_serivce.dart';

final allTeamsStateProvider =
    StateNotifierProvider<AllTeamsState, AsyncValue<List<Team>>>((ref) {
  final AllTeamsState allTeamsState = AllTeamsState();
  allTeamsState.init();
  return allTeamsState;
});

final teamsBySelectedLeagueStateProvider =
    StateNotifierProvider<TeamsBySelectedLeagueState, AsyncValue<List<Team>>>(
        (ref) {
  final TeamsBySelectedLeagueState teamsBySelectedLeagueState =
      TeamsBySelectedLeagueState(ref);
  teamsBySelectedLeagueState.init();
  return teamsBySelectedLeagueState;
});

class AllTeamsState extends StateNotifier<AsyncValue<List<Team>>> {
  AllTeamsState() : super(const AsyncLoading<List<Team>>());

  void init() async {
    state = const AsyncLoading<List<Team>>();
    final teams = await FirestoreTeamService().fetchTeams(null);
    state = AsyncData<List<Team>>(teams);
  }
}

class TeamsBySelectedLeagueState extends StateNotifier<AsyncValue<List<Team>>> {
  TeamsBySelectedLeagueState(this.ref)
      : super(const AsyncLoading<List<Team>>());

  final Ref ref;

  void init() async {
    final League? selectedLeagueState = ref.watch(selectedLeagueStateProvider);

    state = const AsyncLoading<List<Team>>();
    final allTeams = ref.watch(allTeamsStateProvider).value;
    List<Team> teams = [];

    if (selectedLeagueState != null) {
      teams = allTeams
              ?.where((team) => team.leagueId == selectedLeagueState.id)
              .toList() ??
          [];
    } else {
      teams = allTeams ?? [];
    }

    state = AsyncData<List<Team>>(teams);
  }
}
