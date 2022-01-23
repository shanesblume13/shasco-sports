import 'package:pick/core/models/sport_model.dart';

class SportViewModel {
  List<Sport> sports = Sport.sports;

  List<Sport> fetchSports() {
    return sports;
  }

  Sport getSportById(int id) {
    return sports.firstWhere((sport) => sport.id == id);
  }
}
