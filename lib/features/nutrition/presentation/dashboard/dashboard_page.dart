import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/diary/diary.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/plan_meal/plan_meal.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/reflection/reflection.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/slider_calendar/slider_calendar.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/log_meal/log_meal.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/weight/weight_block.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final bool _isWeightBlocEditable;
  late final bool _isMealBlockEditable;
  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    _isWeightBlocEditable = true;
    _isMealBlockEditable = false;
    context.read<MealsBloc>().add(const MealsEvent.fetchMeals());

    context
        .read<NutritionInstructionsBloc>()
        .add(const NutritionInstructionsEvent.fetchValuesExplanation());
    super.initState();
  }

  void _onDaySelected(DateTime day) {
    setState(() {
      _selectedDay = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: _logoutListener,
      child: Scaffold(
        appBar: const BlueAppBar(),
        body: SafeArea(
          child: ScrollableContainer(
            child: Column(
              children: [
                SliderCalendar(onSelectDay: _onDaySelected),
                MainContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 28),
                      Text(
                        '${LocalizedTexts.goodMorning.translation} ${context.read<AuthenticationCubit>().state.name}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16.0),
                      WeightBlock(
                        date: _selectedDay,
                      ),
                      const SizedBox(height: 8.0),
                      LogMeal(isEditable: _isMealBlockEditable),
                      const SizedBox(height: 8.0),
                      PlanMeal(isEditable: _isMealBlockEditable),
                      const SizedBox(height: 8.0),
                      Diary(isEditable: _isMealBlockEditable),
                      const SizedBox(height: 16.0),
                      Text(
                        LocalizedTexts.activities.translation,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16.0),
                      Reflection(isEditable: _isMealBlockEditable),
                      const SizedBox(height: 8.0),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () => _onLogOutPressed(context),
                            child: const Text('Log out'),
                          ),
                          const SizedBox(height: 40.0)
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  '${snapshot.data?.version}.${snapshot.data?.buildNumber}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 11),
                );
              } else {
                return const Text('');
              }
            },
          ),
        ),
      ),
    );
  }

  _onLogOutPressed(BuildContext context) {
    context.read<AuthenticationCubit>().logout();
  }

  void _logoutListener(BuildContext context, AuthenticationState state) {
    state.mapOrNull(
      guest: (state) {
        context.router.replaceAll([const IntroRoute()]);
      },
    );
  }
}
