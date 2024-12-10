bool get kIsDev => EnvironmentType.currentType.isDev;

bool get kIsProd => EnvironmentType.currentType.isProd;

bool get kIsStag => EnvironmentType.currentType.isStag;

const String _kRawBuildType = String.fromEnvironment('FLAVOR', defaultValue: 'dev');

enum BuildType {
  prod,
  stag,
  uat,
  dev;

  const BuildType();

  bool get isDev => this == dev;

  bool get isProd => this == prod;

  bool get isStag => this == stag;
}

class EnvironmentType {
  static BuildType _buildTypeFromEnv() => BuildType.values.byName(_kRawBuildType);

  static BuildType currentType = _buildTypeFromEnv();
}
