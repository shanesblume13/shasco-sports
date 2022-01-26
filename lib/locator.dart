import 'package:get_it/get_it.dart';
import 'package:pick/core/services/pick_api_service.dart';
import 'package:pick/core/providers/game_view_model.dart';
import 'package:pick/core/providers/pick_view_model.dart';
// import './core/viewmodels/CRUDModel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => PickApiService());
  locator.registerLazySingleton(() => GameViewModel());
  locator.registerLazySingleton(() => PickViewModel());
}
