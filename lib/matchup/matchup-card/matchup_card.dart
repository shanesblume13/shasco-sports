import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/flat_outlined_option.dart';
import 'package:pick/matchup/matchup-card/matchup_card_team_text.dart';
import 'package:pick/matchup/matchup-card/matchup_card_team_divider.dart';
import 'package:pick/matchup/matchup-card/matchup_card_team_image.dart';
import 'package:pick/matchup/matchup.dart';
import 'package:pick/pick/pick.dart';
import 'package:pick/pick/picks_provider.dart';
import 'package:pick/team/team.dart';
import 'package:pick/images_provider.dart';
import 'package:pick/palette.dart';

class MatchupCard extends HookConsumerWidget {
  const MatchupCard({
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
    AsyncValue<List<String>> imagePaths = ref.watch(imagePathsStateProvider);
    final Team awayTeam =
        teams.firstWhere((team) => team.reference == matchup.awayTeamReference);
    final Team homeTeam =
        teams.firstWhere((team) => team.reference == matchup.homeTeamReference);

    return imagePaths.when(
      data: (imagePaths) {
        String awayImagePath = setTeamImagePath(
          imagePaths: imagePaths,
          teamNickname: awayTeam.nickname,
        );
        String homeImagePath = setTeamImagePath(
          imagePaths: imagePaths,
          teamNickname: homeTeam.nickname,
        );

        return FlatBorderOption(
          borderColor: pick != null ? Palette.shascoBlue : Palette.shascoGrey,
          child: LayoutGrid(
            areas: '''
                      awayLogo awayName divider homeName homeLogo
                    ''',
            rowSizes: const [auto],
            columnSizes: [1.fr, 2.fr, auto, 2.fr, 1.fr],
            children: [
              gridArea('awayLogo').containing(
                InkWell(
                  onTap: () => updatePickTeam(
                    ref: ref,
                    team: awayTeam,
                  ), //updatePickedTeam(ref: ref, team: awayTeam),
                  onLongPress: () => deletePick(ref: ref),
                  splashColor: Colors.transparent,
                  child: MatchupCardTeamImage(
                    team: awayTeam,
                    matchup: matchup,
                    pick: pick,
                    imagePath: awayImagePath,
                  ),
                ),
              ),
              gridArea('awayName').containing(
                InkWell(
                  onTap: () => updatePickTeam(
                    ref: ref,
                    team: awayTeam,
                  ),
                  onLongPress: () => deletePick(ref: ref),
                  // onLongPress: () =>
                  //     isAwayTeamPicked ? clearPick(ref: ref) : null,
                  splashColor: Colors.transparent,
                  child: MatchupCardTeamText(
                    team: awayTeam,
                    matchup: matchup,
                    pick: pick,
                  ),
                ),
              ),
              gridArea('divider').containing(
                MatchupCardTeamDivider(
                  matchup: matchup,
                  pick: pick, //_points, //_pickScores[pickScoreIndex]
                ),
              ),
              gridArea('homeName').containing(
                InkWell(
                  onTap: () => updatePickTeam(
                    ref: ref,
                    team: homeTeam,
                  ),
                  onLongPress: () => deletePick(ref: ref),
                  splashColor: Colors.transparent,
                  child: MatchupCardTeamText(
                    team: homeTeam,
                    matchup: matchup,
                    pick: pick,
                  ),
                ),
              ),
              gridArea('homeLogo').containing(
                InkWell(
                  onTap: () => updatePickTeam(
                    ref: ref,
                    team: homeTeam,
                  ),
                  onLongPress: () => deletePick(ref: ref),
                  splashColor: Colors.transparent,
                  child: MatchupCardTeamImage(
                    team: homeTeam,
                    matchup: matchup,
                    pick: pick,
                    imagePath: homeImagePath,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => const Center(child: Text('Error getting images!')),
    );
  }

  String setTeamImagePath({
    required List<String> imagePaths,
    required String teamNickname,
  }) {
    String imagePath = 'assets/images/logos/nfl/nfl.jpeg';

    if (imagePaths.contains(
      'assets/images/logos/nfl/${teamNickname.toLowerCase()}.gif',
    )) {
      imagePath = 'assets/images/logos/nfl/${teamNickname.toLowerCase()}.gif';
    }

    return imagePath;
  }

  void updatePickTeam({required WidgetRef ref, required Team team}) {
    if (pick == null) {
      ref
          .watch(picksBySelectedSegmentStateProvider.notifier)
          .addNewPick(matchup: matchup, team: team);
    } else {
      ref
          .watch(picksBySelectedSegmentStateProvider.notifier)
          .updatePickTeam(pick: pick!, team: team);
    }
  }

  void deletePick({required WidgetRef ref}) {
    if (pick != null) {
      ref
          .watch(picksBySelectedSegmentStateProvider.notifier)
          .deletePick(pick: pick!);
    }
  }
}
