import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/simple_progress_bar.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/account/presentation/edit_food_preferences_page/edit_food_preferences_page.dart';
import 'package:loopcare_frontend/features/account/presentation/food_preferences_page/widgets/section_item.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
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
      'lesson_complete_food_preferences_screen',
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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: SimpleProgressBar.petrol(
                progress: context.read<EducationLessonBloc>().state.data.lessonProgress),
          ),
        ),
        body: SafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 30.0),
                      BlocBuilder<EducationLessonBloc, EducationLessonState>(
                        builder: (context, state) {
                          final lesson = state.data;

                          return SizedBox(height: 265, child: NetworkImageWithCache(url: lesson.lessonImage));
                        },
                      ),
                      const SizedBox(height: 28.0),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CategoryLabel.groupSession(),
                      const SizedBox(height: 18.0),
                      CustomText.bitter600(
                        LocalizedTexts.yourSupportSystem.tr(),
                        style: context.textTheme.displayLarge,
                      ),
                      const SizedBox(height: 18.0),
                      CustomText.w400(
                        LocalizedTexts.supportGroupIntroDesc,
                        style: context.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                  Column(
                    children: [
                      CustomElevatedButton.blueFullWidth(
                        onPressed: () => _onJoinPressed(context),
                        label: LocalizedTexts.yesILikeToJoin,
                      ),
                      // const SizedBox(height: 12.0),
                      // CustomOutlinedButton.blueFullWidth(
                      //   onPressed: () => _onDoNotJoinPressed(context),
                      //   label: LocalizedTexts.joinLater,
                      // ),
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

  _onJoinPressed(BuildContext context) {
    context
      ..read<EducationLessonBloc>().add(const EducationLessonEvent.progressForward())
      ..router.pushNamed(AppRoutes.genderPreferences);
  }

  Future<bool> _onWillPop(BuildContext context) {
    context.read<EducationLessonBloc>().add(const EducationLessonEvent.progressBack());

    return Future.value(true);
  }
}
