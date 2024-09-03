#!/bin/bash

set -e

# Define valid build types and platforms
valid_build_types=("prod" "stag" "uat" "dev")
valid_platforms=("ios" "android")

# Function to display usage
usage() {
    echo "Usage: $0 <build_type> <platform>"
    echo "Valid build types: ${valid_build_types[*]}"
    echo "Valid platforms: ${valid_platforms[*]}"
    exit 1
}

# Validate input parameters
if [ $# -ne 2 ]; then
    echo "Error: Exactly two arguments are required."
    usage
fi

build_type="$1"
platform="$2"

# Validate build type
# shellcheck disable=SC2076
if ! [[ " ${valid_build_types[*]} " =~ " ${build_type} " ]]; then
    echo "Error: Invalid build type: $build_type"
    usage
fi

# Validate platform
# shellcheck disable=SC2076
if ! [[ " ${valid_platforms[*]} " =~ " ${platform} " ]]; then
    echo "Error: Invalid platform: $platform"
    usage
fi

# Common build options
build_options="--release --obfuscate --split-debug-info=debug-info --dart-define FLAVOR=$build_type --flavor $build_type"

# Build command based on platform and build type
case "$platform" in
    "ios")
        echo "Building iOS app..."
        flutter build ipa $build_options --export-method ad-hoc
        ;;
    "android")
        if [ "$build_type" == "prod" ]; then
            echo "Building Android app bundle..."
            flutter build appbundle $build_options
        else
            echo "Building Android APK..."
            flutter build apk $build_options
        fi
        ;;
    *)
        echo "Error: Invalid platform and build type combination"
        usage
        ;;
esac

echo "Build completed for $platform with build type $build_type"

