import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/app_version/app_version.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dashboard/dashboard_navbar_items.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/bottom_navigation/bottom_navigation.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/diary/diary.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/explore/explore.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/physical_exercise/physical_exercise.dart';
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
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/support_group/support_group.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/weight/weight_block.dart';

final Map<DashboardNavbarItems, BottomNavigationBarItem> _navBarItems = {
  DashboardNavbarItems.overview: BottomNavigationBarItem(
    icon: const ImageIcon(AppIcons.overview),
    label: DashboardNavbarItems.overview.name,
  ),
  DashboardNavbarItems.explore: BottomNavigationBarItem(
    icon: const ImageIcon(AppIcons.explore),
    label: DashboardNavbarItems.explore.name,
  ),
  DashboardNavbarItems.account: BottomNavigationBarItem(
    icon: const ImageIcon(AppIcons.account),
    label: DashboardNavbarItems.account.name,
  ),
};

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DashboardNavbarItems _selectedNavigationItem = DashboardNavbarItems.overview;

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

  void onNavigationPressed(int index) {
    // TODO do navigation
    setState(() {
      _selectedNavigationItem = DashboardNavbarItems.values[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final String userName = context.read<AuthenticationCubit>().state.name;

    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: _logoutListener,
      child: Scaffold(
        appBar: const BlueAppBar(),
        body: SafeArea(
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
                          const AppVersion(),
                          const SizedBox(height: 28),
                          Text(
                            '${LocalizedTexts.goodMorning.translation} $userName',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 16.0),
                          WeightBlock(
                            date: _selectedDay,
                          ),
                          const SizedBox(height: 10.0),
                          LogMeal(isEditable: _isMealBlockEditable),
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
                          PhysicalExercise(isEditable: _isMealBlockEditable),
                          const SizedBox(height: 10.0),
                          SupportGroup(isEditable: _isMealBlockEditable),
                          const SizedBox(height: 10.0),
                          Explore(isEditable: _isMealBlockEditable),
                          const SizedBox(height: 10.0),
                          ElevatedButton(
                            onPressed: () => _onLogOutPressed(context),
                            child: const Text('Log out'),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigation(
          onItemPress: onNavigationPressed,
          items: _navBarItems.values.toList(),
          selectedItem: _selectedNavigationItem,
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
