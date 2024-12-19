import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/emergency_btn.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/commitment/application/commitment_bloc.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/commitment_dashboard/commitment_dashboard.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/food_logging_dashboard/food_logging_dashboard.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/mind/dashboard_mind_widget.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/person_mood/person_mood.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/physical_activities/physical_activities.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/pool_status/application/pool_bloc/pool_module_bloc.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/pool_status/pool_status_widget.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/slider_calendar/slider_calendar.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/smart_goals/dashboard_smart_goals.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/support_group.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/weight/weight_block.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/features/mind/application/mind_bloc.dart';
import 'package:loopcare_frontend/features/mood/application/mood_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/bmr/bmr_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dashboard_weight_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/reflections/application/reflections_bloc.dart';
import 'package:loopcare_frontend/features/reflections/presentation/reflections_dashboard_widget.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with WidgetsBindingObserver {
  DateTime _selectedDay = DateTime.now();

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
    context.read<BmrBloc>().add(BmrEvent.getBmr(date: _selectedDay));

    context.read<MoodBloc>().add(
          MoodEvent.getMoods(
            _selectedDay.utsIsoStringWeekBeforeDateWithMidnightTime,
            DateTime.now().toIso8601String(),
          ),
        );
    context.read<MealsBloc>()
      ..add(MealsEvent.setCurrentDate(_selectedDay))
      ..add(MealsEvent.fetchMeals(
          startDate: _selectedDay.subtract(const Duration(days: 8)), endDate: _selectedDay));

    context.read<MindBloc>().add(const MindEvent.init());
    context.read<PoolModuleBloc>().add(const PoolModuleEvent.getPoolData());

    updateDashboardData(context.read<AuthenticationBloc>().state);
  }

  Future<void> _onRefresh() async {
    context.read<AuthenticationBloc>().add(const AuthenticationEvent.getAccount());
  }

  void updateDashboardData(AuthenticationState state) {
    context.read<DashboardWeightBloc>().add(
          DashboardWeightEvent.fetchWeights(
              _selectedDay.utsIsoStringWeekBeforeDateWithMidnightTime),
        );

    if (state.data.isFoodLoggingUnlocked) {
      context.read<MealsBloc>().add(MealsEvent.fetchMeals(
            startDate: _selectedDay.subtract(const Duration(days: 8)),
            endDate: _selectedDay,
          ));
    }

    if (state.data.isGroupSessionsUnlocked) {
      context.read<TopicsBloc>().add(const TopicsEvent.fetchTopics());
    }

    if (state.data.isReflectionsUnlocked) {
      context.read<ReflectionsBloc>().add(const ReflectionsEvent.getReflections());
    }

    if (state.data.isSmartGoalUnlocked) {
      context.read<SmartGoalsBloc>().add(SmartGoalsEvent.selectDate(selectedDate: _selectedDay));
      context.read<SmartGoalsBloc>().add(const SmartGoalsEvent.getWeeklyGoals());
    }

    if (state.data.isCommitmentUnlocked) {
      context.read<CommitmentBloc>().add(CommitmentEvent.getCommitment(date: _selectedDay));
    }
  }

  void _accountListener(BuildContext context, AuthenticationState state) {
    state.mapOrNull(gotAccount: updateDashboardData);
  }

  void _onDaySelected(DateTime day) {
    context.read<DashboardWeightBloc>().add(DashboardWeightEvent.setDate(day));
    context.read<MealsBloc>()
      ..add(MealsEvent.setCurrentDate(day))
      ..add(MealsEvent.fetchMeals(startDate: day, endDate: day));
    context.read<MoodBloc>().add(MoodEvent.setDate(day));
    context.read<BmrBloc>().add(BmrEvent.getBmr(date: day));

    if (context.read<AuthenticationBloc>().state.data.isSmartGoalUnlocked) {
      context.read<SmartGoalsBloc>().add(SmartGoalsEvent.selectDate(selectedDate: day));
    }

    handleCommitment(day);

    setState(() {
      _selectedDay = day;
    });
  }

  void _weightLogChangedListener(BuildContext context, DashboardWeightState state) {
    context.read<BmrBloc>().add(BmrEvent.getBmr(date: _selectedDay));
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

  void handleCommitment(DateTime day) {
    final isCommitmentUnlocked = context.read<AuthenticationBloc>().state.data.isCommitmentUnlocked;
    final isFuture = day.isFuture;

    if (isCommitmentUnlocked && !isFuture) {
      context.read<CommitmentBloc>().add(CommitmentEvent.getCommitment(date: day));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listenWhen: (previous, current) => (ModalRoute.of(context)?.isCurrent ?? false),
          listener: _accountListener,
        ),
        BlocListener<DashboardWeightBloc, DashboardWeightState>(
          listenWhen: (prev, cur) =>
              prev is DashboardWeightStateLoading && cur is DashboardWeightStateUpdated,
          listener: _weightLogChangedListener,
        ),
      ],
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
                              return OccludeWrapper(
                                child: CustomText.bitter600(
                                  _getHelloMessage(state.data.nameCapitalised),
                                  style: context.textTheme.displayMedium
                                      ?.copyWith(color: AppColors.white),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 26.0),
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                              builder: (context, state) {
                            if (state.data.emailVerified) {
                              return const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PoolStatusWidget(),
                                  SizedBox(height: 19.0),
                                ],
                              );
                            } else {
                              return const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PoolStatusWidget(),
                                  SizedBox(height: 19.0),
                                ],
                              );
                            }
                          }),
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (BuildContext context, state) {
                              if (state.data.account?.isWeightLoggingUnlocked ?? false) {
                                return Column(
                                  children: [
                                    WeightBlock(
                                        date: _selectedDay,
                                        locked:
                                            state.data.account?.isWeightLoggingUnlocked ?? false),
                                    const SizedBox(height: 19.0),
                                  ],
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          ),
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (BuildContext context, state) {
                              final unlockedGoals =
                                  state.data.account?.isSmartGoalsUnlocked ?? false;
                              return BlocBuilder<SmartGoalsBloc, SmartGoalsState>(
                                builder: (context, state) {
                                  final showSmartGoalsCard = unlockedGoals &&
                                      ((state.data.hasGoalActiveSessions &&
                                              state.data.isDateHasActiveSession(_selectedDay) &&
                                              !_selectedDay.isFuture) ||
                                          _selectedDay.isToday);

                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      DashboardSmartGoals(showSmartGoalsCard: showSmartGoalsCard),
                                      const SizedBox(height: 19.0),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (BuildContext context, state) {
                              // if (state.data.account?.isWeightLoggingUnlocked ??
                              //     false) {
                              return Column(
                                children: [
                                  WeightBlock(
                                      date: _selectedDay,
                                      locked: state.data.account?.isWeightLoggingUnlocked ?? false),
                                  const SizedBox(height: 19.0),
                                ],
                              );
                            },
                          ),
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (BuildContext context, state) {
                              // if (state.data.account?.isMindUnlocked ?? false) {
                              // if (state.data.isReflectionsUnlocked) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ReflectionsDashboardWidget(
                                      date: _selectedDay, locked: state.data.isReflectionsUnlocked),
                                  const SizedBox(height: 19.0),
                                ],
                              );
                            },
                          ),
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (BuildContext context, state) {
                              // if (state.data.isFoodLoggingUnlocked) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FoodLoggingDashboard(
                                      selectedDay: _selectedDay,
                                      locked: state.data.isFoodLoggingUnlocked),
                                  const SizedBox(height: 19.0),
                                ],
                              );
                            },
                          ),
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                              builder: (BuildContext context, state) {
                            final isCommitmentUnlocked = state.data.isCommitmentUnlocked;
                            return BlocBuilder<CommitmentBloc, CommitmentState>(
                              builder: (context, state) {
                                final showCommitment = state.data.showCommitment;

                                if (isCommitmentUnlocked && showCommitment) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CommitmentDashboard(
                                        selectedDay: _selectedDay,
                                      ),
                                      const SizedBox(height: 19.0),
                                    ],
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            );
                          }),
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (BuildContext context, state) {
                              // if (state.data.account?.isWeightLoggingUnlocked ??
                              //     false) {
                              return Column(
                                children: [
                                  WeightBlock(
                                      date: _selectedDay,
                                      locked: state.data.account?.isWeightLoggingUnlocked ?? false),
                                  const SizedBox(height: 19.0),
                                ],
                              );
                            },
                          ),
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (BuildContext context, state) {
                              final unlockedGoals =
                                  state.data.account?.isSmartGoalsUnlocked ?? false;
                              return BlocBuilder<SmartGoalsBloc, SmartGoalsState>(
                                builder: (context, state) {
                                  final showSmartGoalsCard = unlockedGoals &&
                                      ((state.data.hasGoalActiveSessions &&
                                              state.data.isDateHasActiveSession(_selectedDay) &&
                                              !_selectedDay.isFuture) ||
                                          _selectedDay.isToday);

                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      DashboardSmartGoals(showSmartGoalsCard: showSmartGoalsCard),
                                      const SizedBox(height: 19.0),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (BuildContext context, state) {
                              // if (state.data.account?.isMindUnlocked ?? false) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DashboardMindWidget(
                                      locked: state.data.account?.isMindUnlocked ?? false),
                                  const SizedBox(height: 19.0),
                                ],
                              );
                            },
                          ),
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (context, state) {
                              //if (state.data.isGroupSessionsUnlocked) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SupportGroup(locked: state.data.isGroupSessionsUnlocked),
                                  const SizedBox(height: 19.0),
                                ],
                              );
                            },
                          ),
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (context, state) {
                              //if (state.data.isMoodLoggingUnlocked) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PersonMood(
                                      date: _selectedDay, locked: state.data.isMoodLoggingUnlocked),
                                  const SizedBox(height: 19.0),
                                ],
                              );
                            },
                          ),
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (context, state) {
                              // if (state.data.isPhysicalActivitiesUnlocked) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PhysicalActivities(
                                      selectedDay: _selectedDay,
                                      locked: state.data.isPhysicalActivitiesUnlocked),
                                  const SizedBox(height: 19.0),
                                ],
                              );
                            },
                          ),
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
