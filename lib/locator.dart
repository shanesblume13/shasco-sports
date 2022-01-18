import 'package:get_it/get_it.dart';
import 'package:pick/core/services/api_service.dart';
import 'package:pick/core/viewmodels/game_crud_model.dart';
import 'package:pick/core/viewmodels/matchup_crud_model.dart';
import 'package:pick/core/viewmodels/league_crud_model.dart';
import 'package:pick/core/viewmodels/season_crud_mold.dart';
import 'package:pick/core/viewmodels/sport_crud_model.dart';
import 'package:pick/core/viewmodels/leg_crud_model.dart';
// import './core/viewmodels/CRUDModel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //locator.registerLazySingleton(() => ApiService('mathcups'));
  locator.registerLazySingleton(() => ApiService('seasons'));
  locator.registerLazySingleton(() => MatchupCrudModel());
  locator.registerLazySingleton(() => LegCrudModel());
  locator.registerLazySingleton(() => SportCrudModel());
  locator.registerLazySingleton(() => LeagueCrudModel());
  locator.registerLazySingleton(() => SeasonCrudModel());
  locator.registerLazySingleton(() => GameCrudModel());
}
