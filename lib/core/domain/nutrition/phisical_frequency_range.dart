class PhysicalFrequencyRange {
  final int min;
  final int max;

  const PhysicalFrequencyRange.light()
      : min = 1,
        max = 3;

  const PhysicalFrequencyRange.moderate()
      : min = 4,
        max = 5;

  const PhysicalFrequencyRange.heavy()
      : min = 6,
        max = 7;
}
