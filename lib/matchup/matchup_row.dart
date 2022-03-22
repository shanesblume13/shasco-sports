import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/matchup/matchup-card/matchup_card.dart';
import 'package:pick/matchup/matchup.dart';
import 'package:pick/matchup/matchup_points.dart';
import 'package:pick/palette.dart';
import 'package:pick/pick/pick.dart';
import 'package:pick/team/team.dart';

class MatchupRow extends HookConsumerWidget {
  const MatchupRow({
    Key? key,
    required this.matchup,
    required this.teams,
    this.pick,
  }) : super(key: key);

  final Matchup matchup;
  final List<Team> teams;
  final Pick? pick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color borderColor = matchup.isLocked || matchup.isComplete
        ? Colors.transparent
        : Palette.shascoBlue;
    Color color = Colors.transparent;

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
            teams: teams,
            pick: pick,
            borderColor: borderColor,
            color: color,
          ),
        ),
        gridArea('score').containing(
          MatchupPoints(
            matchup: matchup,
            pick: pick,
            borderColor: borderColor,
            color: color,
          ),
        ),
      ],
    );
  }
}
