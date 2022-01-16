import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick/core/models/week_model.dart';
import 'package:pick/core/viewmodels/week_crud_model.dart';
import 'package:pick/ui/widgets/weeks/weeks_listview.dart';
import 'package:provider/provider.dart';

class WeeksView extends StatefulWidget {
  const WeeksView({Key? key}) : super(key: key);

  @override
  _WeeksViewState createState() => _WeeksViewState();
}

class _WeeksViewState extends State<WeeksView> {
  List<Week> weeks = [];

  @override
  Widget build(BuildContext context) {
    final weekProvider = Provider.of<WeekCrudModel>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/addWeek');
        },
      ),
      appBar: AppBar(
        title: const Center(
          child: Text('Week View'),
        ),
      ),
      body: StreamBuilder(
        stream: weekProvider.fetchWeeksAsStream(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            weeks = snapshot.data?.docs
                    .map((doc) => Week.fromQueryDocumentSnapshot(doc, doc.id))
                    .toList() ??
                [];

            weeks.sort((a, b) => a.order.compareTo(b.order));

            return WeeksListview(weeks: weeks);
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
