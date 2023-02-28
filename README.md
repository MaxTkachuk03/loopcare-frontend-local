# LeanOnMe Application


## Getting Started

Project was setted up and developed with flutter version 3.3.10

Follow these steps to set up a project:

1. Clone project to local machine.
2. Run command `flutter pub get` to get dependencies listed in the `pubspec.yaml`.
3. Run command `flutter packages pub run build_runner build` to generate code.
4. Project contains flutter flavors, please check the documentation to get familiar with the concept [Link](https://docs.flutter.dev/deployment/flavors)
5. We have `dev` and `prod` flavors in the project. To run app with specified flutter flavor run `flutter run --flavor <flavor_name> --dart-define FLAVOR="<flavor_name>"`. `--dart-define FLAVOR="<flavor_name>"` used to load right env file
6. You can setup IDE to run application with the different flavors. Check the [documentation](https://loopcare.atlassian.net/wiki/spaces/LOOPCARE/pages/52035601/Getting+started)
7. To setup firebase for all environments, download `google-services.json` files for each environment, you can do it from firebase
8. Create `dev` and `prod` folders in `android/app/src` folder
9. Put `google-services.json` to the `android/app/src/<env_name>` (ex. `android/app/src/dev`) folder, if there is no such folder, you have to create it. Folder name should be exact as flavour name, because android by default looks to the folder with the flavour name
10. Create `config` folder in the `ios` folder, then create `dev` and `prod` folders in the `config` folder, so next pathes should be valid `ios/config/dev` and `ios/config/prod`
11. Download firebase `GoogleService-Info.plist` files for each environment from the firebase
12. Put `GoogleService-Info.plist` to the `ios/config<env_name>` (ex. `ios/config/dev`) folder, if there is no such folder, you have to create it. Project has custom build script that will copy right plist file to the runner folder during the build process.
13. Create `.env.dev` and `.env.prod` files in the root directory.
14. File `.env.example` contains needed variable names, copy it to the `.env.dev` and `.env.prod`.You can find env file variable values in the project documentation. Also firebase variables you can get from the `google-services.json` and `GoogleService-Info.plist` respectevly

## Application development

### Application architecture

We follow the principles of **Domain-Driven Design**<br> in the project.

Application is separated into features. All features are in **./lib/features folder**.<br>.
And each feature separate into layers:

1. **presentation** - is all widgets and the local state of the them. It is dumbest part of the app.
2. **application** - is place for BLoC. Storing and managing state for the presentation layer.
3. **domain** - consists of:
   3.1 Validating data and keeping it valid.
   3.2 Transforming data
   3.3 Models (f. e. entities `User` or `Note` entities) and failures
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
