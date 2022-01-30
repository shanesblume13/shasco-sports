import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as hr;
import 'package:pick/firebase_options.dart';
import 'package:pick/locator.dart';
import 'package:provider/provider.dart';
import 'ui/router.dart' as my_router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  runApp(const hr.ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: const [],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/auth',
        title: 'Pickem App',
        onGenerateRoute: my_router.Router.generateRoute,
      ),
    );
  }
}



// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'NFL Picks',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   //late final GSheets gsheets;
//   //late final Spreadsheet ss;
//   //Worksheet? sheet;
//   int rowCount = 2;
//   bool flag = false;
//   final List<String> _teams = [];
//   List<int> _picks = [];
//   List<String> _imagePaths = [];
//   final List<String> _pickScores = ['', '', '', '', '', '', '', '', '', ''];

//   // _loadCredential() async {
//   //   gsheets = GSheets(_credentials);
//   //   ss = await gsheets.spreadsheet(_spreadsheetId);
//   //   sheet = ss.worksheetByTitle('Mobile App Test');
//   //   _getMatchups();
//   // }

//   // _getMatchups() async {
//   //   Cell team1 = await sheet!.cells.cell(column: 1, row: 4);
//   //   Cell team2 = await sheet!.cells.cell(column: 2, row: 4);
//   //   Cell team3 = await sheet!.cells.cell(column: 1, row: 5);
//   //   Cell team4 = await sheet!.cells.cell(column: 2, row: 5);
//   //   Cell team5 = await sheet!.cells.cell(column: 1, row: 6);
//   //   Cell team6 = await sheet!.cells.cell(column: 2, row: 6);
//   //   Cell team7 = await sheet!.cells.cell(column: 1, row: 7);
//   //   Cell team8 = await sheet!.cells.cell(column: 2, row: 7);
//   //   Cell team9 = await sheet!.cells.cell(column: 1, row: 8);
//   //   Cell team10 = await sheet!.cells.cell(column: 2, row: 8);
//   //   Cell team11 = await sheet!.cells.cell(column: 1, row: 9);
//   //   Cell team12 = await sheet!.cells.cell(column: 2, row: 9);
//   //   Cell team13 = await sheet!.cells.cell(column: 1, row: 10);
//   //   Cell team14 = await sheet!.cells.cell(column: 2, row: 10);
//   //   Cell team15 = await sheet!.cells.cell(column: 1, row: 11);
//   //   Cell team16 = await sheet!.cells.cell(column: 2, row: 11);
//   //   Cell team17 = await sheet!.cells.cell(column: 1, row: 12);
//   //   Cell team18 = await sheet!.cells.cell(column: 2, row: 12);
//   //   Cell team19 = await sheet!.cells.cell(column: 1, row: 13);
//   //   Cell team20 = await sheet!.cells.cell(column: 2, row: 13);

//   //   Cell pick1 = await sheet!.cells.cell(column: 12, row: 4);
//   //   Cell pick2 = await sheet!.cells.cell(column: 12, row: 5);
//   //   Cell pick3 = await sheet!.cells.cell(column: 12, row: 6);
//   //   Cell pick4 = await sheet!.cells.cell(column: 12, row: 7);
//   //   Cell pick5 = await sheet!.cells.cell(column: 12, row: 8);
//   //   Cell pick6 = await sheet!.cells.cell(column: 12, row: 9);
//   //   Cell pick7 = await sheet!.cells.cell(column: 12, row: 10);
//   //   Cell pick8 = await sheet!.cells.cell(column: 12, row: 11);
//   //   Cell pick9 = await sheet!.cells.cell(column: 12, row: 12);
//   //   Cell pick10 = await sheet!.cells.cell(column: 12, row: 13);

//   //   Cell pickScore1 = await sheet!.cells.cell(column: 13, row: 4);
//   //   Cell pickScore2 = await sheet!.cells.cell(column: 13, row: 5);
//   //   Cell pickScore3 = await sheet!.cells.cell(column: 13, row: 6);
//   //   Cell pickScore4 = await sheet!.cells.cell(column: 13, row: 7);
//   //   Cell pickScore5 = await sheet!.cells.cell(column: 13, row: 8);
//   //   Cell pickScore6 = await sheet!.cells.cell(column: 13, row: 9);
//   //   Cell pickScore7 = await sheet!.cells.cell(column: 13, row: 10);
//   //   Cell pickScore8 = await sheet!.cells.cell(column: 13, row: 11);
//   //   Cell pickScore9 = await sheet!.cells.cell(column: 13, row: 12);
//   //   Cell pickScore10 = await sheet!.cells.cell(column: 13, row: 13);

