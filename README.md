# LeanOnMe Application

## Prerequisites - UPDATE OCT 9

1. Make sure you have Java 17
   - On Mac this version works - openjdk 17.0.12 2024-07-16
2. Make sure you have gradle version 7
   - On Mac this version works - Gradle 7.6.4

## Getting Started

Project was set up and developed with flutter version 3.24.0 and Xcode Version 15.4 (15F31d)
We are using 100 line length in project, so before starting make sure you changed default line length in your IDE

Follow these steps to set up a project:

1. Clone project to local machine.
2. Run command `flutter pub get` to get dependencies listed in the `pubspec.yaml`.
3. Run command `flutter packages pub run build_runner build` to generate code.
4. Run command `chmod +x setup.sh` to add executable permissions to the `setup.sh` file.
5. Run command `./setup.sh` to setup git hooks.
6. Project contains flutter flavors, please check the documentation to get familiar with the concept [Link](https://docs.flutter.dev/deployment/flavors)
7. We have `dev`, `stag`, `uat` and `prod` flavors in the project. To run app with specified flutter flavor run `flutter run --flavor <flavor_name> --dart-define FLAVOR="<flavor_name>"`. `--dart-define FLAVOR="<flavor_name>"` used to load right env file
8. You can setup IDE to run application with the different flavors. Check the [documentation](https://loopcare.atlassian.net/wiki/spaces/LOOPCARE/pages/52035601/Getting+started)
9. To setup firebase for all environments, download `google-services.json` files for each environment, you can do it from firebase
10. Create `dev`, `stag`, `uat` and `prod` folders in `android/app/src` folder
11. Put `google-services.json` to the `android/app/src/<env_name>` (ex. `android/app/src/dev`) folder, if there is no such folder, you have to create it. Folder name should be exact as flavour name, because android by default looks to the folder with the flavour name
12. Create `config` folder in the `ios` folder, then create `dev`, `stag`, `uat` and `prod` folders in the `config` folder, so next paths should be valid `ios/config/dev` and `ios/config/prod`
13. Download firebase `GoogleService-Info.plist` files for each environment from the firebase
14. Put `GoogleService-Info.plist` to the `ios/config<env_name>` (ex. `ios/config/dev`) folder, if there is no such folder, you have to create it. Project has custom build script that will copy right plist file to the runner folder during the build process.
15. Create `.env.dev`, `.env.stag`, `.env.uat` and `.env.prod` files in the root directory.
16. File `.env.example` contains needed variable names, copy it to the `.env.dev`, `.env.stag`, `.env.uat` and `.env.prod`.You can find env file variable values in the project [documentation](https://loopcare.atlassian.net/wiki/spaces/LOOPCARE/pages/53739539/Environment+variables). Also firebase variables you can get from the `google-services.json` and `GoogleService-Info.plist` respectively.
17. Add [keystore.properties](https://loopcare.atlassian.net/wiki/spaces/LOOPCARE/pages/285540355/Keystore.properties) into `android/` folder and [loopcare_cert.jks](https://loopcare.atlassian.net/wiki/spaces/LOOPCARE/pages/285605897/loopcare+cert.jks) into `android/app` folder.

## Extra steps - OCT 9

1. Not sure if strictly necessary but there were moans that the app folder and module name should be with underscores -> I changed this to loopcare_frontend (so both the git clone repo folder and the module references)
   - In pubspec.yaml -> name: loopcare_frontend
2. In the `google-services.json` downloaded from Firebase I had to change the package_name to `"package_name": "com.loopcare.leanonme.app.dev"` with dev at the end
3. I had to update the url_launcher_ios `flutter pub upgrade url_launcher_ios` to version 6.3.1
4. Open the android folder separately in Android Studio
   - This will enable menu Tools -> APG upgrade assistant - use version 7.4.1 of Android Gradle plugin
     - Don't update to 8.7.0
   - Make sure that in Android Studio -> Settings -> Build, Execution, Deployment -> Build Tools -> Gradle -> Android Gradle JSK is set to the Java 17 running on your machine

TODO I think we can delete windows, linux, macos, web folders. 

To run IOS/ANDROID: `flutter run --flavor <flavor_name> --dart-define FLAVOR="<flavor_name>"` then choose device and / or simulator

## Hot reloading during development

Instead of running `flutter run`, select the device you want to use and select `Flutter attach` button in top right. 
This will trigger a build, then is you save or press hot reload app refreshes. 

## Flutter inspector

1. In Android Studio click the `Flutter inspector` button in right button bar.
2. Then open in browser.

## Switching branches

I needed to run `dart run build_runner build` in project root when I switched between branches to generate specific files. Otherwise the app would not compile.

## Get firebase login token

1. Install firebase cli using `npm install -g firebase-tools`
2. Then `firebase login:ci --no-localhost` -> this will trigger a login dialog in the browser. 
3. Visit the url that is provided, go through the steps
4. Enter the code you get in the browser in the CLI
5. You get the token - you need this in the following step

## Setup fastlane

1. Install fastlane to your local machine, the simplest way to do it - homebrew command `brew install fastlane`. For another possible ways check the official installation guide [fastlane getting started](https://docs.fastlane.tools/getting-started/ios/setup/)
2. Setup environment variables. Go to `fastlane` folder in the project root directory and create files `.env.dev`, `.env.stag`, `.env.uat` and `.env.prod`.You can find env file variable values in the project [fastlane variables](https://loopcare.atlassian.net/wiki/spaces/LOOPCARE/pages/455147521/Fastlane+environment+variables). To get `FIREBASE_CLI_TOKEN` variable, you need to login to firebase account, check the [link](https://firebase.google.com/docs/cli#cli-ci-systems)
3. For testflight app distribution with script you need an App Store Connect API key [download key](https://loopcare.atlassian.net/wiki/spaces/LOOPCARE/pages/454230019/App+Store+Connect+API+key)
4. For google play store you need google developer API key [download](https://loopcare.atlassian.net/wiki/spaces/LOOPCARE/pages/463929345/Google+play+store+developer+key)
5. Put both keys to the fastlane root folder
6. You're ready to run fastlane scripts

## Setup RPS(Run Pubspec Script)

You can run fastlane deploy scripts from the `pubspec.yaml` scripts section, to do so first install rps:

1. Run `dart pub global activate rps` in the console
2. Now you can run scripts from the `pubspec.yaml`
3. Add the PATH to your .zshrc or similar so `rps` is available as a command using `export PATH="$PATH":"$HOME/.pub-cache/bin"`
4. I also had to:
   * `bundle install`
   * `bundle update fastlane`


### Supported rps scripts

- `rps firebase ios dev`
- `rps firebase ios stag`
- `rps firebase ios uat`
- `rps firebase ios prod`

- `rps firebase android dev`
- `rps firebase android stag`
- `rps firebase android uat`
- `rps firebase android prod`

- `rps testflight uat`
- `rps testflight prod`

- `rps playstore prod`

## manual deploy Android to UAT firebase
`flutter build apk --release --obfuscate --split-debug-info=debug-info --dart-define FLAVOR=uat --flavor uat`
Go to `/build/app/outputs/flutter-apk/app-{environment}-release.apk` and upload in firebase.
For UAT the link is https://console.firebase.google.com/u/0/project/leanonme-uat/appdistribution/app/android:com.loopcare.leanonme.app.uat/releases

## manual deploy iOS to firebase
`flutter build ipa --release --obfuscate --split-debug-info=debug-info --export-method ad-hoc --dart-define FLAVOR=uat --flavor uat`
Go to `/build/app/ios/ipa/LeanOnMe.ipa` and upload in firebase.
For UAT the link is https://console.firebase.google.com/u/0/project/leanonme-uat/appdistribution/app/ios:com.loopcare.leanonme.app.uat/releases


## Application architecture

Clean Architecture is a software design philosophy that aims to create systems that are scalable, maintainable, and adaptable to change. It emphasises the separation of concerns by organising code into distinct layers, each with a specific responsibility, and enforces a strict dependency rule to ensure that the core business logic remains independent of external frameworks, UI, and data sources.

In app we’re follow Flutter **clean architecture** principles and structure. Thats why each feature separated to the layers.

### 1. Presentation Layer

**Purpose**: The Presentation Layer is responsible for displaying the UI and handling user input.

**Details**: UI Components (Widgets): These interact with the BLoC to receive data to display and to send user actions.

### 2. Application Layer

**Purpose:** This layer acts as a mediator between the domain layer and the outer layers (infrastructure and presentation). It manages application-specific logic like state management and orchestration of use cases.

**Contents:** Service Classes: Application services that coordinate tasks, often invoking use cases from the domain layer.

**BLoC Interaction:** The BLoC may indirectly interact with the application layer if the BLoC needs to orchestrate several use cases or manage application-specific logic that spans multiple domain objects. However, in many implementations, the BLoC directly interacts with use cases from the domain layer.

### 3. Domain Layer

**Purpose:** The Domain Layer contains the business logic of the application, abstracted away from the details of how data is retrieved or stored.

**BLoC Interaction:** The BLoC should interact with the Domain Layer but should not reside in it.

**Details:** Entities: Core classes representing business objects.

### 4. Infrastructure Layer

**Purpose:** The Data Layer is responsible for data retrieval and persistence.

**BLoC Interaction:** The BLoC interacts indirectly with the Data Layer through the Domain Laye

**Details:** Repositories: Abstract classes (interfaces) that define data operations, implemented by concrete classes that handle the actual data source (e.g., REST APIs, databases).

**Data Sources:** Concrete classes that interact with external sources of data (e.g., API services, local databases).

### Flow Example:

**UI Event:** A user interacts with the UI (e.g., presses a button).

**BLoC:** The event is passed to the BLoC, which processes it (e.g., triggers a state change).

**Use Case:** The BLoC calls a use case in the Domain Layer to perform the necessary business logic.

**Service:** The BLoC event triggers method to fetch or save data.

**Data Source:** The service may call a data source to interact with the database or API.

**Return Data:** Data flows back through the service, and finally to the BLoC.

**State Update:** The BLoC emits a new state, which the UI listens to and updates accordingly.

## Local plugins

We are using two packages as a local plugins, they are placed under the `local_plugins` folder in the root directory.

1. `zoom_video_sdk_update` - zoom doesn't have official package on the pub get, so the only case is to download from the admin panel.
2. `advertising_id` - ios version has conflicts if use throught the pub get

## Code generation

`flutter packages pub run build_runner build` - if you want the generator to run one time

`flutter packages pub run build_runner watch` - Use the [watch] flag to watch the files' system for
edits and rebuild as necessary

### Navigation

We are using the package [auto_route](https://pub.dev/packages/auto_route).

### Localization

We are using the package [easy_localization](https://pub.dev/packages/easy_localization).

To add new language:

1. Add file with new language to `assets/translations` with such format `{languageCode}.{ext}`
2. Add new languageCode in the `CFBundleLocalizations` in the `ios/Runner/Info.plist` file
3. Add new supported locale in the `lib/core/presentation/localization/localization_constants.dart`
   file

To generate localizations `flutter gen-l10n`.

## Troubleshooting

1. When run android build command you can face an error in the console `Runtime JAR files in the classpath should have the same version`
   - To fix it - move to the android folder in `cd android` and run `./gradlew` command, you can run both commands with `cd android && ./gradlew` command
   - Rerun build command

## GIT Tags

1. Update build version, push
2. git tag 1.0.30+116 afc7d988 - where “1.0.30+116” - new tag with new version, and “afc7d988" commit ID
3. git push origin --tags
