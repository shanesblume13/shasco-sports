import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/flat_outlined_option.dart';
import 'package:pick/matchup/matchup.dart';
import 'package:pick/palette.dart';
import 'package:pick/pick/pick.dart';
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
      onTap: () => updatePickPoints(
          ref: ref), // updatePickScore(ref: ref, matchup: matchup),
      splashColor: Colors.transparent,
      child: FlatBorderOption(
        borderColor: pick == null ? Palette.shascoGrey : Palette.shascoBlue,
        child: Center(
          child: Text(pick?.points.toString() ?? '0'),
        ),
      ),
    );
  }

  void updatePickPoints({required WidgetRef ref}) {
    if (pick == null) {
      return;
    } else {
      ref
          .watch(picksBySelectedSegmentStateProvider.notifier)
          .updatePoints(pick: pick!);
    }
  }
}
