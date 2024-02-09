import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/account/presentation/edit_food_preferences_page/edit_food_preferences_page.dart';
import 'package:loopcare_frontend/features/account/presentation/food_preferences_page/widgets/section_item.dart';
import 'package:loopcare_frontend/features/you_and_food/application/you_and_food_bloc.dart';

class FoodPreferencesPage extends StatefulWidget {
  final bool fromLessonComplete;
  const FoodPreferencesPage({
    super.key,
    required this.fromLessonComplete,
  });

  @override
  State<FoodPreferencesPage> createState() => _FoodPreferencesPageState();
}

class _FoodPreferencesPageState extends State<FoodPreferencesPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = context.read<YouAndFoodBloc>().state;
    AnalyticsEventService.instance.logFoodPreferencesEvent(
      FirebaseEvents.foodPreferencesScreen,
      state.selectedHatesNames,
      state.selectedAllergicNames,
      state.selectedDislikesNames,
    );
  }

  CustomAppBar _getCustomAppBar() {
    if (widget.fromLessonComplete) {
      return CustomAppBar.petrol(
        title: LocalizedTexts.foodPreferences.tr(),
        leading: CustomFilledIconButton.leadingPetrolLighter(),
      );
    }
    return CustomAppBar.blue(
      title: LocalizedTexts.foodPreferences.tr(),
      leading: CustomFilledIconButton.leadingBlueLighter(),
    );
  }

  CustomScaffold _getCustomScaffold({
    Widget? body,
  }) {
    if (widget.fromLessonComplete) {
      return CustomScaffold.petrol(
        appBar: _getCustomAppBar(),
        body: body,
      );
    }
    return CustomScaffold.blue(
      appBar: _getCustomAppBar(),
      body: body,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getCustomScaffold(
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32.0),
                BlocBuilder<YouAndFoodBloc, YouAndFoodState>(
                  builder: (BuildContext context, state) {
                    return AccountContainer(
                      child: Column(
                        children: [
                          SectionItem(
                            title: LocalizedTexts.iDoNotEatOrDrink.tr(),
                            options: state.selectedHatesNames,
                            onPressHandler: () => context.router.push(
                              EditFoodPreferencesRoute(
                                mode: const EditFoodPreferencesPageMode.hates(),
                                fromLessonComplete: widget.fromLessonComplete,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          const Divider(height: 1.0, color: AppColors.yellowLight),
                          const SizedBox(height: 16.0),
                          SectionItem(
                            title: LocalizedTexts.iAmAllergicTo.tr(),
                            options: state.selectedAllergicNames,
                            onPressHandler: () => context.router.push(
                              EditFoodPreferencesRoute(
                                mode: const EditFoodPreferencesPageMode.allergies(),
                                fromLessonComplete: widget.fromLessonComplete,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          const Divider(height: 1.0, color: AppColors.yellowLight),
                          const SizedBox(height: 16.0),
                          SectionItem(
                            title: LocalizedTexts.iDoNotLike.tr(),
                            options: state.selectedDislikesNames,
                            onPressHandler: () => context.router.push(
                              EditFoodPreferencesRoute(
                                mode: const EditFoodPreferencesPageMode.dislikes(),
                                fromLessonComplete: widget.fromLessonComplete,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
