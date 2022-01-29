import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/sport_model.dart';
import 'package:pick/sport/selected_sport_provider.dart';
import 'package:pick/sport/sports_provider.dart';
import 'package:pick/league/leagues_view.dart';
import 'package:pick/ui/shared/gradient_scaffold.dart';
import 'package:pick/icon-list-option/icon_list_option.dart';

class SportsView extends HookConsumerWidget {
  const SportsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GradientScaffold(
      appBarText: 'Sports',
      body: ref.watch(sportsStateProvider).when(
            data: (sports) => getSportOptionsListView(
                context: context, ref: ref, sports: sports),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => const Center(child: Text('Error getting sports!')),
          ),
    );
  }

  Widget getSportOptionsListView(
      {required BuildContext context,
      required WidgetRef ref,
      required List<Sport> sports}) {
    final List<Widget> iconOptionContainers = [];

    for (var sport in sports) {
      iconOptionContainers.add(
        IconListOption(
          iconData: sport.iconData,
          text: sport.name,
          onTap: () {
            ref.watch(selectedSportStateProvider.notifier).selectSport(sport);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const LeaguesView(),
              ),
            );
          },
        ),
      );
    }

    return ListView(children: iconOptionContainers);
  }
}
