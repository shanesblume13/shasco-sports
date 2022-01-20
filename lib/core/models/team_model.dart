class Team {
  int id;
  int leagueId;
  String location;
  String nickname;
  String imagePath;

  Team({
    required this.id,
    required this.leagueId,
    required this.location,
    required this.nickname,
    required this.imagePath,
  });

  static List<Team> teams = [
    Team(
      id: 1,
      leagueId: 1,
      location: "Arizona",
      nickname: "Cardinals",
      imagePath: "assets/images/logos/nfl/cardinals.gif",
    ),
    Team(
      id: 2,
      leagueId: 1,
      location: "Atlanta",
      nickname: "Falcons",
      imagePath: "assets/images/logos/nfl/falcons.gif",
    ),
  ];
}
