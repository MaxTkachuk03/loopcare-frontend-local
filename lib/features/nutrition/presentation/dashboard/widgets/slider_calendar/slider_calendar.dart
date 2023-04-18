import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/slider_calendar/calendar_day.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/date_time_utils.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SliderCalendar extends StatefulWidget {
  final void Function(DateTime value) onSelectDay;

  const SliderCalendar({
    Key? key,
    required this.onSelectDay,
  }) : super(key: key);

  @override
  State<SliderCalendar> createState() => _SliderCalendarState();
}

class _SliderCalendarState extends State<SliderCalendar> {
  late DateTime _selectedDay;
  late List<DateTime> _days;
  final scrollDirection = Axis.horizontal;
  final ItemScrollController _itemScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();

    _selectedDay = DateTime.now();

    _days = getDaysInBeteween(
      DateTime.now().subtract(const Duration(days: 100 * 365)),
      DateTime.now().add(const Duration(days: 14)),
    );
  }

  void _scrollToIndex() {
    var scrollIndex = _days.indexOf(DateUtils.dateOnly(_selectedDay)) - 2;
    if (scrollIndex < 0) scrollIndex = 0;
    _itemScrollController.jumpTo(
      index: scrollIndex,
      alignment: 0.07,
    );
  }

  void onCalendarItemPressedHandler(DateTime day) {
    setState(() {
      _selectedDay = day;
      widget.onSelectDay(day);
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
        itemCount: _days.length,
        scrollDirection: scrollDirection,
        itemScrollController: _itemScrollController,
        itemBuilder: (_, index) {
          final day = _days[index];
          final isSelected = day.isSameDate(_selectedDay);

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
