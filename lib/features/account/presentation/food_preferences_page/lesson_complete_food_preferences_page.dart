import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/edit_food_preferences_page/edit_food_preferences_page.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/category_label.dart';
import 'package:loopcare_frontend/features/you_and_food/application/you_and_food_bloc.dart';

class LessonCompleteFoodPreferencesPage extends StatefulWidget {
  const LessonCompleteFoodPreferencesPage({super.key});

  @override
  State<LessonCompleteFoodPreferencesPage> createState() => _LessonCompleteFoodPreferencesPageState();
}

class _LessonCompleteFoodPreferencesPageState extends State<LessonCompleteFoodPreferencesPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = context.read<YouAndFoodBloc>().state;
    AnalyticsEventService.instance.logFoodPreferencesEvent(
      FirebaseEvents.lessonCompleteFoodPreferencesScreen,
      state.selectedHatesNames,
      state.selectedAllergicNames,
      state.selectedDislikesNames,
    );
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: CustomScaffold.petrolLightest(
        appBar: CustomAppBar.petrol(
          title: LocalizedTexts.preferences.tr(),
          leading: CustomFilledIconButton.leadingPetrolLighter(),
        ),
        body: CustomSafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 8.0),
                      Container(
                          alignment: Alignment.center, child: const Image(image: AppImages.foodPreferences)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CategoryLabel.nutrition(),
                      const SizedBox(height: 18.0),
                      CustomText.bitter600(
                        LocalizedTexts.foodPreferences.tr(),
                        style: context.textTheme.displayLarge,
                      ),
                      const SizedBox(height: 18.0),
                      CustomText.w400(
                        LocalizedTexts.foodPreferencesDesc.tr(),
                        style: context.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 24.0),
                      BulletListItem(
                        text: CustomText.w400(
                          LocalizedTexts.foodPreferencesItemOne.tr(),
                          style: context.textTheme.bodyMedium,
                        ),
                        bulletSize: 18.0,
                      ),
                      BulletListItem(
                        text: CustomText.w400(
                          LocalizedTexts.foodPreferencesItemTwo.tr(),
                          style: context.textTheme.bodyMedium,
                        ),
                        bulletSize: 18.0,
                      ),
                      BulletListItem(
                        text: CustomText.w400(
                          LocalizedTexts.foodPreferencesItemThree.tr(),
                          style: context.textTheme.bodyMedium,
                        ),
                        bulletSize: 18.0,
                      ),
                      BulletListItem(
                        text: CustomText.w400(
                          LocalizedTexts.foodPreferencesItemFour.tr(),
                          style: context.textTheme.bodyMedium,
                        ),
                        bulletSize: 18.0,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                  Column(
                    children: [
                      CustomElevatedButton.blueFullWidth(
                        onPressed: () => _onStartPressed(context),
                        label: LocalizedTexts.start.tr(),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onStartPressed(BuildContext context) {
    context
      ..read<EducationLessonBloc>().add(const EducationLessonEvent.progressForward())
      ..router.push(
        EditFoodPreferencesRoute(
          mode: const EditFoodPreferencesPageMode.allergies(),
          fromLessonComplete: true,
        ),
      );
  }

  Future<bool> _onWillPop(BuildContext context) {
    context.read<EducationLessonBloc>().add(const EducationLessonEvent.progressBack());

    return Future.value(true);
  }
}
