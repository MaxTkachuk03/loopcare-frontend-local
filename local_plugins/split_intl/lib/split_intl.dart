library split_intl;

import "dart:io";

import "package:dartx/dartx.dart";
import "package:equatable/equatable.dart";
import "package:meta/meta.dart";
import "package:path/path.dart" as path;
import "package:yaml/yaml.dart";

part "src/config.dart";
part "src/extensions.dart";

void initialize() {
  EquatableConfig.stringify = true;
}
