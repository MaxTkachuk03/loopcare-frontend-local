#!/bin/bash

if [ "$1" == "prod" ]; then
  build_type="prod"
elif [ "$1" == "stag" ]; then
  build_type="stag"
else
  build_type="dev"
fi

if [ "$2" == "ios" ]; then
  flutter build ipa --release --obfuscate --split-debug-info=debug-info --export-method ad-hoc --dart-define FLAVOR=$build_type --flavor $build_type
else
  flutter build apk --release --obfuscate --split-debug-info=debug-info --dart-define FLAVOR=$build_type --flavor $build_type
fi


