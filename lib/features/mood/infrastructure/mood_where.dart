enum MoodWhere {
  work(9, 'Work'),
  home(8, 'Home'),
  study(7, 'Study'),
  onHoliday(6, 'On holiday'),
  party(5, 'Party'),
  inTown(4, 'In town'),
  physicalActivity(3, 'Physical Activity'),
  socialMedia(2, '(Social) Media'),
  relaxing(1, 'Relaxing');

  const MoodWhere(this.number, this.value);

  static MoodWhere getValueByString(String val) => values.firstWhere((e) => e.value == val);

  final int number;
  final String value;
}
