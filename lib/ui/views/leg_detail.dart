import 'package:flutter/material.dart';
import 'package:pick/core/models/leg_model.dart';
import 'package:pick/core/viewmodels/leg_crud_model.dart';
import 'package:pick/ui/views/modify_leg.dart';
import 'package:provider/provider.dart';

class LegDetail extends StatelessWidget {
  final Leg leg;

  const LegDetail({
    Key? key,
    required this.leg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final legProvider = Provider.of<LegCrudModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leg Detail'),
        actions: [
          IconButton(
            iconSize: 35,
            icon: const Icon(Icons.delete_forever),
            onPressed: () async {
              await legProvider.removeLeg(leg.id);
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
                  builder: (_) => ModifyLeg(
                    leg: leg,
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
          //   tag: leg.id,
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
            leg.name,
            style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                fontStyle: FontStyle.italic),
          ),
          Text(
            '${leg.startDate} \$',
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
