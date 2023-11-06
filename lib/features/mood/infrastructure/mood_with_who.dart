enum MoodWithWho {
  alone(6, 'Alone'),
  partner(5, 'Partner'),
  friend(4, 'Friend(s)'),
  family(3, 'Family'),
  colleagues(2, 'Colleagues'),
  child(1, 'Child(ren)');

  const MoodWithWho(this.number, this.value);

  static MoodWithWho getValueByString(String val) => values.firstWhere((e) => e.value == val);

  final int number;
  final String value;
}
