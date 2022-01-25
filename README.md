
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
- Replace matchup viewmodel.
- Replace pick viewmodel.
- Use auth from provider.
- Get uid for picks.
- Modify and save user picks.
- Figure out how to handle null document references (winningTeamReference)
- Add local data to firestore
- Add user permissions
- Use image clip icons and colors to distinguish status.
- Figure out how to handle dates correctly.
- Create a splash screen.
- Update loading indicator to incorporate logo.
- Add a pick'em style format.
- Add pick'em leagues
- Add pick'em metrics
- Add a squares style format.

# Issues
- App signs with dominionsystems email unless XCode is open and updated.
- Fastlane files are removed on pub get.
- Podfile reverts platform:ios version to 9.0 on pub get.
- IOS/Pods project updates made on pub get.

# Folder Structure
```
|-lib               * Create the application
|--core              * Handle data and non-ui components
|---models            * Define entities and entiy type conversions.
|---services          * Create model-based objects from external and internal data sources.        
|---providers         * Transfer objects to and from the ui.
|---utility           * Store common functions used across the backend.
|--ui                * Handle the application ui and user interactions.
|---shared            * Store common widgets used across the ui.
|---views             * Display navigable pages to the user
|---widgets           * Create small components used within specific views.
```
