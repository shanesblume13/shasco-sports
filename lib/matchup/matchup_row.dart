import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/matchup-card/matchup_card.dart';
import 'package:pick/matchup/matchup.dart';
import 'package:pick/matchup/matchup_points.dart';
import 'package:pick/pick/pick_model.dart';

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
            pick: pick,
          ),
        ),
        gridArea('score').containing(
          MatchupPoints(matchup: matchup),
        ),
      ],
    );
  }
}
