import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/domain/slider_calendar/week_element.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/slider_calendar/calendar_week.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/date_time_utils.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class WeekSliderCalendar extends StatefulWidget {
  final void Function(DateTime value) onSelectDay;

  const WeekSliderCalendar({
    Key? key,
    required this.onSelectDay,
  }) : super(key: key);

  @override
  State<WeekSliderCalendar> createState() => _WeekSliderCalendarState();
}

class _WeekSliderCalendarState extends State<WeekSliderCalendar> {
  late DateTime _selectedDay;
  late List<WeekElement> _weeks;
  final Axis _scrollDirection = Axis.horizontal;
  final ItemScrollController _itemScrollController = ItemScrollController();
  final DateTime _today = DateTime.now().midnightTime;

  @override
  void initState() {
    super.initState();

    _weeks = getWeeksElementBeteween(
      DateUtils.dateOnly(DateTime.now().subtract(const Duration(days: 2 * 365))),
      DateUtils.dateOnly(DateTime.now().add(const Duration(days: 13))),
    );

    _selectedDay = DateTime.now();
  }

  void _scrollToIndex() {
    final int scrollIndex =
        _weeks.lastIndexWhere((e) => e.startDate.isSameDate(_selectedDay.firstDayOfCurrentWeek));

    final int indexWithOffset = scrollIndex - 2;

    if (scrollIndex < 0) return;

    _itemScrollController.scrollTo(
      index: indexWithOffset > 0 ? indexWithOffset : scrollIndex,
      alignment: 0.07,
      duration: const Duration(milliseconds: 100),
    );
  }

  void onCalendarItemPressedHandler(DateTime date) {
    setState(() {
      _selectedDay = date;
      widget.onSelectDay(date);
      _scrollToIndex();
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      _scrollToIndex();
    });

    return SizedBox(
      height: 70,
      child: ScrollablePositionedList.builder(
        itemCount: _weeks.length,
        scrollDirection: _scrollDirection,
        itemScrollController: _itemScrollController,
        itemBuilder: (_, index) {
          final week = _weeks[index];
          final isSelected = week.startDate.isSameDate(_selectedDay.firstDayOfCurrentWeek);

          return CalendarWeek(
            weekNumber: week.weekNumber.toString(),
            fromDate: week.startDate.dayInMonth,
            toDate: week.endDate.dayInMonth,
            month: week.endDate.shortMonthString,
            date: week.startDate,
            onPressHandler: onCalendarItemPressedHandler,
            isSelected: isSelected,
            isFutureDate: week.startDate.isAfter(_today.firstDayOfCurrentWeek),
          );
        },
      ),
    );
  }
}
