enum MoodWhere {
  work(9, 'Work'),
  home(8, 'Home'),
  study(7, 'Study'),
  traveling(6, 'Traveling'),
  onHoliday(5, 'On holiday'),
  party(4, 'Party'),
  inTown(3, 'In town'),
  physicalActivity(2, 'Physical Activity'),
  socialMedia(1, '(Social) Media'),
  relaxing(10, 'Relaxing');

  const MoodWhere(this.number, this.value);

  static MoodWhere getValueByString(String val) => values.firstWhere((e) => e.value == val);

  final int number;
  final String value;
}
