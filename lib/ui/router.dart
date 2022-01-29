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
      // case '/leagues':
      //   return MaterialPageRoute(
      //     builder: (_) => LeaguesView(sport: ),
      //   );
      case '/games':
        return MaterialPageRoute(
          builder: (_) => const GamesView(),
        );
      // case '/seasons':
      //   return MaterialPageRoute(
      //     builder: (_) => const SeasonsView(),
      //   );
      // case '/matchups':
      //   return MaterialPageRoute(
      //     builder: (_) => const MatchupsView(),
      //   );
      // case '/legs':
      //   return MaterialPageRoute(
      //     builder: (_) => const LegsView(seasonReference: null),
      //   );
      // case '/addMatchup':
      //   return MaterialPageRoute(
      //     builder: (_) => const AddMathcupView(),
      //   );
      // case '/addLeg':
      //   return MaterialPageRoute(
      //     builder: (_) => const AddLegView(season: season),
      //   );
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
