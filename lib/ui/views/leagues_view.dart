import 'package:flutter/material.dart';
import 'package:pick/core/models/league_model.dart';
import 'package:pick/core/viewmodels/league_crud_model.dart';
import 'package:pick/ui/widgets/leagues/league_cards_listview.dart';
import 'package:provider/provider.dart';

class LeaguesView extends StatelessWidget {
  final String sport;

  const LeaguesView({
    Key? key,
    required this.sport,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leagueProvider = Provider.of<LeagueCrudModel>(context);
    final List<League> leagues = leagueProvider.fetchLeagues(sport: sport);

    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Leagues List'),
          ),
        ),
        body: LeagueCardsListview(leagues: leagues));
  }
}
