import 'package:flutter/material.dart';
import 'package:pick/ui/widgets/sports/sport_cards_listview.dart';

class SportsView extends StatelessWidget {
  const SportsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Sports'),
        ),
      ),
      body: SportCardsListview(),
    );
  }
}
