import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/core/models/sport_model.dart';
import 'package:pick/core/viewmodels/sport_provider.dart';
import 'package:pick/ui/widgets/sports/sport_cards_listview.dart';

class SportsView extends HookConsumerWidget {
  const SportsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Sport> sports = ref.watch(sportProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Sports'),
        ),
      ),
      body: SportCardsListview(sports: sports),
    ); //
  }
}
