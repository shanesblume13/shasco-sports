import 'package:flutter/material.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/ui/widgets/legs/leg_card.dart';

class LegCardsListview extends StatelessWidget {
  LegCardsListview({
    Key? key,
    required this.legs,
  }) : super(key: key);

  final List<Leg> legs;
  final List<Widget> legCards = [];

  @override
  Widget build(BuildContext context) {
    for (var leg in legs) {
      legCards.add(
        LegCard(leg: leg),
      );
    }
    return ListView(children: legCards);
  }
}
