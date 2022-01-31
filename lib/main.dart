import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick/firebase_options.dart';
import 'package:pick/palette.dart';
import 'router.dart' as my_router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/auth',
      title: 'Pickem App',
      onGenerateRoute: my_router.Router.generateRoute,
      theme: ThemeData(
        primarySwatch: Palette.shascoBlue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            primary: Palette.shascoBlue,
            onPrimary: Palette.shascoGrey[50],
            textStyle: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: BorderSide(
              color: Palette.shascoBlue,
              width: 1,
            ),
            primary: Palette.shascoBlue,
            textStyle: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            primary: Palette.shascoBlue, // background color
            textStyle: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
