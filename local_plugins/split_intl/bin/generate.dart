import "dart:convert";
import "dart:io";

import "package:dartx/dartx.dart";
import "package:path/path.dart" as path;
import "package:split_intl/split_intl.dart";

const encoder = JsonEncoder.withIndent("  ");
const allowedFileExtensions = [".arb", ".json", ".jsonc"];

void main(List<String> args) {
  initialize();

  final config = readConfig();

  final subdirs = Directory(config.arbDir)
      .listSync()
      .where((e) => FileSystemEntityType.directory == e.statSync().type)
      .cast<Directory>()
      // language codes contain only 2 characters
      .where((e) => 2 == path.basename(e.path).length)
      .toList(growable: false);

  // Check if subdirs actually contains a dir for config.templateArbFile
  var containsDirForTemplateArbFile = false;
  for (final dirname in subdirs.map((e) => path.basename(e.path))) {
    if (config.templateArbFileLangCode == dirname) {
      containsDirForTemplateArbFile = true;
      break;
    }
  }
  if (!containsDirForTemplateArbFile)
    throw Exception(
      "There is no directory that can be used to generate the "
      "template arb file.\n"
      "template arb filename: ${config.templateArbFile}\n"
      "directories: ${subdirs.join(",")}",
    );

  // contatenate the files of each dir into a single one
  for (final dir in subdirs) {
    final jsonFiles = dir
        .listSync(recursive: true)
        .where((e) => FileSystemEntityType.file == e.statSync().type)
        .cast<File>()
        .where((e) {
      var ext = path.extension(e.path);

      // The path library interprets files without a name like ".json"
      // as if they do not have an extension, but their basename is ".json".
      if (ext.isEmpty) {
        ext = path.basename(e.path);
      }

      return allowedFileExtensions.contains(ext);
    });

    final map = <String, Object?>{};
    for (var i = 0; i < jsonFiles.length; i++) {
      final file = jsonFiles.elementAt(i);

      final lines = file
          .readAsLinesSync()
          // Remove whitespaces at the start of each line.
          .map((e) => e.trimLeft())
          .toList();

      // A valid line in JSON can only start with the following characters:
      //  - "
      //  - {
      //  - }
      lines.removeWhere((e) => !e.startsWith(RegExp('(")|({)|(})')));

      var json = jsonDecode(lines.join()) as Map<String, Object?>;

      // The path library interprets files without a name like ".json"
      // as if they do not have an extension, but their basename is ".json".
      final hasExtension = path.extension(file.path).isNotEmpty;

      // Get relative filepath form arbDir.
      // we need to remove the arbDir path and the langcode (2 chars) plus
      // the last path seperator (1 char).
      final relFilepath =
          (hasExtension ? file : file.parent).path.substring(config.arbDir.length + 3);
      var prefix = path
          .withoutExtension(relFilepath)
          .split(path.separator)
          .map((e) => e.snakeToCamel())
          .join();
      // ignore: use_string_buffers
      prefix = prefix;

      // Modify key names
      json = json.map((key, value) {
        if (key.startsWith("@@")) {
          return MapEntry("@${key.substring(1)}", value);
        }
        var arg = key;
        if (prefix.isNotEmpty && key.startsWith('@')) {
          arg = '@$prefix${key.substring(1).capitalize()}';
        } else if (prefix.isNotEmpty && !key.startsWith('@')) {
          arg = '$prefix${key.capitalize()}';
        }

        return MapEntry(arg, value);
      });

      map.addAll(json);
    }

    // Create an arb file containing the contents of all files
    // from dir.
    final langCode = path.basename(dir.path);
    final arbFile = File(config.getArbFilepath(langCode));
    arbFile.writeAsStringSync(
      encoder.convert(map),
      mode: FileMode.writeOnly,
    );
  }
}
