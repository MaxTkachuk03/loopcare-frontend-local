import 'package:flutter_dotenv/flutter_dotenv.dart';

bool get kIsDev => EnvironmentType.currentType.isDev;

bool get kIsProd => EnvironmentType.currentType.isProd;

bool get kIsAnalyticTestingEnv => bool.parse(dotenv.env['ANALYTIC_TESTING_ENV'] as String);

const String _kRawBuildType = String.fromEnvironment('FLAVOR', defaultValue: 'dev');

enum BuildType {
  prod,
  stag,
  uat,
  dev;

  const BuildType();

  bool get isDev => this == dev;

  bool get isProd => this == prod;
}

class EnvironmentType {
  static BuildType _buildTypeFromEnv() => BuildType.values.byName(_kRawBuildType);

  static BuildType currentType = _buildTypeFromEnv();
}
