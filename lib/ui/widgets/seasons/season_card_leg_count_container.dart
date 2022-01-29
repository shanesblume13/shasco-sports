import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/season_model.dart';

class SeasonCardLegCountContainer extends HookConsumerWidget {
  const SeasonCardLegCountContainer({
    Key? key,
    required this.season,
  }) : super(key: key);

  final Season season;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('0'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Legs'),
          ],
        ),
      ],
    );
  }
}
