# LeanOnMe Application

## Getting Started

Project was set up and developed with flutter version 3.24.0 and Xcode Version 15.4 (15F31d)
We are using 100 line length in project, so before starting make sure you changed default line length in your IDE

Follow these steps to set up a project:

1. Clone project to local machine.
2. Run command `flutter pub get` to get dependencies listed in the `pubspec.yaml`.
3. Run command `flutter packages pub run build_runner build` to generate code.
4. Project contains flutter flavors, please check the documentation to get familiar with the concept [Link](https://docs.flutter.dev/deployment/flavors)
5. We have `dev`, `stag`, `uat` and `prod` flavors in the project. To run app with specified flutter flavor run `flutter run --flavor <flavor_name> --dart-define FLAVOR="<flavor_name>"`. `--dart-define FLAVOR="<flavor_name>"` used to load right env file
6. You can setup IDE to run application with the different flavors. Check the [documentation](https://loopcare.atlassian.net/wiki/spaces/LOOPCARE/pages/52035601/Getting+started)
7. To setup firebase for all environments, download `google-services.json` files for each environment, you can do it from firebase
8. Create `dev`, `stag`, `uat` and `prod` folders in `android/app/src` folder
9. Put `google-services.json` to the `android/app/src/<env_name>` (ex. `android/app/src/dev`) folder, if there is no such folder, you have to create it. Folder name should be exact as flavour name, because android by default looks to the folder with the flavour name
10. Create `config` folder in the `ios` folder, then create `dev`, `stag`, `uat` and `prod` folders in the `config` folder, so next paths should be valid `ios/config/dev` and `ios/config/prod`
11. Download firebase `GoogleService-Info.plist` files for each environment from the firebase
12. Put `GoogleService-Info.plist` to the `ios/config<env_name>` (ex. `ios/config/dev`) folder, if there is no such folder, you have to create it. Project has custom build script that will copy right plist file to the runner folder during the build process.
13. Create `.env.dev`, `.env.stag`, `.env.uat` and `.env.prod` files in the root directory. 
14. File `.env.example` contains needed variable names, copy it to the `.env.dev`, `.env.stag`, `.env.uat` and `.env.prod`.You can find env file variable values in the project [documentation](https://loopcare.atlassian.net/wiki/spaces/LOOPCARE/pages/53739539/Environment+variables). Also firebase variables you can get from the `google-services.json` and `GoogleService-Info.plist` respectively.
15. Add [keystore.properties](https://loopcare.atlassian.net/wiki/spaces/LOOPCARE/pages/285540355/Keystore.properties) into `android/` folder and [loopcare_cert.jks](https://loopcare.atlassian.net/wiki/spaces/LOOPCARE/pages/285605897/loopcare+cert.jks) into `android/app` folder.

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

### Application architecture

We follow the principles of **Domain-Driven Design**<br> in the project.

Application is separated into features. All features are in **./lib/features folder**.<br>.
And each feature separate into layers:

1. **presentation** - is all widgets and the local state of the them. It is dumbest part of the app.
2. **application** - is place for BLoC. Storing and managing state for the presentation layer.
3. **domain** - consists of:
   - Validating data and keeping it valid.
   - Transforming data
   - Models (f. e. entities `User` or `Note` entities) and failures
4. **infrastructure** - work with APIs, Firebase libraries, databases, services. Also it holds data
   transfer objects (DTOs).

### Code generation

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

### Troubleshooting

1. When run android build command you can face an error in the console `Runtime JAR files in the classpath should have the same version`
   - To fix it - move to the android folder in `cd android` and run `./gradlew` command, you can run both commands with `cd android && ./gradlew` command
   - Rerun build command

### GIT Tags

1. Update build version, push
2. git tag 1.0.30+116 afc7d988         - where “1.0.30+116” - new tag with new version, and “afc7d988" commit ID 
3. git push origin --tags                
