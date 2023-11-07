import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';

import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/slider_calendar/week_slider_calendar.dart';
import 'package:loopcare_frontend/features/nutrition/application/choose_date/choose_date_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/week_planner/widgets/week_planner_carousel.dart';

class WeekPlannerPage extends StatefulWidget {
  const WeekPlannerPage({
    Key? key,
  }) : super(key: key);

  @override
  State<WeekPlannerPage> createState() => _WeekPlannerPageState();
}

class _WeekPlannerPageState extends State<WeekPlannerPage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _originSelectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();

    _originSelectedDay = context.read<MealsBloc>().state.getCurrentDate;

    _onSelectDay(DateTime.now());
  }

  String? _appBarSubtitle(BuildContext context) {
    final state = context.read<MealsBloc>().state;

    return state.getCurrentDate.isoStringWithoutTime != DateTime.now().isoStringWithoutTime
        ? null
        : state.getCurrentDate.shortDate;
  }

  void _onSelectDay(DateTime day) {
    setState(() {
      _selectedDay = day;
      context.read<ChooseDateBloc>().add(
            ChooseDateEvent.getPlannedMeals(
              _selectedDay,
              _selectedDay.add(const Duration(days: 15)),
            ),
          );
    });
  }

  void _onClose() {
    final mealBloc = context.read<MealsBloc>();
    mealBloc.add(MealsEvent.setCurrentDate(_originSelectedDay));

    context.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppBar(
        isCustomLeading: false,
        isPlanningMeals: true,
        title: LocalizedTexts.planYourMeals.translation,
        subtitle: _appBarSubtitle(context),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: _onClose,
              icon: const Icon(
                Icons.close,
                color: AppColors.white,
                size: 28.0,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            WeekSliderCalendar(onSelectDay: _onSelectDay),
            const SizedBox(height: 28.0),
            const Expanded(
              child: WeekPlannerCarousel(),
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
