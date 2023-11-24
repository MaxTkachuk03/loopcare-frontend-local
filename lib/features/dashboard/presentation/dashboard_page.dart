import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/education/education.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/log_meal/log_meal.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/person_mood/person_mood.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/physical_activities/physical_activities.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/plan_meal/plan_meal.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/slider_calendar/slider_calendar.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/support_group.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/weight/weight_block.dart';
import 'package:loopcare_frontend/features/education/application/education_program/education_program_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/lesson_category.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/features/mood/application/mood_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_education/dashboard_education_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dashboard_weight_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with WidgetsBindingObserver {
  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    _loadInitialData();

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      context.read<TopicsBloc>().add(const TopicsEvent.fetchTopics());
    }
  }

  void _loadInitialData() {
    context.read<AuthenticationCubit>().getAccount();

    if (!context.read<NutritionInstructionsBloc>().state.data.alreadyLoaded) {
      context
          .read<NutritionInstructionsBloc>()
          .add(const NutritionInstructionsEvent.fetchValuesExplanation());
    }

    context
        .read<DashboardWeightBloc>()
        .add(DashboardWeightEvent.fetchWeights(_selectedDay.utsIsoStringWeekBeforeDateWithMidnightTime));

    context.read<MoodBloc>().add(MoodEvent.getMoods(
        _selectedDay.utsIsoStringWeekBeforeDateWithMidnightTime, DateTime.now().utcIsoStringFormat));

    context
        .read<DashboardEducationBloc>()
        .add(DashboardEducationEvent.getDashboardLessons(currentDate: _selectedDay));

    context.read<EducationProgramBloc>().add(const EducationProgramEvent.getLessons(LessonCategory.all));
  }

  Future<void> _onRefresh() async {
    context.read<AuthenticationCubit>().getAccount();

    context
        .read<DashboardEducationBloc>()
        .add(DashboardEducationEvent.getDashboardLessons(currentDate: _selectedDay));

    context.read<EducationProgramBloc>().add(const EducationProgramEvent.getLessons(LessonCategory.all));

    if (context.read<AuthenticationCubit>().state.isFoodLoggingUnlocked) {
      context.read<MealsBloc>().add(const MealsEvent.fetchMeals());
    }

    if (context.read<AuthenticationCubit>().state.isGroupSessionsUnlocked) {
      context.read<TopicsBloc>().add(const TopicsEvent.fetchTopics());
    }
  }

  void _onDaySelected(DateTime day) {
    setState(() {
      _selectedDay = day;
      context.read<DashboardWeightBloc>().add(DashboardWeightEvent.setDate(day));
      context.read<MealsBloc>().add(MealsEvent.setCurrentDate(day, updateOrigin: true));
      context.read<MoodBloc>().add(MoodEvent.setDate(day));
      context
          .read<DashboardEducationBloc>()
          .add(DashboardEducationEvent.getDashboardLessons(currentDate: day));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SliderCalendar(onSelectDay: _onDaySelected),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.bottomRight,
                  scale: 1.03,
                  image: AppImages.dashboardBg,
                ),
              ),
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                child: ScrollableContainer(
                  physics: const AlwaysScrollableScrollPhysics(),
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
                        BlocBuilder<AuthenticationCubit, AuthenticationState>(
                          builder: (BuildContext context, state) {
                            if (!state.isFoodLoggingUnlocked) {
                              return const SizedBox.shrink();
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10.0),
                                BlocBuilder<MealsBloc, MealsState>(
                                  builder: (BuildContext context, state) {
                                    return state.isNeedToHideOnDashboard
                                        ? const SizedBox(height: 0.0)
                                        : const LogMeal();
                                  },
                                ),
                                const SizedBox(height: 10.0),
                                const PlanMeal(),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 10.0),
                        PersonMood(date: _selectedDay),
                        const SizedBox(height: 16.0),
                        Text(
                          LocalizedTexts.activities.translation,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        // const SizedBox(height: 16.0),
                        // const Reflection(),
                        BlocBuilder<AuthenticationCubit, AuthenticationState>(
                          builder: (BuildContext context, state) {
                            if (!state.isGroupSessionsUnlocked) {
                              return const SizedBox.shrink();
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10.0),
                                PhysicalActivities(selectedDay: _selectedDay),
                              ],
                            );
                          },
                        ),
                        BlocBuilder<AuthenticationCubit, AuthenticationState>(
                          builder: (context, state) {
                            if (!state.isGroupSessionsUnlocked) {
                              return const SizedBox.shrink();
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                SizedBox(height: 10.0),
                                SupportGroup(),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 10.0),
                        BlocBuilder<DashboardEducationBloc, DashboardEducationState>(
                          builder: (BuildContext context, state) {
                            return state.maybeMap(
                              error: (errorState) {
                                final error = errorState.data.error;

                                return ErrorScreen(
                                  smallVersion: true,
                                  error: error,
                                  onButtonPressed: () => context
                                      .read<DashboardEducationBloc>()
                                      .add(const DashboardEducationEvent.getDashboardLessons()),
                                );
                              },
                              loading: (_) => const Loader(),
                              orElse: () => state.isVisibleOnDashboard(_selectedDay)
                                  ? Education(date: _selectedDay)
                                  : const SizedBox.shrink(),
                            );
                          },
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }
}
