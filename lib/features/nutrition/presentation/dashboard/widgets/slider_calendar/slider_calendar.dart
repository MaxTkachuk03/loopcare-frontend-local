import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/slider_calendar/calendar_day.dart';

class Day {
  final String name;
  final String number;
  final String month;
  Day({required this.name, required this.number, required this.month});
}

final days = [
  Day(name: 'Mon', number: '1', month: 'Feb'),
  Day(name: 'Tues', number: '2', month: 'Feb'),
  Day(name: 'Wed', number: '3', month: 'Feb'),
  Day(name: 'Thurs', number: '4', month: 'Feb'),
  Day(name: 'Fri', number: '5', month: 'Feb'),
  Day(name: 'Sat', number: '6', month: 'Feb'),
  Day(name: 'Sun', number: '7', month: 'Feb'),
  Day(name: 'Mon', number: '8', month: 'Feb'),
  Day(name: 'Tues', number: '9', month: 'Feb'),
  Day(name: 'Wed', number: '10', month: 'Feb'),
  Day(name: 'Thurs', number: '11', month: 'Feb'),
  Day(name: 'Fri', number: '12', month: 'Feb'),
  Day(name: 'Sat', number: '13', month: 'Feb'),
  Day(name: 'Sun', number: '14', month: 'Feb'),
  Day(name: 'Mon', number: '15', month: 'Feb'),
  Day(name: 'Tues', number: '16', month: 'Feb'),
  Day(name: 'Wed', number: '17', month: 'Feb'),
  Day(name: 'Thurs', number: '18', month: 'Feb'),
  Day(name: 'Fri', number: '19', month: 'Feb'),
  Day(name: 'Sat', number: '20', month: 'Feb'),
  Day(name: 'Sun', number: '21', month: 'Feb'),
];

class SliderCalendar extends StatefulWidget {
  // TODO params
  // final range;
  const SliderCalendar({Key? key}) : super(key: key);

  @override
  State<SliderCalendar> createState() => _SliderCalendarState();
}

class _SliderCalendarState extends State<SliderCalendar> {
  late Day _selectedDay;

  @override
  void initState() {
    _selectedDay = Day(name: "Mon", number: '1', month: "Sep");

    super.initState();
  }

  void onCalendarItemPressedHandler(Day day) {
    // TODO get data for selected day from the server
    setState(() {
      _selectedDay = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        itemCount: days.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          final day = days[index];
          final isSelected = day == _selectedDay;

          return CalendarDay(
            day: day,
            onPressHandler: onCalendarItemPressedHandler,
            isSelected: isSelected,
          );
        },
      ),
    );
  }
}
