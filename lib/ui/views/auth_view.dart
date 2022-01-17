import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:pick/ui/widgets/auth/auth_card.dart';
import '/ui/router.dart' as my_router;

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            headerBuilder: (context, constraints, _) {
              return const Padding(
                padding: EdgeInsets.all(20.0),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: AuthCard(),
                ),
              );
            },
            providerConfigs: const [
              EmailProviderConfiguration(),
            ],
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
