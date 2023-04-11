import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    context.read<MealsBloc>().add(const MealsEvent.fetchMeals());

    context
        .read<NutritionInstructionsBloc>()
        .add(const NutritionInstructionsEvent.fetchValuesExplanation());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: _logoutListener,
      child: Scaffold(
        appBar: const BlueAppBar(
          title: 'Dashboard',
        ),
        body: SafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Log your meals',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Hexagon(
                        width: 54,
                        height: 54,
                        borderRadius: 16,
                        innerWidget: Container(
                          color: AppColors.yellowLight,
                          child: IconButton(
                            icon: const ImageIcon(
                              AppIcons.plus,
                              color: AppColors.darkGreen,
                              size: 18,
                            ),
                            onPressed: () =>
                                context.router.pushNamed(AppRoutes.selectFood),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Receipts Details Page',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Hexagon(
                        width: 54,
                        height: 54,
                        borderRadius: 16,
                        innerWidget: Container(
                          color: AppColors.yellowLight,
                          child: IconButton(
                            icon: const ImageIcon(
                              AppIcons.plus,
                              color: AppColors.darkGreen,
                              size: 18,
                            ),
                            onPressed: () =>
                                context.router.pushNamed(AppRoutes.recipe),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'My Dish',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Hexagon(
                        width: 54,
                        height: 54,
                        borderRadius: 16,
                        innerWidget: Container(
                          color: AppColors.yellowLight,
                          child: IconButton(
                            icon: const ImageIcon(
                              AppIcons.plus,
                              color: AppColors.darkGreen,
                              size: 18,
                            ),
                            onPressed: () =>
                                context.router.pushNamed(AppRoutes.dish),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Todays meals screen',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Hexagon(
                        width: 54,
                        height: 54,
                        borderRadius: 16,
                        innerWidget: Container(
                          color: AppColors.yellowLight,
                          child: IconButton(
                            icon: const ImageIcon(
                              AppIcons.plus,
                              color: AppColors.darkGreen,
                              size: 18,
                            ),
                            onPressed: () =>
                                context.router.pushNamed(AppRoutes.meal),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => _onLogOutPressed(context),
                        child: const Text('Log out'),
                      ),
                      const SizedBox(
                        height: 40.0,
                      )
                    ],
                  )
                ],
              ),
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
                  style: TextStyle(fontSize: 11),
                );
              } else {
                return Text('');
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