//   //   setState(() {
//   //     _teams.add(team1);
//   //     _teams.add(team2);
//   //     _teams.add(team3);
//   //     _teams.add(team4);
//   //     _teams.add(team5);
//   //     _teams.add(team6);
//   //     _teams.add(team7);
//   //     _teams.add(team8);
//   //     _teams.add(team9);
//   //     _teams.add(team10);
//   //     _teams.add(team11);
//   //     _teams.add(team12);
//   //     _teams.add(team13);
//   //     _teams.add(team14);
//   //     _teams.add(team15);
//   //     _teams.add(team16);
//   //     _teams.add(team17);
//   //     _teams.add(team18);
//   //     _teams.add(team19);
//   //     _teams.add(team20);
//   //   });

//   //   if (pick1.value == team1.value) {
//   //     setState(() {
//   //       _picks.add(0);
//   //     });
//   //   }
//   //   if (pick1.value == team2.value) {
//   //     setState(() {
//   //       _picks.add(1);
//   //     });
//   //   }

//   //   if (pick2.value == team3.value) {
//   //     setState(() {
//   //       _picks.add(2);
//   //     });
//   //   }
//   //   if (pick2.value == team4.value) {
//   //     setState(() {
//   //       _picks.add(3);
//   //     });
//   //   }

//   //   if (pick3.value == team5.value) {
//   //     setState(() {
//   //       _picks.add(4);
//   //     });
//   //   }
//   //   if (pick3.value == team6.value) {
//   //     setState(() {
//   //       _picks.add(5);
//   //     });
//   //   }

//   //   if (pick4.value == team7.value) {
//   //     setState(() {
//   //       _picks.add(6);
//   //     });
//   //   }
//   //   if (pick4.value == team8.value) {
//   //     setState(() {
//   //       _picks.add(7);
//   //     });
//   //   }

//   //   if (pick5.value == team9.value) {
//   //     setState(() {
//   //       _picks.add(8);
//   //     });
//   //   }
//   //   if (pick5.value == team10.value) {
//   //     setState(() {
//   //       _picks.add(9);
//   //     });
//   //   }

//   //   if (pick6.value == team11.value) {
//   //     setState(() {
//   //       _picks.add(10);
//   //     });
//   //   }
//   //   if (pick6.value == team12.value) {
//   //     setState(() {
//   //       _picks.add(11);
//   //     });
//   //   }

//   //   if (pick7.value == team13.value) {
//   //     setState(() {
//   //       _picks.add(12);
//   //     });
//   //   }
//   //   if (pick7.value == team14.value) {
//   //     setState(() {
//   //       _picks.add(13);
//   //     });
//   //   }

//   //   if (pick8.value == team15.value) {
//   //     setState(() {
//   //       _picks.add(14);
//   //     });
//   //   }
//   //   if (pick8.value == team16.value) {
//   //     setState(() {
//   //       _picks.add(15);
//   //     });
//   //   }

//   //   if (pick9.value == team17.value) {
//   //     setState(() {
//   //       _picks.add(16);
//   //     });
//   //   }
//   //   if (pick9.value == team18.value) {
//   //     setState(() {
//   //       _picks.add(17);
//   //     });
//   //   }

//   //   if (pick10.value == team19.value) {
//   //     setState(() {
//   //       _picks.add(18);
//   //     });
//   //   }
//   //   if (pick10.value == team20.value) {
//   //     setState(() {
//   //       _picks.add(19);
//   //     });
//   //   }

//   //   _pickScores[0] = pickScore1.value;
//   //   _pickScores[1] = pickScore2.value;
//   //   _pickScores[2] = pickScore3.value;
//   //   _pickScores[3] = pickScore4.value;
//   //   _pickScores[4] = pickScore5.value;
//   //   _pickScores[5] = pickScore6.value;
//   //   _pickScores[6] = pickScore7.value;
//   //   _pickScores[7] = pickScore8.value;
//   //   _pickScores[8] = pickScore9.value;
//   //   _pickScores[9] = pickScore10.value;
//   // }

//   // _uploadData() async {
//   //   setState(() {
//   //     flag = true;
//   //   });

//   //   String pick1 = _picks.contains(0)
//   //       ? _teams[0].value
//   //       : _picks.contains(1)
//   //           ? _teams[1].value
//   //           : '';

//   //   String pick2 = _picks.contains(2)
//   //       ? _teams[2].value
//   //       : _picks.contains(3)
//   //           ? _teams[3].value
//   //           : '';

//   //   String pick3 = _picks.contains(4)
//   //       ? _teams[4].value
//   //       : _picks.contains(5)
//   //           ? _teams[5].value
//   //           : '';

