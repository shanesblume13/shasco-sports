import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/flat_outlined_option.dart';
import 'package:pick/gradient_scaffold.dart';
import 'package:pick/matchup-card/matchup_card.dart';
import 'package:pick/matchup/matchup.dart';
import 'package:pick/matchup/matchups_provider.dart';
import 'package:pick/matchup/matchups_summary_container.dart';
import 'package:pick/palette.dart';
import 'package:pick/pick/pick_model.dart';
import 'package:pick/pick/picks_provider_old.dart';
import 'package:pick/segment/segment.dart';
import 'package:pick/segment/selected_segment_provider.dart';
import 'package:pick/team/team_model.dart';

class MatchupsView extends HookConsumerWidget {
  const MatchupsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Segment segment = ref.watch(selectedSegmentProvider)!;

    return GradientScaffold(
      appBarText: segment.name,
      body: ref.watch(matchupsBySelectedSegmentStateProvider).when(
            data: (matchups) => Column(
              children: [
                Expanded(
                  flex: 1,
                  child: MatchupsSummaryContainer(matchups: matchups),
                ),
                Expanded(
                  flex: 5,
                  child: getMatchupCardListView(
                    context: context,
                    ref: ref,
                    segment: segment,
                    matchups: matchups,
                  ),
                ),
              ],
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) =>
                const Center(child: Text('Error getting matchups!')),
          ),
    );
  }

  Widget getMatchupCardListView({
    required BuildContext context,
    required WidgetRef ref,
    required Segment segment,
    required List<Matchup> matchups,
  }) {
    final List<Widget> matchupCards = [];

    for (var matchup in matchups) {
      final Team awayTeam = teams
          .firstWhere((team) => team.reference == matchup.awayTeamReference);
      final Team homeTeam = teams
          .firstWhere((team) => team.reference == matchup.homeTeamReference);
      final Pick? pick = picks.firstWhereOrNull(
          (pick) => pick.matchupReference == matchup.reference);

      matchupCards.add(
        LayoutGrid(
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
                onTap: () => updatePickScore(ref: ref, matchup: matchup),
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
        ),
      );
    }

    return ListView(children: matchupCards);
  }

  updatePickScore({required WidgetRef ref, required Matchup matchup}) {
    ref
        .watch(selectedSegmentPicksStateProvider.notifier)
        .updatePickScore(matchup: matchup);
  }
}
