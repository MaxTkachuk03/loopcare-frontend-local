import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/education/domain/extra_action_page_mode.dart';

class NeedPaidSubscriptionPage extends StatelessWidget {
  final ExtraActionPageMode mode;

  const NeedPaidSubscriptionPage({super.key, required this.mode});

  void _onCompleteLessonHandler(BuildContext context) => mode.map(
        afterLesson: (_) => context.router.pushNamed(AppRoutes.lessonComplete),
        userProfile: (_) => context.router.push(
          GenderPreferencesRoute(fromLessonComplete: false),
        ),
      );

  _getScaffold(Widget body) => mode.map(
        afterLesson: (_) => CustomScaffold.petrolLightest(
          appBar: CustomAppBar.petrol(
            title: LocalizedTexts.preferences.tr(),
            leading: CustomFilledIconButton.leadingPetrolLighter(),
          ),
          body: body,
        ),
        userProfile: (_) => CustomScaffold.blueLightest(
          appBar: CustomAppBar.blue(
            title: LocalizedTexts.supportGroupPreferences.tr(),
            leading: CustomFilledIconButton.leadingBlueLighter(),
          ),
          body: body,
        ),
      );

  String get _buttonLabel => mode.map(
        afterLesson: (s) => LocalizedTexts.completeLesson.tr(),
        userProfile: (s) => LocalizedTexts.next.tr(),
      );

  @override
  Widget build(BuildContext context) {
    return _getScaffold(SafeArea(
      child: ScrollableContainer(
        child: MainContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 38.0),
                  CustomText.bitter500(
                    LocalizedTexts.needSubscrionScreenTitle.tr(),
                    style: context.textTheme.displayMedium,
                  ),
                  const SizedBox(height: 24.0),
                  CustomText.w400(
                    LocalizedTexts.needSubscrionScreenBody1.tr(),
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24.0),
                  CustomText.w400(
                    LocalizedTexts.needSubscrionScreenBody2.tr(),
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24.0),
                  CustomText.w400(
                    LocalizedTexts.needSubscrionScreenBody3.tr(),
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24.0),
                  CustomText.w400(
                    LocalizedTexts.needSubscrionScreenBody4.tr(),
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 30.0),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomElevatedButton.blueFullWidth(
                    label: _buttonLabel,
                    onPressed: () => _onCompleteLessonHandler(context),
                  ),
                  const SizedBox(height: 30.0),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
