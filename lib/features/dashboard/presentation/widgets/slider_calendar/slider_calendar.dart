import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_utils.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/slider_calendar/calendar_day.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SliderCalendar extends StatefulWidget {
  final void Function(DateTime value) onSelectDay;

  const SliderCalendar({
    super.key,
    required this.onSelectDay,
  });

  @override
  State<SliderCalendar> createState() => _SliderCalendarState();
}

class _SliderCalendarState extends State<SliderCalendar> {
  late DateTime _selectedDay;
  late List<DateTime> _days;
  final Axis _scrollDirection = Axis.horizontal;
  final ItemScrollController _itemScrollController = ItemScrollController();
  final DateTime _today = DateTime.now().midnightTime;

  @override
  void initState() {
    super.initState();

    _selectedDay = DateTime.now();

    _days = getDaysInBetween(
      DateUtils.dateOnly(DateTime.now().subtract(const Duration(days: 2 * 365))),
      DateUtils.dateOnly(DateTime.now().add(const Duration(days: 14))),
    );
  }

  void _scrollToIndex() {
    final int scrollIndex = _days.lastIndexWhere((e) => e.toString() == _selectedDay.midnightTime.toString());

    final int indexWithOffset = scrollIndex - 2;

    if (scrollIndex < 0) return;

    _itemScrollController.scrollTo(
      index: indexWithOffset > 0 ? indexWithOffset : scrollIndex,
      alignment: 0.07,
      duration: const Duration(milliseconds: 100),
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

    return Container(
      color: AppColors.blueRegular,
      height: 76,
      child: ScrollablePositionedList.builder(
        itemCount: _days.length,
        scrollDirection: _scrollDirection,
        itemScrollController: _itemScrollController,
        itemBuilder: (_, index) {
          final day = _days[index];
          final isSelected = day.isSameDate(_selectedDay);

          return CalendarDay(
            day: day,
            onPressHandler: onCalendarItemPressedHandler,
            isSelected: isSelected,
            isFutureDate: day.midnightTime.isAfter(_today),
          );
        },
      ),
    );
  }
}
