import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/viewmodels/leg_view_model.dart';
import 'package:pick/ui/widgets/legs/legs_listview.dart';
import 'package:provider/provider.dart';

class LegsView extends StatefulWidget {
  const LegsView({Key? key}) : super(key: key);

  @override
  _LegsViewState createState() => _LegsViewState();
}

class _LegsViewState extends State<LegsView> {
  List<Leg> legs = [];

  @override
  Widget build(BuildContext context) {
    final legProvider = Provider.of<LegViewModel>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/addLeg');
        },
      ),
      appBar: AppBar(
        title: const Center(
          child: Text('Legs View'),
        ),
      ),
      body: StreamBuilder(
        stream: legProvider.fetchLegsAsStream(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            legs = snapshot.data?.docs
                    .map((doc) => Leg.fromQueryDocumentSnapshot(doc, doc.id))
                    .toList() ??
                [];

            legs.sort((a, b) => a.startDate.compareTo(b.startDate));

            return LegsListview(legs: legs);
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
