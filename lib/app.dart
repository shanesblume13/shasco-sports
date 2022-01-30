import 'package:flutter/material.dart';
import 'package:pick/palette.dart';
import 'router.dart' as my_router;

class MainApp extends StatelessWidget {
  const MainApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      title: 'Pickem App',
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
      onGenerateRoute: my_router.Router.generateRoute,
    );
  }
}
