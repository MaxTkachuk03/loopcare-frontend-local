class DateHelpers {
  static int calculateAge(DateTime birthday) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthday.year;
    int month1 = currentDate.month;
    int month2 = birthday.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthday.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  DateHelpers._();
}
