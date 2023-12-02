# weight_tracker

A sample Flutter app to store and record display weights. The app is integrated with Firebase FireStore to store / retrieve data

## Installation
1 - Clone the project
2- Make sure iOS device or simulator is running and connected
3- Use 'flutter run' command

## Highlights
Some highlights include:

- Sign in using Firebase (Anonymously)
- Add Weights
- Sync to FireStore
- Use of calendar to pick dates
- Remove Weights
- View list of weights
- Charts displaying weights over a time
- Use of Provider package for dependency injection

## Extra features:
- Edit Weights has been implemented
- A simple chart has been added to the top of the home page allowing to visualize the entries
- Signout functionality has been implemented

## Notes & Considerations

- Screenshots and video walk-through of the app can be found in the "screenshot" folder.
- The existing implementation is fully functional and performs efficiently on the iOS platform.
- Owing to constraints in time, the Android segment of the project is yet to be set up with Firebase. However, this integration is straightforward, given the successful implementation of both the iOS and Firebase components.
- Unit tests have not been implemented yet. Nonetheless, the business logic pertaining to the CRUD operations for weight management has been structured in a manner that facilitates testability.
- The remote persistence layer (Firestore) is abstracted and injected into the WeightProvider as a dependency. This approach enhances testability for both components.
- The same approach could have been done for the authentication, however due to exercise time limitation, only the storage has been abstracted.


