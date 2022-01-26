import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/core/models/pick_model.dart';
import 'package:pick/core/models/team_model.dart';
import 'package:pick/ui/widgets/matchups/matchup_card.dart';
import 'package:collection/collection.dart';

class MatchupCardsListview extends HookConsumerWidget {
  MatchupCardsListview({
    Key? key,
    required this.matchups,
    required this.teams,
    required this.picks,
  }) : super(key: key);

  final List<Matchup> matchups;
  final List<Team> teams;
  final List<Pick> picks;
  final List<Widget> matchupCards = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    for (var matchup in matchups) {
      final Team awayTeam = teams
          .firstWhere((team) => team.reference == matchup.awayTeamReference);
      final Team homeTeam = teams
          .firstWhere((team) => team.reference == matchup.homeTeamReference);
      final Pick? pick = picks.firstWhereOrNull(
          (pick) => pick.matchupReference == matchup.reference);

      matchupCards.add(
        MatchupCard(
          matchup: matchup,
          awayTeam: awayTeam,
          homeTeam: homeTeam,
          pick: pick,
        ),
      );
    }
    return ListView(children: matchupCards);
  }
}
