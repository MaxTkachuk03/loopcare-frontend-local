enum MeasurementSystemType {
  metric,
  imperial,
}

extension MeasurementSystemTypeExtension on MeasurementSystemType? {
  bool get isMetric => this == MeasurementSystemType.metric;
}
