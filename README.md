
# Pick

A mobile app built with flutter and firebase that allows users to play various games based on sports predecitions.

# To Do
- Demo a week of picks
    - [x] League: NFL
    - [x] Season: 2021-2022
    - [x] Leg: Week 1
    - [x] 3 Matchups
    - [] 2 Users w/ Picks
    - [] Stats, Graphs, and Results
- Finish removing _old files
- Add picks to ui
- Add picks by user
- Add score color coding and validation.
- Fix matchup card color transitions when changing picked team.
- Add chevrons to flat outlined option cards that navigate.
- Add rounded bezel to score divider
- Save / clear picks on reset button click or navigation.
- Add new score selection ui.
- Add typing to all providers.
- Reduce use of "all" calls to firebase.
- Add sports and leagues to firestore.
- Use auth from provider.
- Get uid for picks.
- Modify and save user picks.
- Figure out how to handle null document references (winningTeamReference)
- Add user permissions
- Use image clip icons and colors to distinguish status.
- Figure out how to handle dates correctly.
- Create a splash screen.
- Update loading indicator to incorporate logo.
- Add pick'em leagues
- Add pick'em metrics
- Add a squares style format.
- Add secret json file location https://blog.codemagic.io/deploying-flutter-app-to-firebase-app-distribution-using-fastlane/
- fastlane supply init when developer account is setup.
- Add options
    - Use spread
    - Scoring (confidence, sevencoals, single point)

# Issues
- Navigation back with a swipe goes back to sports page.
- App signs with dominionsystems email unless XCode is open and updated.
- Fastlane files are removed on pub get.
- Podfile reverts platform:ios version to 9.0 on pub get.
- IOS/Pods project updates made on pub get.
- Theme data currently stored on 2 different MaterialApps.
