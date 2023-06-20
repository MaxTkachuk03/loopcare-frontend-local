import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/dashboard/application/physical_activities_bloc.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/diary/diary.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/education/education.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/log_meal/log_meal.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/physical_activities/physical_activities.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/plan_meal/plan_meal.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/reflection/reflection.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/slider_calendar/slider_calendar.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/support_group.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/weight/weight_block.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_education/dashboard_education_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dashboard_weight_bloc.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/injection.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final bool _isMealBlockEditable;
  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    _isMealBlockEditable = false;

    context.read<NutritionInstructionsBloc>().add(const NutritionInstructionsEvent.fetchValuesExplanation());

    context
        .read<DashboardWeightBloc>()
        .add(DashboardWeightEvent.fetchWeights(_selectedDay.midnightTime.subtract(const Duration(days: 8))));

    context.read<MealsBloc>().add(const MealsEvent.fetchMeals());

    context.read<DashboardEducationBloc>().add(const DashboardEducationEvent.getDashboardLessons());

    super.initState();
  }

  void _onDaySelected(DateTime day) {
    setState(() {
      _selectedDay = day;
      context.read<DashboardWeightBloc>().add(DashboardWeightEvent.setDate(day));
      context.read<MealsBloc>().add(MealsEvent.setCurrentDate(day));
      context
          .read<DashboardEducationBloc>()
          .add(DashboardEducationEvent.getDashboardLessons(currentDate: day));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AppImages.dashboardBg,
            fit: BoxFit.contain,
          ),
        ),
        child: Column(
          children: [
            SliderCalendar(onSelectDay: _onDaySelected),
            Expanded(
              child: ScrollableContainer(
                child: MainContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 28),
                      BlocBuilder<AuthenticationCubit, AuthenticationState>(
                        builder: (BuildContext context, state) {
                          return Text(
                            '${LocalizedTexts.goodMorning.translation} ${state.name}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          );
                        },
                      ),
                      const SizedBox(height: 16.0),
                      WeightBlock(date: _selectedDay),
                      const SizedBox(height: 10.0),
                      BlocBuilder<MealsBloc, MealsState>(
                        builder: (BuildContext context, state) {
                          return state.isNeedToHideOnDashboard
                              ? const SizedBox(height: 0.0)
                              : const LogMeal();
                        },
                      ),
                      const SizedBox(height: 10.0),
                      PlanMeal(isEditable: _isMealBlockEditable),
                      const SizedBox(height: 10.0),
                      Diary(isEditable: _isMealBlockEditable),
                      const SizedBox(height: 16.0),
                      Text(
                        LocalizedTexts.activities.translation,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16.0),
                      Reflection(isEditable: _isMealBlockEditable),
                      const SizedBox(height: 10.0),
                      BlocProvider<PhysicalActivitiesBloc>(
                        create: (_) => getIt<PhysicalActivitiesBloc>(),
                        child: PhysicalActivities(selectedDay: _selectedDay),
                      ),
                      const SizedBox(height: 10.0),
                      SupportGroup(isEditable: _isMealBlockEditable),
                      const SizedBox(height: 10.0),
                      BlocBuilder<DashboardEducationBloc, DashboardEducationState>(
                        builder: (BuildContext context, state) {
                          return state.isVisibleOnDashboard(_selectedDay)
                              ? Education(
                                  date: _selectedDay,
                                )
                              : const SizedBox(height: 0.0);
                        },
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
