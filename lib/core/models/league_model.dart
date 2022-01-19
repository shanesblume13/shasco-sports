class League {
  int id;
  String name;
  String imagePath;
  String sport;

  League({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.sport,
  });

  static List<League> leagues = [
    League(
      id: 1,
      name: 'NFL',
      imagePath: 'assets/images/logos/nfl/nfl.jpeg',
      sport: 'football',
    ),
    League(
      id: 2,
      name: 'NCAAF',
      imagePath: 'assets/images/logos/ncaa/ncaa.jpeg',
      sport: 'football',
    ),
    League(
      id: 3,
      name: 'NCAAM',
      imagePath: 'assets/images/logos/ncaa/ncaa.jpeg',
      sport: 'basketball',
    ),
  ];
}
