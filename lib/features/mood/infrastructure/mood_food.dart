enum MoodFood {
  healthyEating(1, 'Healthy Eating'),
  unhealthyFood(2, 'Unhealthy food');

  const MoodFood(this.number, this.value);

  static MoodFood getValueByString(String val) => values.firstWhere((e) => e.value == val);

  final int number;
  final String value;
}
