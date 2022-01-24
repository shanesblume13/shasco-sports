import 'package:get_it/get_it.dart';
import 'package:pick/core/services/leg_api_service.dart';
import 'package:pick/core/services/matchup_api_service.dart';
import 'package:pick/core/services/pick_api_service.dart';
import 'package:pick/core/services/season_api_service.dart';
import 'package:pick/core/services/team_api_service.dart';
import 'package:pick/core/providers/game_view_model.dart';
import 'package:pick/core/providers/matchup_view_model.dart';
import 'package:pick/core/providers/pick_view_model.dart';
import 'package:pick/core/providers/season_view_model.dart';
import 'package:pick/core/providers/leg_view_model.dart';
import 'package:pick/core/providers/team_view_model.dart';
// import './core/viewmodels/CRUDModel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //locator.registerLazySingleton(() => ApiService('mathcups'));
  locator.registerLazySingleton(() => SeasonApiService());
  locator.registerLazySingleton(() => LegApiService());
  locator.registerLazySingleton(() => MatchupApiService());
  locator.registerLazySingleton(() => TeamApiService());
  locator.registerLazySingleton(() => PickApiService());
  locator.registerLazySingleton(() => MatchupViewModel());
  locator.registerLazySingleton(() => LegViewModel());
  locator.registerLazySingleton(() => SeasonViewModel());
  locator.registerLazySingleton(() => GameViewModel());
  locator.registerLazySingleton(() => TeamViewModel());
  locator.registerLazySingleton(() => PickViewModel());
}
