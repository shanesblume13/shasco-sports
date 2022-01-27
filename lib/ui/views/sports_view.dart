import 'package:flutter/material.dart';
import 'package:pick/ui/shared/gradient_scaffold.dart';
import 'package:pick/ui/widgets/sports/sport_cards_listview.dart';

class SportsView extends StatelessWidget {
  const SportsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBarText: 'Sports',
      body: SportCardsListview(),
    );
  }
}
