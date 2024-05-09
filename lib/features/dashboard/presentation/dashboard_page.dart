import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/emergency_btn.dart';
import 'package:loopcare_frontend/features/assignments/application/assignments_bloc.dart';
import 'package:loopcare_frontend/features/assignments/presentation/dashboard_assignments.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/education/education.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/log_meal/log_meal.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/mind/dashboard_mind_widget.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/person_mood/person_mood.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/physical_activities/physical_activities.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/slider_calendar/slider_calendar.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/smart_goals/dashboard_smart_goals.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/support_group.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/weight/weight_block.dart';
import 'package:loopcare_frontend/features/education/application/education_program/education_program_bloc.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/features/mood/application/mood_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_education/dashboard_education_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dashboard_weight_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with WidgetsBindingObserver {
  DateTime _selectedDay = DateTime.now();

  bool get _showEducationWidget {
    final now = DateTime.now();
    return _selectedDay.isBefore(now) || _selectedDay.isAtSameMomentAs(now);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _loadInitialData();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      context.read<TopicsBloc>().add(const TopicsEvent.fetchTopics());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _loadInitialData() {
    context.read<AuthenticationBloc>().add(const AuthenticationEvent.getAccount());

    if (!context.read<NutritionInstructionsBloc>().state.data.alreadyLoaded) {
      context.read<NutritionInstructionsBloc>().add(const NutritionInstructionsEvent.fetchValuesExplanation());
    }

    context
        .read<DashboardWeightBloc>()
        .add(DashboardWeightEvent.fetchWeights(_selectedDay.utsIsoStringWeekBeforeDateWithMidnightTime));

    context.read<MoodBloc>().add(
          MoodEvent.getMoods(
            _selectedDay.utsIsoStringWeekBeforeDateWithMidnightTime,
            DateTime.now().utcIsoStringFormat,
          ),
        );

    context.read<DashboardEducationBloc>().add(DashboardEducationEvent.getDashboardLessons(currentDate: _selectedDay));

    context.read<EducationProgramBloc>().add(const EducationProgramEvent.getLessons());

// TODO: /LOOPCARE-1893
    // if (context.read<AuthenticationCubit>().state.isFoodLoggingUnlocked) {
    context.read<MealsBloc>().add(const MealsEvent.fetchMeals());
    // }

    if (context.read<AuthenticationBloc>().state.data.isAssignmentsUnlocked) {
      context.read<AssignmentsBloc>().add(
            AssignmentsEvent.getAllLessonQuestions(
              _selectedDay.firstDayOfPreviousWeek,
              _selectedDay.lastDayOfCurrentWeek,
            ),
          );
    }
    if (context.read<AuthenticationBloc>().state.data.isSmartGoalUnlocked) {
      context.read<SmartGoalsBloc>().add(
            const SmartGoalsEvent.getWeeklyGoals(),
          );
    }
  }

  Future<void> _onRefresh() async {
    context.read<AuthenticationBloc>().add(const AuthenticationEvent.getAccount());
    // TODO: /LOOPCARE-1893
    //Need wait result this request

    context
        .read<DashboardWeightBloc>()
        .add(DashboardWeightEvent.fetchWeights(_selectedDay.utsIsoStringWeekBeforeDateWithMidnightTime));

    context.read<DashboardEducationBloc>().add(DashboardEducationEvent.getDashboardLessons(currentDate: _selectedDay));
    context.read<EducationProgramBloc>().add(const EducationProgramEvent.getLessons());

    if (context.read<AuthenticationBloc>().state.data.isFoodLoggingUnlocked) {
      context.read<MealsBloc>().add(const MealsEvent.fetchMeals());
    }

    if (context.read<AuthenticationBloc>().state.data.isGroupSessionsUnlocked) {
      context.read<TopicsBloc>().add(const TopicsEvent.fetchTopics());
    }

    if (context.read<AuthenticationBloc>().state.data.isAssignmentsUnlocked) {
      context.read<AssignmentsBloc>().add(
            AssignmentsEvent.getAllLessonQuestions(
              _selectedDay.firstDayOfPreviousWeek,
              _selectedDay.lastDayOfCurrentWeek,
            ),
          );
    }
    if (context.read<AuthenticationBloc>().state.data.isSmartGoalUnlocked) {
      context.read<SmartGoalsBloc>().add(
            const SmartGoalsEvent.getWeeklyGoals(),
          );
    }
  }

  void _onDaySelected(DateTime day) {
    context.read<DashboardWeightBloc>().add(DashboardWeightEvent.setDate(day));
    context.read<MealsBloc>().add(MealsEvent.setCurrentDate(day, updateOrigin: true));
    context.read<MoodBloc>().add(MoodEvent.setDate(day));
    context.read<DashboardEducationBloc>().add(DashboardEducationEvent.getDashboardLessons(currentDate: day));

    if (context.read<AuthenticationBloc>().state.data.isAssignmentsUnlocked) {
      context.read<AssignmentsBloc>().add(
            AssignmentsEvent.getAllLessonQuestions(
              day.firstDayOfPreviousWeek,
              day.lastDayOfCurrentWeek,
            ),
          );
    }

    setState(() {
      _selectedDay = day;
    });
  }

  void _weightListener(BuildContext context, DashboardWeightState state) {
    state.mapOrNull(
      updated: (value) {
        final account = context.read<AuthenticationBloc>().state.data.account;
        final isFreshUser = account?.createdAt != null && (account?.createdAt?.isToday ?? false);

        if (value.data.weights.isEmpty && isFreshUser) {
          context.read<DashboardWeightBloc>().add(DashboardWeightEvent.logWeight(DateTime.now(), account!.weight));
        }
      },
    );
  }

  String _getHelloMessage(String name) {
    final currentHour = DateTime.now().hour;
    final currentMinute = DateTime.now().minute;

    final message = '${LocalizedTexts.hello.tr()}, $name';

    if (currentHour < 5) {
      return message;
    } else if (currentHour < 12) {
      return '${LocalizedTexts.goodMorning.tr()} $name';
    } else if (currentHour < 18) {
      return '${LocalizedTexts.goodAfternoon.tr()} $name';
    } else if (currentHour == 23 && currentMinute < 59 || currentHour < 23) {
      return '${LocalizedTexts.goodEvening.tr()} $name';
    }

    return message;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardWeightBloc, DashboardWeightState>(
      listenWhen: (previous, current) =>
          previous is DashboardWeightStateLoading && current is DashboardWeightStateUpdated,
      listener: _weightListener,
      child: CustomScaffold.blue(
        body: CustomSafeArea(
          child: Column(
            children: [
              SliderCalendar(onSelectDay: _onDaySelected),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ScrollableContainer(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: MainContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 28),
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (context, state) {
                              return CustomText.bitter600(
                                _getHelloMessage(state.data.nameCapitalised),
                                style: context.textTheme.displayMedium?.copyWith(color: AppColors.white),
                              );
                            },
                          ),
                          const SizedBox(height: 26.0),
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (BuildContext context, state) {
                              if (state.data.account?.isSmartGoalsUnlocked ?? false) {
                                return const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DashboardSmartGoals(),
                                    SizedBox(height: 19.0),
                                  ],
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          ),
                          WeightBlock(date: _selectedDay),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 19.0),
                              DashboardMindWidget(),
                            ],
                          ),
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (BuildContext context, state) {
                              if (state.data.account?.isMindUnlocked ?? false) {
                                return const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 19.0),
                                    DashboardMindWidget(),
                                  ],
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          ),
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (BuildContext context, state) {
                              if (state.data.isFoodLoggingUnlocked) {
                                return const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 19.0),
                                    LogMeal(),
                                  ],
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          ),
                          const SizedBox(height: 19.0),
                          PersonMood(date: _selectedDay),
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (context, state) {
                              if (state.data.isPhysicalActivitiesUnlocked) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 19.0),
                                    PhysicalActivities(selectedDay: _selectedDay)
                                  ],
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          ),
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (context, state) {
                              if (state.data.isGroupSessionsUnlocked) {
                                return const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 19.0),
                                    SupportGroup(),
                                  ],
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          ),
                          if (_showEducationWidget) ...[
                            const SizedBox(height: 19.0),
                            Education(date: _selectedDay),
                          ],
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (context, state) {
                              if (state.data.isAssignmentsUnlocked) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 19.0),
                                    DashboardAssignments(date: _selectedDay),
                                  ],
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          ),
                          const SizedBox(height: 19.0),
                          const EmergencyBtn(needBackgroundColor: true),
                          const SizedBox(height: 19.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