//   //   String pick4 = _picks.contains(6)
//   //       ? _teams[6].value
//   //       : _picks.contains(7)
//   //           ? _teams[7].value
//   //           : '';

//   //   String pick5 = _picks.contains(8)
//   //       ? _teams[8].value
//   //       : _picks.contains(9)
//   //           ? _teams[9].value
//   //           : '';

//   //   String pick6 = _picks.contains(10)
//   //       ? _teams[10].value
//   //       : _picks.contains(11)
//   //           ? _teams[11].value
//   //           : '';

//   //   String pick7 = _picks.contains(12)
//   //       ? _teams[12].value
//   //       : _picks.contains(13)
//   //           ? _teams[13].value
//   //           : '';

//   //   String pick8 = _picks.contains(14)
//   //       ? _teams[14].value
//   //       : _picks.contains(15)
//   //           ? _teams[15].value
//   //           : '';

//   //   String pick9 = _picks.contains(16)
//   //       ? _teams[16].value
//   //       : _picks.contains(17)
//   //           ? _teams[17].value
//   //           : '';

//   //   String pick10 = _picks.contains(18)
//   //       ? _teams[18].value
//   //       : _picks.contains(19)
//   //           ? _teams[19].value
//   //           : '';

//   //   await sheet!.values.insertValue(pick1, column: 12, row: 4);
//   //   await sheet!.values.insertValue(pick2, column: 12, row: 5);
//   //   await sheet!.values.insertValue(pick3, column: 12, row: 6);
//   //   await sheet!.values.insertValue(pick4, column: 12, row: 7);
//   //   await sheet!.values.insertValue(pick5, column: 12, row: 8);
//   //   await sheet!.values.insertValue(pick6, column: 12, row: 9);
//   //   await sheet!.values.insertValue(pick7, column: 12, row: 10);
//   //   await sheet!.values.insertValue(pick8, column: 12, row: 11);
//   //   await sheet!.values.insertValue(pick9, column: 12, row: 12);
//   //   await sheet!.values.insertValue(pick10, column: 12, row: 13);

//   //   await sheet!.values.insertValue(_pickScores[0], column: 13, row: 4);
//   //   await sheet!.values.insertValue(_pickScores[1], column: 13, row: 5);
//   //   await sheet!.values.insertValue(_pickScores[2], column: 13, row: 6);
//   //   await sheet!.values.insertValue(_pickScores[3], column: 13, row: 7);
//   //   await sheet!.values.insertValue(_pickScores[4], column: 13, row: 8);
//   //   await sheet!.values.insertValue(_pickScores[5], column: 13, row: 9);
//   //   await sheet!.values.insertValue(_pickScores[6], column: 13, row: 10);
//   //   await sheet!.values.insertValue(_pickScores[7], column: 13, row: 11);
//   //   await sheet!.values.insertValue(_pickScores[8], column: 13, row: 12);
//   //   await sheet!.values.insertValue(_pickScores[9], column: 13, row: 13);

//   //   rowCount++;
//   //   setState(() {
//   //     flag = false;
//   //   });
//   // }

//   // _updatePicks(int i, bool isHome) {
//   //   List<int> picks = _picks;

//   //   if (picks.contains(i)) {
//   //     picks.remove(i);
//   //   } else {
//   //     if (isHome) {
//   //       if (picks.contains(i - 1)) {
//   //         picks.remove(i - 1);
//   //       }
//   //       picks.add(i);
//   //     } else {
//   //       if (picks.contains(i + 1)) {
//   //         picks.remove(i + 1);
//   //       }
//   //       picks.add(i);
//   //     }
//   //   }

//   //   setState(() {
//   //     _picks = picks;
//   //   });
//   // }

//   // _updatePickScore(int i) {
//   //   String pickScore = _pickScores[i];
//   //   int? pickScoreInt = int.tryParse(pickScore) ?? 0;

//   //   pickScoreInt++;
//   //   if (pickScoreInt > 10) {
//   //     pickScoreInt = 0;
//   //   }
//   //   pickScore = pickScoreInt.toString();

//   //   setState(() {
//   //     _pickScores[i] = pickScore;
//   //   });
//   // }

//   @override
//   void initState() {
//     _initImages();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('NFL Picks'),
//       ),
//       body: Center(
//         child: flag
//             ? Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     CircularProgressIndicator(
//                       color: Colors.blue,
//                     ),
//                     Text('Please wait...'),
//                   ],
//                 ),
//               )
//             : getMatchups,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: flag ? null : null, //_saveData,
//         tooltip: 'Save',
//         backgroundColor: flag ? Colors.black12 : Colors.blue,
//         child: const Icon(Icons.save),
//       ),
//     );
//   }

//   Widget get getMatchups {
//     List<Widget> matchups = [];

