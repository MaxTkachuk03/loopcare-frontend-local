import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/account/presentation/edit_food_preferences_page/edit_food_preferences_page.dart';
import 'package:loopcare_frontend/features/account/presentation/food_preferences_page/widgets/section_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/back_button_hexagon/back_button_hexagon.dart';
import 'package:loopcare_frontend/features/you_and_food/application/you_and_food_bloc.dart';

class FoodPreferencesPage extends StatefulWidget {
  const FoodPreferencesPage({Key? key}) : super(key: key);

  @override
  State<FoodPreferencesPage> createState() => _FoodPreferencesPageState();
}

class _FoodPreferencesPageState extends State<FoodPreferencesPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = context.read<YouAndFoodBloc>().state;
    AnalyticsEventService.instance.logFoodPreferencesEvent(
      'food_preferences_screen',
      state.selectedHatesNames,
      state.selectedAllergicNames,
      state.selectedDislikesNames,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          LocalizedTexts.foodPreferences,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ).tr(),
        backgroundColor: AppColors.blueAppBar,
        leading: const BackButtonHexagon(),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32.0),
                BlocBuilder<YouAndFoodBloc, YouAndFoodState>(builder: (BuildContext context, state) {
                  return AccountContainer(
                    child: Column(
                      children: [
                        SectionItem(
                          title: LocalizedTexts.iDoNotEatOrDrink,
                          options: state.selectedHatesNames,
                          onPressHandler: () => context.router
                              .push(EditFoodPreferencesRoute(mode: const EditFoodPreferencesPageMode.hates())),
                        ),
                        const SizedBox(height: 16.0),
                        const Divider(height: 1.0, color: AppColors.yellowLight),
                        const SizedBox(height: 16.0),
                        SectionItem(
                          title: LocalizedTexts.iAmAllergicTo,
                          options: state.selectedAllergicNames,
                          onPressHandler: () => context.router
                              .push(EditFoodPreferencesRoute(mode: const EditFoodPreferencesPageMode.allergies())),
                        ),
                        const SizedBox(height: 16.0),
                        const Divider(height: 1.0, color: AppColors.yellowLight),
                        const SizedBox(height: 16.0),
                        SectionItem(
                          title: LocalizedTexts.iDoNotLike,
                          options: state.selectedDislikesNames,
                          onPressHandler: () => context.router
                              .push(EditFoodPreferencesRoute(mode: const EditFoodPreferencesPageMode.dislikes())),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
