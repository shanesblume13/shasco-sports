import 'package:get_it/get_it.dart';
import 'package:pick/core/services/seeason_api_service.dart';
import 'package:pick/core/viewmodels/game_view_model.dart';
import 'package:pick/core/viewmodels/matchup_view_model.dart';
import 'package:pick/core/viewmodels/league_view_model.dart';
import 'package:pick/core/viewmodels/season_view_model.dart';
import 'package:pick/core/viewmodels/sport_view_model.dart';
import 'package:pick/core/viewmodels/leg_view_model.dart';
// import './core/viewmodels/CRUDModel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //locator.registerLazySingleton(() => ApiService('mathcups'));
  locator.registerLazySingleton(() => SeasonApiService());
  locator.registerLazySingleton(() => MatchupViewModel());
  locator.registerLazySingleton(() => LegViewModel());
  locator.registerLazySingleton(() => SportViewModel());
  locator.registerLazySingleton(() => LeagueViewModel());
  locator.registerLazySingleton(() => SeasonViewModel());
  locator.registerLazySingleton(() => GameViewModel());
}
