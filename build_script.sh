#!/bin/bash

if [ "$1" == "prod" ]; then
  build_type="prod"
else
  build_type="dev"
fi

if [ "$2" == "ios" ]; then
  flutter build ipa --release --export-method ad-hoc --dart-define FLAVOR=$build_type --flavor $build_type
else
  flutter build apk --release --dart-define FLAVOR=$build_type --flavor $build_type
fi


