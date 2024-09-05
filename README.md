Project Setup Instructions
1. Pre-requisites
   To run this project, you will need:

Flutter SDK version: The project is compatible with Flutter SDK versions >=3.2.3 <4.0.0.

Ensure that your Flutter SDK version is within this range. You can check your Flutter SDK version by running:

bash
Copy code
flutter --version
If you need to install or upgrade Flutter, follow the official Flutter installation guide here.

Dart SDK: Dart is included with Flutter, so no additional installation is required. Ensure that Dart is compatible with the required version in pubspec.yaml.

2. Flutter SDK Version
   This project requires Flutter SDK >=3.2.3 <4.0.0. If your Flutter version is lower than 3.2.3, you can upgrade your Flutter installation using:

bash
Copy code
flutter upgrade
If you need to downgrade or switch to a specific version of Flutter (within the range), you can use Flutter version management tools like fvm (Flutter Version Manager) to easily switch between different versions of Flutter.

To install fvm (Flutter Version Manager):

bash
Copy code
dart pub global activate fvm
Then, use fvm to install the required version of Flutter:

bash
Copy code
fvm install 3.2.3
Once installed, you can run:

bash
Copy code
fvm use 3.2.3
3. Setting Up and Running the Project
   After ensuring your Flutter SDK is compatible, follow these steps to run the project on an Android device or emulator:

Clone the Repository:

bash
Copy code
git clone <project-repository-url>
Navigate to the Project Directory:

bash
Copy code
cd <project-directory>
Install Dependencies: Ensure all the required dependencies from pubspec.yaml are installed:

bash
Copy code
flutter pub get
Configure Firebase:

Add the google-services.json file for Android from Firebase to the android/app directory.
Follow the Firebase setup instructions as outlined in the project documentation.
Run the Project:

On an Android device or emulator:
bash
Copy code
flutter run
4. Compatibility and Supported Versions
   Dart SDK: The project supports Dart SDK versions compatible with the range specified in the pubspec.yaml file.
   Flutter SDK: The project requires Flutter SDK >=3.2.3 <4.0.0.