//     for (int i = 0; i < _teams.length - 1; i++) {
//       if (i % 2 == 0) {
//         String defaultImagePath = 'assets/images/logos/nfl/nfl.jpeg';
//         String awayImagePath = defaultImagePath;
//         String homeImagePath = defaultImagePath;
//         int pickScoreIndex = 0;

//         switch (i) {
//           case 0:
//             pickScoreIndex = 0;
//             break;
//           case 2:
//             pickScoreIndex = 1;
//             break;
//           case 4:
//             pickScoreIndex = 2;
//             break;
//           case 6:
//             pickScoreIndex = 3;
//             break;
//           case 8:
//             pickScoreIndex = 4;
//             break;
//           case 10:
//             pickScoreIndex = 5;
//             break;
//           case 12:
//             pickScoreIndex = 6;
//             break;
//           case 14:
//             pickScoreIndex = 7;
//             break;
//           case 16:
//             pickScoreIndex = 8;
//             break;
//           case 18:
//             pickScoreIndex = 9;
//             break;
//         }

//         if (_imagePaths.contains(
//             'assets/images/logos/nfl/${_teams[i].toLowerCase()}.gif')) {
//           awayImagePath =
//               'assets/images/logos/nfl/${_teams[i].toLowerCase()}.gif';
//         }

//         if (_imagePaths.contains(
//             'assets/images/logos/nfl/${_teams[i + 1].toLowerCase()}.gif')) {
//           homeImagePath =
//               'assets/images/logos/nfl/${_teams[i + 1].toLowerCase()}.gif';
//         }

//         matchups.add(
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Card(
//               elevation: 6,
//               child: LayoutGrid(
//                 areas: '''
//                   awayLogo awayName scoreDivider homeName homeLogo
//                 ''',
//                 rowSizes: const [auto],
//                 columnSizes: [1.fr, 2.fr, auto, 2.fr, 1.fr],
//                 children: [
//                   gridArea('awayLogo').containing(
//                     InkWell(
//                       onTap: () => null, //_savePick(i, false),
//                       splashColor: Colors.transparent,
//                       child: TeamImageContainer(
//                         isPicked: _picks.contains(i),
//                         imagePath: awayImagePath,
//                         isHome: false,
//                       ),
//                     ),
//                   ),
//                   gridArea('awayName').containing(
//                     InkWell(
//                       onTap: () => null, //_savePick(i, false),
//                       splashColor: Colors.transparent,
//                       child: TeamNameContainer(
//                         isPicked: _picks.contains(i),
//                         teamName: _teams[i],
//                         isHome: false,
//                       ),
//                     ),
//                   ),
//                   gridArea('scoreDivider').containing(
//                     InkWell(
//                       onTap: () => null, //_savePickScore(pickScoreIndex),
//                       splashColor: Colors.transparent,
//                       child: PickScoreDivider(
//                         homePicked: _picks.contains(i + 1),
//                         awayPicked: _picks.contains(i),
//                         pickScore: _pickScores[pickScoreIndex],
//                       ),
//                     ),
//                   ),
//                   gridArea('homeName').containing(
//                     InkWell(
//                       onTap: () => null, //_savePick(i + 1, true),
//                       splashColor: Colors.transparent,
//                       child: TeamNameContainer(
//                         isPicked: _picks.contains(i + 1),
//                         teamName: _teams[i + 1],
//                         isHome: true,
//                       ),
//                     ),
//                   ),
//                   gridArea('homeLogo').containing(
//                     InkWell(
//                       onTap: () => null, //_savePick(i + 1, true),
//                       splashColor: Colors.transparent,
//                       child: TeamImageContainer(
//                         isPicked: _picks.contains(i + 1),
//                         imagePath: homeImagePath,
//                         isHome: true,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }
//     }
//     return ListView(children: matchups);
//   }

//   // void _saveData() {
//   //   setState(() {
//   //     _uploadData();
//   //   });
//   // }

//   // void _savePick(int i, bool isHome) {
//   //   setState(() {
//   //     _updatePicks(i, isHome);
//   //   });
//   // }

//   // void _savePickScore(int index) {
//   //   setState(() {
//   //     _updatePickScore(index);
//   //   });
//   // }

//   Future _initImages() async {
//     // >> To get paths you need these 2 lines
//     final manifestContent = await rootBundle.loadString('AssetManifest.json');

//     final Map<String, dynamic> manifestMap = json.decode(manifestContent);
//     // >> To get paths you need these 2 lines

//     final imagePaths = manifestMap.keys
//         .where((String key) => key.contains('images/'))
//         .toList();

//     setState(() {
//       _imagePaths = imagePaths;
//     });
//   }
// }
