import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/flat_outlined_option.dart';
import 'package:pick/matchup-card/matchup_card.dart';
import 'package:pick/matchup/matchup.dart';
import 'package:pick/palette.dart';
import 'package:pick/pick/pick_model.dart';
import 'package:pick/team/team_model.dart';

class MatchupRow extends HookConsumerWidget {
  const MatchupRow({
    Key? key,
    required this.matchup,
    this.pick,
  }) : super(key: key);

  final Matchup matchup;
  final Pick? pick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Team awayTeam =
        teams.firstWhere((team) => team.reference == matchup.awayTeamReference);
    final Team homeTeam =
        teams.firstWhere((team) => team.reference == matchup.homeTeamReference);
    final Pick? pick = picks
        .firstWhereOrNull((pick) => pick.matchupReference == matchup.reference);

    return LayoutGrid(
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
            onTap: () => null, // updatePickScore(ref: ref, matchup: matchup),
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
    );
  }
}
