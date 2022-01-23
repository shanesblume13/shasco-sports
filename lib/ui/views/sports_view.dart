import 'package:flutter/material.dart';
import 'package:pick/core/models/sport_model.dart';
import 'package:pick/core/viewmodels/sport_view_model.dart';
import 'package:pick/ui/widgets/sports/sport_cards_listview.dart';
import 'package:provider/provider.dart';

class SportsView extends StatelessWidget {
  const SportsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sportProvider = Provider.of<SportViewModel>(context);
    final List<Sport> sports = sportProvider.fetchSports();

    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Sports'),
          ),
        ),
        body: SportCardsListview(sports: sports));
  }
}
