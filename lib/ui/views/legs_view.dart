import 'package:flutter/material.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/models/season_model.dart';
import 'package:pick/core/providers/leg_view_model.dart';
import 'package:pick/ui/widgets/legs/leg_cards_listview.dart';
import 'package:provider/provider.dart';

class LegsView extends StatefulWidget {
  const LegsView({
    Key? key,
    required this.season,
  }) : super(key: key);

  final Season season;

  @override
  _LegsViewState createState() => _LegsViewState();
}

class _LegsViewState extends State<LegsView> {
  List<Leg> legs = [];

  @override
  Widget build(BuildContext context) {
    final legProvider = Provider.of<LegViewModel>(context);

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     Navigator.pushNamed(context, '/addLeg');
      //   },
      // ),
      appBar: AppBar(
        title: Center(
          child: Text(widget.season.name),
        ),
      ),
      body: FutureBuilder<List<Leg>>(
        future: legProvider.fetchLegs(season: widget.season),
        builder: (context, AsyncSnapshot<List<Leg>> snapshot) {
          if (snapshot.hasData) {
            legs = snapshot.data?.toList() ?? [];

            return LegCardsListview(legs: legs);
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
