import 'package:flutter/material.dart';
import 'package:pick/ui/views/auth_view.dart';
import 'package:pick/ui/views/games_view.dart';
import 'package:pick/ui/views/logo_view.dart';
import 'package:pick/sport/sports_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const SportsView(),
        );
      case '/auth':
        return MaterialPageRoute(
          builder: (_) => const AuthView(),
        );
      case '/logo':
        return MaterialPageRoute(
          builder: (_) => const LogoView(),
        );
      case '/sports':
        return MaterialPageRoute(
          builder: (_) => const SportsView(),
        );
      case '/games':
        return MaterialPageRoute(
          builder: (_) => const GamesView(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
              ),
            ),
          ),
        );
    }
  }
}
