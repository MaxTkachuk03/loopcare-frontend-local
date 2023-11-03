enum MoodScale {
  happy(5, 'HAPPY'),
  joy(4, 'JOY'),
  neutral(3, 'NEUTRAL'),
  sad(2, 'SAD'),
  angry(1, 'ANGRY');

  const MoodScale(this.number, this.value);

  final int number;
  final String value;
}
