import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/flat_outlined_option.dart';
import 'package:pick/matchup/matchup.dart';
import 'package:pick/pick/pick_model.dart';
import 'package:pick/team/team_model.dart';
import 'package:pick/pick/picks_provider_old.dart';
import 'package:pick/palette.dart';
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
        LayoutGrid(
          areas: '''
              matchupCard score
            ''',
          rowSizes: const [
            auto,
          ],
          columnSizes: [
            auto,
            70.px,
          ],
          children: [
            gridArea('matchupCard').containing(
              MatchupCard(
                matchup: matchup,
                awayTeam: awayTeam,
                homeTeam: homeTeam,
                pick: pick,
              ),
            ),
            gridArea('score').containing(
              InkWell(
                onTap: () => updatePickScore(ref: ref, matchup: matchup),
                splashColor: Colors.transparent,
                child: FlatBorderOption(
                  borderColor:
                      pick == null ? Palette.shascoGrey : Palette.shascoBlue,
                  child: Center(
                    child: Text(pick?.points.toString() ?? '0'),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return ListView(children: matchupCards);
  }

  updatePickScore({required WidgetRef ref, required Matchup matchup}) {
    ref
        .watch(selectedSegmentPicksStateProvider.notifier)
        .updatePickScore(matchup: matchup);
  }
}
