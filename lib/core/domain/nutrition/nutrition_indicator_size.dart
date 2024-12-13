enum NutritionIndicatorSize {
  big(1, 'Big'),
  small(2, 'Small');

  final int number;
  final String value;

  const NutritionIndicatorSize(this.number, this.value);

  double get width {
    switch (value) {
      case 'Big':
        return 90.0;
      case 'Small':
        return 50.0;
      default:
        return 50.0;
    }
  }

  double get borderThickness {
    switch (value) {
      case 'Big':
        return 12.0;
      case 'Small':
        return 6.0;
      default:
        return 6.0;
    }
  }
}
