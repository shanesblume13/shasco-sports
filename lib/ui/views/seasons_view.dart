import 'package:flutter/material.dart';
import 'package:pick/core/models/season_model.dart';
import 'package:pick/core/services/firestore_season_service.dart';
import 'package:pick/ui/widgets/seasons/season_cards_listview.dart';
import 'package:provider/provider.dart';

class SeasonsView extends StatefulWidget {
  final String league;

  const SeasonsView({
    Key? key,
    required this.league,
  }) : super(key: key);

  @override
  _SeasonsViewState createState() => _SeasonsViewState();
}

class _SeasonsViewState extends State<SeasonsView> {
  List<Season> seasons = [];

  @override
  Widget build(BuildContext context) {
    final seasonProvider = Provider.of<FirestoreSeasonService>(context);
    String league = widget.league;

    return Scaffold(
      // TODO: Figure out ADD/EDIT/DELETE UX and create views.
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     Navigator.pushNamed(context, '/addSeason');
      //   },
      // ),
      appBar: AppBar(
        title: Center(
          child: Text('$league Seasons'),
        ),
      ),
      body: FutureBuilder<List<Season>>(
        future: seasonProvider.fetchSeasons(league),
        builder: (context, AsyncSnapshot<List<Season>> snapshot) {
          if (snapshot.hasData) {
            seasons = snapshot.data?.toList() ?? [];
            seasons.sort((b, a) => b.startDate.compareTo(a.startDate));
            return SeasonCardsListview(seasons: seasons);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
