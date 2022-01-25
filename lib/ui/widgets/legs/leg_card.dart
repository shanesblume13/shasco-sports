import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/providers/legs_provider.dart';
import 'package:pick/ui/views/matchups_view.dart';
import 'package:pick/ui/widgets/legs/leg_card_image_clip.dart';
import 'package:pick/ui/widgets/legs/leg_card_matchup_count_container.dart';
import 'package:pick/ui/widgets/legs/leg_card_name_container.dart';

class LegCard extends HookConsumerWidget {
  const LegCard({
    Key? key,
    required this.leg,
  }) : super(key: key);

  final Leg leg;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.watch(selectedLegStateProvider.notifier).select(leg);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const MatchupsView(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 6,
          child: LayoutGrid(
            areas: '''
                image name matchupCount
              ''',
            rowSizes: const [
              auto,
            ],
            columnSizes: [
              1.fr,
              3.fr,
              2.fr,
            ],
            children: [
              gridArea('image').containing(
                const LegCardImageClip(),
              ),
              gridArea('name').containing(
                LegCardNameConatiner(name: leg.name),
              ),
              gridArea('matchupCount').containing(
                LegCardMatchupCountContainer(leg: leg),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
