# Pick

A mobile app built with flutter and firebase that allows users to play various games based on sports predecitions.

# To Do
- Demo a week of picks
    - [x] League: NFL, local
    - [] Season: 2021-2022, firestore SA
    - [] Leg: Week 1, firestore SA
    - [] 10 Matchups, firestore LA
    - [] 2 Users w/ Picks, firestore U
    - [] Stats, Graphs, and Results, Firestore U
- Add user permissions
- Figure out how to handle dates correctly.
- Create a splash screen.
- Update loading indicator to incorporate logo.
- Add a pick'em style format.
- Add pick'em leagues
- Add pick'em metrics
- Add a squares style format.

# Issues
- locator.registerLazySingleton(() => ApiService(<Entity Name>)) needs to be set for multiple entities.
- App signs with dominionsystems email unless XCode is open and updated.
- Fastlane files are removed on pub get.
- Podfile reverts platform:ios version to 9.0 on pub get.
- IOS/Pods project updates made on pub get.

