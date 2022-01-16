import 'package:flutter/material.dart';
import 'package:pick/core/models/week_model.dart';
import 'package:pick/core/viewmodels/week_crud_model.dart';
import 'package:pick/ui/views/modify_week.dart';
import 'package:provider/provider.dart';

class WeekDetail extends StatelessWidget {
  final Week week;

  const WeekDetail({
    Key? key,
    required this.week,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weekProvider = Provider.of<WeekCrudModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Week Detail'),
        actions: [
          IconButton(
            iconSize: 35,
            icon: const Icon(Icons.delete_forever),
            onPressed: () async {
              await weekProvider.removeWeek(week.id);
              Navigator.pop(context);
            },
          ),
          IconButton(
            iconSize: 35,
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ModifyWeek(
                    week: week,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Hero(
          //   tag: week.id,
          //   child: Image.asset(
          //     'assets/${product.img}.jpg',
          //     height: MediaQuery.of(context).size.height * 0.35,
          //     width: MediaQuery.of(context).size.width,
          //   ),
          // ),
          const SizedBox(
            height: 20,
          ),
          Text(
            week.name,
            style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                fontStyle: FontStyle.italic),
          ),
          Text(
            '${week.startDate} \$',
            style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                fontStyle: FontStyle.italic,
                color: Colors.orangeAccent),
          )
        ],
      ),
    );
  }
}
