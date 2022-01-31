import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/flat_outlined_option.dart';
import 'package:pick/matchup/matchup.dart';
import 'package:pick/palette.dart';
import 'package:pick/pick/pick_model.dart';
import 'package:pick/pick/picks_provider.dart';

class MatchupPoints extends HookConsumerWidget {
  const MatchupPoints({
    Key? key,
    required this.matchup,
    this.pick,
  }) : super(key: key);

  final Matchup matchup;
  final Pick? pick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      // TODO remove print
      onTap: () =>
          updatePickPoints(ref), // updatePickScore(ref: ref, matchup: matchup),
      splashColor: Colors.transparent,
      child: FlatBorderOption(
        borderColor: pick == null ? Palette.shascoGrey : Palette.shascoBlue,
        child: Center(
          child: Text(pick?.points.toString() ?? '0'),
        ),
      ),
    );
  }

  void updatePickPoints(WidgetRef ref) {
    if (pick == null) {
      return;
    }

    return print("Updating Score");
  }
}
