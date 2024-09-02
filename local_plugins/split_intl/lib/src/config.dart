// ignore_for_file: avoid_dynamic_calls

part of "../split_intl.dart";

@immutable
class IntlConfig extends Equatable {
  const IntlConfig({
    required this.arbDir,
    required this.templateArbFile,
  });

  final String arbDir;
  final String templateArbFile;

  @override
  List<Object?> get props => [arbDir, templateArbFile];

  /// Get only the language code from [templateArbFile].
  ///
  /// If [templateArbFile] is `"app_en.arb"`, then this
  /// getter returns `"en"`.
  String get templateArbFileLangCode {
    final str = templateArbFile.substring(
      templateArbFile.length - "xx.arb".length,
    );
    return str.substring(0, 2);
  }

  /// Get only the name of [templateArbFile], without
  /// the language code.
  ///
  /// If [templateArbFile] is `"app_en.arb"`, then this
  /// getter returns `"app_"`.
  String get templateArbFileWithoutLangCode {
    final str = path.basename(templateArbFile);
    return str.substring(0, str.length - "xx.arb".length);
  }

  String getArbFilepath(String languageCode) {
    assert(2 == languageCode.length);
    final filename = "$templateArbFileWithoutLangCode$languageCode.arb";
    return path.join(arbDir, filename);
  }
}

/// Read the projects [localization configurations](https://docs.flutter.dev/accessibility-and-localization/internationalization#configuring-the-l10nyaml-file).
IntlConfig readConfig() {
  // Configurations are always stored in a file called "l10n.yaml" in
  // the current project directory.
  // See:
  // https://docs.flutter.dev/accessibility-and-localization/internationalization#configuring-the-l10nyaml-file
  const configFilepath = "l10n.yaml";

  final yaml = loadYaml(File(configFilepath).readAsStringSync());

  return IntlConfig(
    arbDir: yaml["arb-dir"],
    templateArbFile: yaml["template-arb-file"],
  );
}
