import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/flat_outlined_option.dart';
import 'package:pick/matchup/matchup-card/matchup_card_team_name_container_old.dart';
import 'package:pick/matchup/matchup-card/matchup_pick_score_divider_old.dart';
import 'package:pick/matchup/matchup-card/team_image_container_old.dart';
import 'package:pick/matchup/matchup.dart';
import 'package:pick/pick/pick_model.dart';
import 'package:pick/team/team_model.dart';
import 'package:pick/images_provider.dart';
import 'package:pick/pick/picks_provider_old.dart';
import 'package:pick/palette.dart';

class MatchupCard extends HookConsumerWidget {
  const MatchupCard({
    Key? key,
    required this.matchup,
    this.pick,
  }) : super(key: key);

  final Matchup matchup;
  final Pick? pick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Team> teams = [];
    const Pick? pick = null;
    //picks.firstWhereOrNull((pick) => pick.matchupReference == matchup.reference);
    AsyncValue<List<String>> imagePaths = ref.watch(imagePathsProvider);
    final Team awayTeam =
        teams.firstWhere((team) => team.reference == matchup.awayTeamReference);
    final Team homeTeam =
        teams.firstWhere((team) => team.reference == matchup.homeTeamReference);

    return imagePaths.when(
      data: (imagePaths) {
        String awayImagePath = setTeamImagePath(
            imagePaths: imagePaths, teamNickname: awayTeam.nickname);
        String homeImagePath = setTeamImagePath(
            imagePaths: imagePaths, teamNickname: homeTeam.nickname);

        return FlatBorderOption(
          borderColor: isAwayTeamPicked || isHomeTeamPicked
              ? Palette.shascoBlue
              : Palette.shascoGrey,
          child: LayoutGrid(
            areas: '''
                      awayLogo awayName scoreDivider homeName homeLogo
                    ''',
            rowSizes: const [auto],
            columnSizes: [1.fr, 2.fr, auto, 2.fr, 1.fr],
            children: [
              gridArea('awayLogo').containing(
                InkWell(
                  onTap: () => updatePickedTeam(ref: ref, team: awayTeam),
                  onLongPress: () =>
                      isAwayTeamPicked ? clearPick(ref: ref) : null,
                  splashColor: Colors.transparent,
                  child: TeamImageContainer(
                    hasPick: isAwayTeamPicked || isHomeTeamPicked,
                    isPicked: isAwayTeamPicked,
                    team: awayTeam,
                    isHome: false,
                    imagePath: awayImagePath,
                  ),
                ),
              ),
              gridArea('awayName').containing(
                InkWell(
                  onTap: () => updatePickedTeam(ref: ref, team: awayTeam),
                  onLongPress: () =>
                      isAwayTeamPicked ? clearPick(ref: ref) : null,
                  splashColor: Colors.transparent,
                  child: MatchupCardTeamNameContainer(
                    hasPick: isAwayTeamPicked || isHomeTeamPicked,
                    isPicked: isAwayTeamPicked,
                    team: awayTeam,
                    isHome: false,
                  ),
                ),
              ),
              gridArea('scoreDivider').containing(
                MatchupPickScoreDivider(
                  homePicked: isHomeTeamPicked,
                  awayPicked:
                      isAwayTeamPicked, //_points, //_pickScores[pickScoreIndex]
                ),
              ),
              gridArea('homeName').containing(
                InkWell(
                  onTap: () => updatePickedTeam(ref: ref, team: homeTeam),
                  onLongPress: () =>
                      isHomeTeamPicked ? clearPick(ref: ref) : null,
                  splashColor: Colors.transparent,
                  child: MatchupCardTeamNameContainer(
                    hasPick: isAwayTeamPicked || isHomeTeamPicked,
                    isPicked: isHomeTeamPicked,
                    team: homeTeam,
                    isHome: true,
                  ),
                ),
              ),
              gridArea('homeLogo').containing(
                InkWell(
                  onTap: () => updatePickedTeam(ref: ref, team: homeTeam),
                  onLongPress: () =>
                      isHomeTeamPicked ? clearPick(ref: ref) : null,
                  splashColor: Colors.transparent,
                  child: TeamImageContainer(
                    hasPick: isAwayTeamPicked || isHomeTeamPicked,
                    isPicked: isHomeTeamPicked,
                    team: homeTeam,
                    isHome: true,
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

  bool get isAwayTeamPicked =>
      false; //pick?.teamReference == awayTeam.reference;

  bool get isHomeTeamPicked =>
      false; //pick?.teamReference == homeTeam.reference;

  String setTeamImagePath(
      {required List<String> imagePaths, required String teamNickname}) {
    String imagePath = 'assets/images/logos/nfl/nfl.jpeg';

    if (imagePaths.contains(
        'assets/images/logos/nfl/${teamNickname.toLowerCase()}.gif')) {
      imagePath = 'assets/images/logos/nfl/${teamNickname.toLowerCase()}.gif';
    }
    return imagePath;
  }

  clearPick({required WidgetRef ref}) {
    ref
        .watch(selectedSegmentPicksStateProvider.notifier)
        .clearPick(matchup: matchup);
  }

  updatePickedTeam({required WidgetRef ref, required Team team}) {
    ref
        .watch(selectedSegmentPicksStateProvider.notifier)
        .updatePickedTeam(matchup: matchup, team: team);
  }
}
