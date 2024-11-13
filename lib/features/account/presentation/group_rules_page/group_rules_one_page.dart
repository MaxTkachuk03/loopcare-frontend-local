import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_lesson_wrap.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_prefs_page_wrap.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

@RoutePage()
class GroupRulesOnePage extends StatelessWidget {
  const GroupRulesOnePage({super.key});

  void _onContinuePressHandler(BuildContext context) =>
      context.router.pushNamed(AppRoutes.groupRulesTwo);

  @override
  Widget build(BuildContext context) {
    return GroupLessonWrap(
      child: GroupPrefsPageWrap(
        child: CustomSafeArea(
          child: MainContainer(
            child: ScrollableContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // const GroupPrefsProgress(),
                      const SizedBox(height: 28.0),
                      CustomText.bitter500(
                        LocalizedTexts.groupRulesOneTitle.tr(),
                        style: context.textTheme.displayMedium,
                      ),
                      const SizedBox(height: 8.0),
                      CustomText.w600(
                        LocalizedTexts.groupRulesAttention.tr(),
                        style: context.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16.0),
                      CustomText.w400(
                        LocalizedTexts.groupRulesOneParagraphOne.tr(),
                        style: context.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 32.0),
                      CustomText.w400(
                        LocalizedTexts.groupRulesOneParagraphTwo.tr(),
                        style: context.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Column(
                    children: [
                      CustomElevatedButton.blueFullWidth(
                        onPressed: () => _onContinuePressHandler(context),
                        label: LocalizedTexts.continueToTheRules.tr(),
                      ),
                      const SizedBox(height: 30.0),
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
}
