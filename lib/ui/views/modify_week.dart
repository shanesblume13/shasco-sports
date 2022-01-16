import 'package:flutter/material.dart';
import 'package:pick/core/models/week_model.dart';
import 'package:pick/core/viewmodels/week_crud_model.dart';
import 'package:provider/provider.dart';

class ModifyWeek extends StatefulWidget {
  final Week week;

  const ModifyWeek({
    Key? key,
    required this.week,
  }) : super(key: key);

  @override
  _ModifyWeekState createState() => _ModifyWeekState();
}

class _ModifyWeekState extends State<ModifyWeek> {
  final _formKey = GlobalKey<FormState>();

  String id = '';
  String name = '';
  int order = 0;
  String startDate = '';
  String lockDate = '';
  String endDate = '';
  bool isLocked = true;
  bool isComplete = false;

  @override
  Widget build(BuildContext context) {
    final weekProvider = Provider.of<WeekCrudModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Modify Week Detail'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                  initialValue: widget.week.name,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Name',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter Name';
                    }
                  },
                  onSaved: (value) => name = value ?? ''),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                  initialValue: widget.week.order.toString(),
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
                  onSaved: (value) => order = int.tryParse(value ?? '') ?? 0),
              TextFormField(
                  initialValue: widget.week.startDate,
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
                  onSaved: (value) => startDate = value ?? ''),
              TextFormField(
                  initialValue: widget.week.lockDate,
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
                  onSaved: (value) => lockDate = value ?? ''),
              TextFormField(
                  initialValue: widget.week.endDate,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'End Date',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter am End Date';
                    }
                  },
                  onSaved: (value) => endDate = value ?? ''),
              Checkbox(
                value: widget.week.isLocked,
                onChanged: (bool? newValue) {
                  setState(() {
                    isLocked = newValue ?? true;
                  });
                },
              ),
              Checkbox(
                value: widget.week.isComplete,
                onChanged: (bool? newValue) {
                  setState(() {
                    isComplete = newValue ?? false;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    await weekProvider.updateWeek(
                        Week(
                          id: widget.week.id,
                          name: name,
                          order: order,
                          startDate: startDate,
                          lockDate: lockDate,
                          endDate: endDate,
                          isLocked: isLocked,
                          isComplete: isComplete,
                          season: null,
                        ),
                        widget.week.id);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Modify Week',
                    style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
