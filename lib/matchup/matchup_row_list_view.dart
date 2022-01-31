import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/matchup/matchup.dart';
import 'package:pick/matchup/matchup_row.dart';
import 'package:pick/pick/pick_model.dart';
import 'package:pick/segment/segment.dart';
import 'package:pick/team/team_model.dart';
import 'package:collection/collection.dart';

class MatchupRowListView extends HookConsumerWidget {
  const MatchupRowListView({
    Key? key,
    required this.segment,
    required this.matchups,
    required this.teams,
    required this.picks,
  }) : super(key: key);

  final Segment segment;
  final List<Matchup> matchups;
  final List<Team> teams;
  final List<Pick>? picks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Widget> matchupRows = [];

    for (var matchup in matchups) {
      Pick? pick = picks?.firstWhereOrNull(
          (Pick pick) => pick.matchupReference == matchup.reference);

      matchupRows.add(
        MatchupRow(
          matchup: matchup,
          teams: teams,
          pick: pick,
        ),
      );
    }

    return ListView(children: matchupRows);
  }
}
