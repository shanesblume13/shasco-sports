import 'package:pick/core/models/game_model.dart';

class GameViewModel {
  List<Game> games = Game.games;

  List<Game> fetchGames() {
    return games;
  }

  Game getGameById(int id) {
    return games.firstWhere((game) => game.id == id);
  }

  Game getGameByName(String name) {
    return games
        .firstWhere((game) => game.name.toLowerCase() == name.toLowerCase());
  }
}
