import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/gradient_scaffold.dart';
import 'package:pick/icon-card/icon_card_list.dart';
import 'package:pick/season/season.dart';
import 'package:pick/season/selected_season_provider.dart';
import 'package:pick/segment/segment.dart';
import 'package:pick/segment/segments_provider.dart';
import 'package:pick/segment/selected_segment_provider.dart';
import 'package:pick/matchup/matchups_view.dart';

class SegmentsView extends HookConsumerWidget {
  const SegmentsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Season season = ref.watch(selectedSeasonProvider)!;

    return GradientScaffold(
      appBarText: season.name,
      body: ref.watch(segmentsBySelectedSeasonStateProvider).when(
            data: (segments) => getSegmentsOptionsListView(
              context: context,
              ref: ref,
              season: season,
              segments: segments,
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) =>
                const Center(child: Text('Error getting segments!')),
          ),
    );
  }

  Widget getSegmentsOptionsListView({
    required BuildContext context,
    required WidgetRef ref,
    required Season season,
    required List<Segment> segments,
  }) {
    final List<Widget> iconOptionContainers = [];

    for (var segment in segments) {
      iconOptionContainers.add(
        IconCard(
          iconData: Icons.calendar_view_week,
          text: segment.name,
          // TODO Add child count and label
          onTap: () {
            ref
                .watch(selectedSegmentStateProvider.notifier)
                .selectSegment(segment);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const MatchupsView(),
              ),
            );
          },
        ),
      );
    }

    return ListView(children: iconOptionContainers);
  }
}
