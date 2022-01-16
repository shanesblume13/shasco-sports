import 'package:flutter/material.dart';
import 'package:pick/core/models/week_model.dart';
import 'package:pick/core/viewmodels/week_crud_model.dart';
import 'package:provider/provider.dart';

class AddWeekView extends StatefulWidget {
  const AddWeekView({Key? key}) : super(key: key);

  @override
  _AddWeekViewState createState() => _AddWeekViewState();
}

class _AddWeekViewState extends State<AddWeekView> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  int order = 0;
  String startDate = '';
  String lockDate = '';
  String endDate = '';
  bool isLocked = true;
  bool isComplete = false;

  @override
  Widget build(BuildContext context) {
    var weekProvider = Provider.of<WeekCrudModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Week'),
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
                onSaved: (value) => name = value ?? 'New Week',
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
                onSaved: (value) => startDate = value ?? '',
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
                onSaved: (value) => lockDate = value ?? '',
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
                onSaved: (value) => endDate = value ?? '',
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
                    await weekProvider.addWeek(
                      Week(
                        id: '',
                        name: name,
                        order: order,
                        startDate: startDate,
                        lockDate: lockDate,
                        endDate: endDate,
                        isLocked: isLocked,
                        isComplete: isComplete,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Week',
                    style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
