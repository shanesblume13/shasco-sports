import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick/core/models/matchup_model.dart';
import 'package:pick/core/viewmodels/matchup_crud_model.dart';
import 'package:provider/provider.dart';

class AddMathcupView extends StatefulWidget {
  const AddMathcupView({Key? key}) : super(key: key);

  @override
  _AddMathcupViewState createState() => _AddMathcupViewState();
}

class _AddMathcupViewState extends State<AddMathcupView> {
  final _formKey = GlobalKey<FormState>();
  String weekId = '';
  int weekOrder = 0;
  String homeTeamId = '';
  String awayTeamId = '';
  bool isLocked = true;
  bool isComplete = false;
  double homeTeamSpread = 0;
  String winningTeamId = '';

  @override
  Widget build(BuildContext context) {
    var matchupProvider = Provider.of<MatchupCrudModel>(context);
    List<String> teamIds = ['1', '2', '3', '4', '5'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Matchup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButton<String>(
                value: '1',
                onChanged: (String? newValue) {
                  setState(() {
                    weekId = newValue ?? '';
                  });
                },
                items: teamIds.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Week Order',
                  fillColor: Colors.grey[300],
                  filled: true,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a Week Order';
                  }
                },
                onSaved: (value) => weekOrder = int.parse(value ?? '0'),
              ),
              DropdownButton<String>(
                value: '1',
                onChanged: (String? newValue) {
                  setState(() {
                    homeTeamId = newValue ?? '';
                  });
                },
                items: teamIds.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              DropdownButton<String>(
                value: '2',
                onChanged: (String? newValue) {
                  setState(() {
                    awayTeamId = newValue ?? '';
                  });
                },
                items: <String>['1', '2', '3', '4', '5']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Checkbox(
                value: isLocked,
                onChanged: (bool? newValue) {
                  setState(() {
                    isLocked = newValue ?? true;
                  });
                },
              ),
              Checkbox(
                value: isComplete,
                onChanged: (bool? newValue) {
                  setState(() {
                    isLocked = newValue ?? false;
                  });
                },
              ),
              TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Home Team Spread',
                  fillColor: Colors.grey[300],
                  filled: true,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a Home Team Spread';
                  }
                },
                onSaved: (value) =>
                    homeTeamSpread = double.parse(value ?? '0.0'),
              ),
              DropdownButton<String>(
                value: '1',
                onChanged: (String? newValue) {
                  setState(() {
                    winningTeamId = newValue ?? '';
                  });
                },
                items: <String>['1', '2', '3', '4', '5']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await matchupProvider.addMatchup(
                      Matchup(
                        id: '',
                        weekId: weekId as DocumentReference,
                        weekOrder: weekOrder,
                        homeTeamId: homeTeamId,
                        awayTeamId: awayTeamId,
                        isLocked: isLocked,
                        isComplete: isComplete,
                        homeTeamSpread: homeTeamSpread,
                        winningTeamId: winningTeamId,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Matchup',
                    style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
