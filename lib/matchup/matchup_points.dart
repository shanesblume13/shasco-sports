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
    required this.borderColor,
    required this.color,
  }) : super(key: key);

  final Matchup matchup;
  final Pick? pick;
  final Color borderColor;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => updatePickPoints(
          ref: ref), // updatePickScore(ref: ref, matchup: matchup),
      splashColor: Colors.transparent,
      child: FlatBorderOption(
        color: color,
        borderColor: borderColor,
        child: Center(
          child: Text(
            pick?.points.toString() ?? '0',
            style: TextStyle(
              fontSize: 18,
              color:
                  pick == null ? Palette.shascoGrey[900] : Palette.shascoBlue,
            ),
          ),
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
          .incrementPickScore(pick: pick!);
    }
  }
}
