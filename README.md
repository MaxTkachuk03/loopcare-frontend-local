# LoopCare Application

A new Flutter project.

## Getting Started

Follow these steps to set up a project:

1. Clone project to local machine.
2. Run the command `flutter pub get` to gets all the dependencies listed in the `pubspec.yaml`.
3. Run the command `flutter packages pub run build_runner build` to generate code.
4. Run the command `flutter run` or press Run button in the IDE.

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