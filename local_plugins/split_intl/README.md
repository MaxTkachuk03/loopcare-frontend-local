## About

When following the [guide on flutter.dev](https://docs.flutter.dev/accessibility-and-localization/internationalization#adding-your-own-localized-messages) on how to add your own custom localization to your app you are introduced to the [intl package](https://pub.dev/packages/intl). This package requires you to create a configuration file in your projects root directory, called `l10n.yaml`. Typically this configuration file looks like this:

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
```

This essentially tells the generator to look for localization files in the directory `lib/l10n`, and that the template file is called `app_en.arb` (see ["Configuring the l10n.yaml file"](https://docs.flutter.dev/accessibility-and-localization/internationalization#configuring-the-l10nyaml-file) for more info). Therefore the generator will look for `lib/l10n/app_en.arb` and generate a dart file called `app_localizations.dart` based on the values specified in your template arb file. By adding more files with different language codes (the 2 characters at the end of the name of an arb file) in `lib/l10n` you can add more localizations to your app, like `app_de.arb` for german.

But by using this pattern you will quickly realise, that putting all your localizations for a language into a single file decreases the readability of said file immensely. Also the inability to add comments to `.arb` or `.json` files is not necessarily helpful.

Now that is where `split_intl` comes in. `split_intl` allows you to
  
  * split a single `.arb` file into multiple `.arb`, `.json` or `.jsonc` files
  
  * add comments to your localization files (by using the `.jsonc` format) 

## How to use split_intl

Without `split_intl` your projects structure would look something like this

```
📦my_localized_flutter_app
 ┣ 📂lib
 ┃ ┣ 📂l10n
 ┃ ┃ ┗ 📜app_en.arb
 ┃ ┗ 📜main.dart
 ┣ 📂linux
 ┣ 📂test
 ┣ 📂windows
 ┣ 📜.gitignore
 ┣ 📜.metadata
 ┣ 📜analysis_options.yaml
 ┣ 📜l10n.yaml
 ┣ 📜pubspec.lock
 ┗ 📜pubspec.yaml
```

and the contents of `lib/l10n/app_en.arb` would look like this

```json
{
  "appTitle": "The best app",
  "@appTitle": {
    "description": "The title of the application."
  },
  "fieldRequired": "required",
  "@fieldRequired": {
    "description": "The message for a field that requires user input (cannot be empty)."
  },
  "inputFormOptionsPageTitle": "Add",
  "@inputFormOptionsPageTitle": {
    "description": "The title for the OptionsPage in the InputFormView widget."
  },
  "inputFormPanelPageTitle": "Input values",
  "@inputFormPanelPageTitle": {
    "description": "The title for the PanelPage in the InputFormView widget."
  }
}
```

but by using `split_intl` you can change the structure to look like this

```
📦my_localized_flutter_app
 ┣ 📂lib
 ┃ ┣ 📂l10n
 ┃ ┃ ┗ 📂en
 ┃ ┃   ┃ general.arb
 ┃ ┃   ┗ input_form_panel.jsonc
 ┃ ┗ 📜main.dart
 ┣ 📂linux
 ┣ 📂test
 ┣ 📂windows
 ┣ 📜.gitignore
 ┣ 📜.metadata
 ┣ 📜analysis_options.yaml
 ┣ 📜l10n.yaml
 ┣ 📜pubspec.lock
 ┗ 📜pubspec.yaml
```

`lib/l10n/en/general.arb`:

```json
{
  "appTitle": "The best app",
  "@appTitle": {
    "description": "The title of the application."
  },
  "fieldRequired": "required",
  "@fieldRequired": {
    "description": "The message for a field that requires user input (cannot be empty)."
  }
```

`lib/l10n/en/input_form_view.jsonc`:

```json
{
  // All values in this file are used by the InputFormView widget
  "inputFormOptionsPageTitle": "Add",
  "@inputFormOptionsPageTitle": {
    "description": "The title for the OptionsPage in the InputFormView widget."
  },
  /*
    I like block comments
  */
  "inputFormPanelPageTitle": "Input values",
  "@inputFormPanelPageTitle": {
    "description": "The title for the PanelPage in the InputFormView widget."
  }
  /**
   * I really do like them
   */
```

`split_intl` just takes all files in `lib/l10n/en` and contatenates the content of each `.arb`, `.json` or `.jsonc` file together and removes all comments. To add more languages, simply add a new directory with the language code as its name, like `lib/l10n/de`. The generated files will be outputed into `lib/l10n`, for example `lib/l10n/en` -> `lib/l10n/app_en.arb`. To to that you simply need to run

  ```
  flutter pub run split_intl:generate
  ```

This command generates the `lib/l10n/app_en.arb` file, which can be used by

  ```
  flutter gen-l10n
  ```

to generate the dart source files.