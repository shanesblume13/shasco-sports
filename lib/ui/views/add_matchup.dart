import 'package:flutter/material.dart';
import 'package:pick/core/models/leg_model.dart';

class AddMathcupView extends StatefulWidget {
  const AddMathcupView({
    Key? key,
    required this.leg,
  }) : super(key: key);

  final Leg leg;

  @override
  _AddMathcupViewState createState() => _AddMathcupViewState();
}

class _AddMathcupViewState extends State<AddMathcupView> {
  final _formKey = GlobalKey<FormState>();
  String legId = '';
  int legOrder = 0;
  String homeTeamId = '';
  String awayTeamId = '';
  bool isLocked = true;
  bool isComplete = false;
  double homeTeamSpread = 0;
  String winningTeamId = '';

  @override
  Widget build(BuildContext context) {
    // var matchupProvider = Provider.of<MatchupViewModel>(context);
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
                    legId = newValue ?? '';
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
                  hintText: 'Leg Order',
                  fillColor: Colors.grey[300],
                  filled: true,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a Leg Order';
                  }
                },
                onSaved: (value) => legOrder = int.parse(value ?? '0'),
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
                  // if (_formKey.currentState!.validate()) {
                  //   _formKey.currentState!.save();
                  //   await matchupProvider.addMatchup(
                  //     Matchup(
                  //       id: '',
                  //       homeTeamId: int.parse(homeTeamId),
                  //       awayTeamId: int.parse(awayTeamId),
                  //       startDateTime: DateTime.now(),
                  //       lockDateTime: DateTime.now(),
                  //       isLocked: isLocked,
                  //       isComplete: isComplete,
                  //       homeTeamSpread: homeTeamSpread,
                  //       winningTeamId: int.parse(winningTeamId),
                  //       legReference: widget.leg.reference!,
                  //     ),
                  //   );
                  //   Navigator.pop(context);
                  // }
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
