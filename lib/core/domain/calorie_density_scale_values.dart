class Range {
  final double min;
  final double max;

  Range({required this.min, required this.max});
}

final List<Range> calorieDensityScaleValues = [
  Range(min: 0, max: 0.99),
  Range(min: 1, max: 1.29),
  Range(min: 1.3, max: 1.49),
  Range(min: 1.5, max: 1.649),
  Range(min: 1.65, max: 1.749),
  Range(min: 1.75, max: 1.90),
  Range(min: 1.90, max: 2.10),
  Range(min: 2.10, max: 2.30),
  Range(min: 2.30, max: 2.60),
  Range(min: 2.60, max: 2.61),
];
