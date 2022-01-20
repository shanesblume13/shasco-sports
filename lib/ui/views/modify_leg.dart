import 'package:flutter/material.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/viewmodels/leg_view_model.dart';
import 'package:provider/provider.dart';

class ModifyLeg extends StatefulWidget {
  final Leg leg;

  const ModifyLeg({
    Key? key,
    required this.leg,
  }) : super(key: key);

  @override
  _ModifyLegState createState() => _ModifyLegState();
}

class _ModifyLegState extends State<ModifyLeg> {
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
    final legProvider = Provider.of<LegViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Modify Leg Detail'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                  initialValue: widget.leg.name,
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
                  initialValue: widget.leg.startDate.toString(),
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
                  initialValue: widget.leg.lockDate.toString(),
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
                  initialValue: widget.leg.endDate.toString(),
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
                value: widget.leg.isLocked,
                onChanged: (bool? newValue) {
                  setState(() {
                    isLocked = newValue ?? true;
                  });
                },
              ),
              Checkbox(
                value: widget.leg.isComplete,
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
                    await legProvider.updateLeg(
                        Leg(
                          id: widget.leg.id,
                          name: name,
                          startDate: DateTime.parse(startDate),
                          lockDate: DateTime.parse(lockDate),
                          endDate: DateTime.parse(endDate),
                          isLocked: isLocked,
                          isComplete: isComplete,
                          seasonReference: widget.leg.seasonReference,
                        ),
                        widget.leg.id);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Modify Leg',
                    style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
