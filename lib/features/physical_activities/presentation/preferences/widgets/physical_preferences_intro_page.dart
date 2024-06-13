import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/category_label.dart';

@RoutePage()
class PhysicalPreferencesIntroPage extends StatelessWidget {
  const PhysicalPreferencesIntroPage({super.key});

  void _onStart(BuildContext context) {
    context.router.pushNamed(AppRoutes.physicalActivitiesFrequency);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.petrolLightest(
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
                    CategoryLabel.physicalActivity(),
                    const SizedBox(height: 18.0),
                    CustomText.bitter600(
                      LocalizedTexts.physicalActivitiesPreferencesLabel.tr(),
                      style: context.textTheme.displayLarge,
                    ),
                    const SizedBox(height: 18.0),
                    CustomText.w400(
                      LocalizedTexts.physicalActivitiesPreferencesDesc.tr(),
                      style: context.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24.0),
                    BulletListItem(
                      text: CustomText.w400(
                        LocalizedTexts.physicalActivitiesPreferencesItemOne.tr(),
                        style: context.textTheme.bodyMedium,
                      ),
                      bulletSize: 18.0,
                    ),
                    BulletListItem(
                      text: CustomText.w400(
                        LocalizedTexts.physicalActivitiesPreferencesItemTwo.tr(),
                        style: context.textTheme.bodyMedium,
                      ),
                      bulletSize: 18.0,
                    ),
                    BulletListItem(
                      text: CustomText.w400(
                        LocalizedTexts.physicalActivitiesPreferencesItemThree.tr(),
                        style: context.textTheme.bodyMedium,
                      ),
                      bulletSize: 18.0,
                    ),
                    const SizedBox(height: 30.0),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: CustomElevatedButton.blueFullWidth(
                    onPressed: () => _onStart(context),
                    label: LocalizedTexts.start.tr(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
