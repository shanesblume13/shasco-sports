import 'package:flutter/material.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/viewmodels/leg_view_model.dart';
import 'package:provider/provider.dart';

class AddLegView extends StatefulWidget {
  const AddLegView({Key? key}) : super(key: key);

  @override
  _AddLegViewState createState() => _AddLegViewState();
}

class _AddLegViewState extends State<AddLegView> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  int order = 0;
  DateTime startDate = DateTime.now();
  DateTime lockDate = DateTime.now();
  DateTime endDate = DateTime.now();
  bool isLocked = true;
  bool isComplete = false;

  @override
  Widget build(BuildContext context) {
    var legProvider = Provider.of<LegViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Leg'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Name',
                  fillColor: Colors.grey[300],
                  filled: true,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a Name';
                  }
                },
                onSaved: (value) => name = value ?? 'New Leg',
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Order',
                  fillColor: Colors.grey[300],
                  filled: true,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter an Order';
                  }
                },
                onSaved: (value) => order = int.tryParse(value ?? '') ?? 0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Start Date',
                  fillColor: Colors.grey[300],
                  filled: true,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a Start Date';
                  }
                },
                onSaved: (value) => startDate = DateTime.parse(value ?? ''),
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Lock Date',
                  fillColor: Colors.grey[300],
                  filled: true,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a Lock Date';
                  }
                },
                onSaved: (value) => lockDate = DateTime.parse(value ?? ''),
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'End Date',
                  fillColor: Colors.grey[300],
                  filled: true,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter an End Date';
                  }
                },
                onSaved: (value) => endDate = DateTime.parse(value ?? ''),
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
                    isComplete = newValue ?? false;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await legProvider.addLeg(
                      Leg(
                        id: '',
                        name: name,
                        startDate: startDate,
                        lockDate: lockDate,
                        endDate: endDate,
                        isLocked: isLocked,
                        isComplete: isComplete,
                        // TODO: Implement seasonId
                        seasonReference: null,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Add Leg',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
