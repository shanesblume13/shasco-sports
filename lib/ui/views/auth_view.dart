import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:pick/ui/main_app.dart';
import 'package:pick/ui/widgets/auth/auth_card.dart';

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

        return const MainApp();
      },
    );
  }
}
