import 'dart:io' show Platform;
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/measurement_system_type.dart';

MeasurementSystemType getMeasurementSystem() {
  final localeName = Platform.localeName;
  final countryCode = localeName.split('_')[1];
  final imperialCountryCodes = ['US', 'LR', 'MM'];

  if (imperialCountryCodes.contains(countryCode)) {
    return MeasurementSystemType.imperial;
  }

  return MeasurementSystemType.metric;
}
