import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/ui/router.dart' as my_router;

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Text('Not Authenticated'),
          );
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          title: 'Pickem App',
          theme: ThemeData(),
          onGenerateRoute: my_router.Router.generateRoute,
        );
      },
    );
  }
}
