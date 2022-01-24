import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/sport_model.dart';
import 'package:pick/core/providers/sports_provider.dart';
import 'package:pick/ui/widgets/sports/sport_card.dart';

class SportCardsListview extends HookConsumerWidget {
  SportCardsListview({
    Key? key,
  }) : super(key: key);

  final List<Widget> sportCards = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    for (var sport in ref.watch(sportsProvider)) {
      sportCards.add(
        SportCard(sport: sport),
      );
    }
    return ListView(children: sportCards);
  }
}
