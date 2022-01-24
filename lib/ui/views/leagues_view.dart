import 'package:flutter/material.dart';
import 'package:pick/ui/widgets/leagues/league_cards_listview.dart';

class LeaguesView extends StatelessWidget {
  const LeaguesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Leagues'),
          ),
        ),
        body: LeagueCardsListview());
  }
}
